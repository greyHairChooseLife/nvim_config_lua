local actions = require('telescope.actions')
local action_layout = require('telescope.actions.layout')
local action_state = require('telescope.actions.state')
local builtin = require('telescope.builtin')
local previewers = require('telescope.previewers')

local function switch_to_normal_mode()
  local escape_key = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
  vim.api.nvim_feedkeys(escape_key, 'n', true)
end

local focus_preview = function(prompt_bufnr)
  local picker = action_state.get_current_picker(prompt_bufnr)
  local prompt_win = picker.prompt_win
  local previewer = picker.previewer
  local winid = previewer.state.winid
  local bufnr = previewer.state.bufnr
  vim.keymap.set({ "n", "v" }, "gq", function()
    actions.close(prompt_bufnr)
  end, { buffer = bufnr })
  vim.keymap.set("n", "i", function()
    vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", prompt_win))
  end, { buffer = bufnr })
  vim.cmd(string.format("noautocmd lua vim.api.nvim_set_current_win(%s)", winid))
  -- api.nvim_set_current_win(winid)
end

-- 프롬프트 내용 초기화
local function clear_prompt()
  local picker = action_state.get_current_picker(vim.api.nvim_get_current_buf())
  picker:reset_prompt() -- 프롬프트 초기화
end

-- install git-delta from pacman
local diff_delta = previewers.new_termopen_previewer({
  get_command = function(entry)
    -- 추적되지 않은 파일
    if entry.status == '??' then return { 'bash', '-c', 'echo "This is an untracked file. No diff available.\n\nJust stage it, so you can have a look."' } end

    -- staged & unstaged
    return { 'git', 'diff', 'HEAD', '--', entry.path }
    -- 원한다면 아래처럼도 가능
    -- return { 'bash', '-c', 'git diff HEAD -- ' .. entry.path }

    -- -- staged only
    -- if entry.status == 'A ' then return { 'git', 'diff', '--cached', entry.path } end
  end
})

local stash_delta = previewers.new_termopen_previewer({
  get_command = function(entry)
    -- 스태시 항목을 선택했을 때 diff 보여주기
    return { 'git', 'stash', 'show', '-p', entry.value }
  end
})

local wide_layout_config = { preview_width = 0.8, width = 0.9, height = 0.9 }

local commits_delta = previewers.new_termopen_previewer({
  get_command = function(entry)
    return { 'git', 'show', entry.value }
  end
})

local function focus_or_open(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local filepath = entry.path or entry.filename
  local bufnr = entry.bufnr  -- buffers picker의 경우에는 bufnr 필드를 참조합니다.
  local lnum = entry.lnum or 1
  local lcol = entry.col or 1

  -- 버퍼 리스트에서 filepath에 해당하는것 있는지 확인
  function is_file_in_buffer_list(filepath)
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
      if vim.api.nvim_buf_is_loaded(buf) and (vim.api.nvim_buf_get_name(buf) == filepath or buf == bufnr) then
        return true, buf
      end
    end
    return false
  end

  local is_loaded, buf = is_file_in_buffer_list(filepath)

  if is_loaded then
    actions.close(prompt_bufnr)

    local wins = vim.api.nvim_list_wins()
    local found_win = false
    for _, win in ipairs(wins) do
      if vim.api.nvim_win_get_buf(win) == buf then
        vim.api.nvim_set_current_win(win)
        found_win = true
      end
    end

    if not found_win then
      vim.api.nvim_set_current_buf(buf)
    end

  else
    actions.file_edit(prompt_bufnr)
  end

  vim.api.nvim_win_set_cursor(0, {lnum, lcol})
end

local function focus_or_open_terminal_buffer(prompt_bufnr)
  local entry = action_state.get_selected_entry()
  local filepath = entry.path or entry.filename
  local bufnr = entry.bufnr  -- 버퍼 선택기에서는 bufnr 필드를 사용

  local function is_buffer_open(filepath, bufnr)
    local buffers = vim.api.nvim_list_bufs()
    for _, buf in ipairs(buffers) do
      if vim.api.nvim_buf_is_loaded(buf) then
        local bufname = vim.api.nvim_buf_get_name(buf)

        -- 파일 경로나 버퍼 번호가 일치하는지 확인
        if bufname == filepath or buf == bufnr then
          -- 모든 탭과 창을 순회하여 버퍼가 열린 창이 있는지 확인
          for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
            for _, win in ipairs(vim.api.nvim_tabpage_list_wins(tab)) do
              if vim.api.nvim_win_get_buf(win) == buf then
                return true, buf  -- 다른 탭이나 창에서 열린 상태라면 true 반환
              end
            end
          end
        end
      end
    end
    return false
  end

  local is_opened, buf = is_buffer_open(filepath, bufnr)

  if is_opened then
    actions.close(prompt_bufnr)

    -- 열려있는 버퍼의 창으로 포커스를 이동
    local wins = vim.api.nvim_list_wins()
    for _, win in ipairs(wins) do
      if vim.api.nvim_win_get_buf(win) == buf then
        vim.api.nvim_set_current_win(win)

        -- picker마다 기본 동작을 유지하기 위해 resume 후 select_default 호출
        builtin.resume()
        vim.schedule(function()
          local new_picker_bufnr = vim.api.nvim_get_current_buf()
          actions.select_default(new_picker_bufnr)
        end)
        return
      end
    end
  else
    -- 버퍼가 열려있지 않다면 선택된 기본 동작을 실행
    actions.select_default(prompt_bufnr)
  end
end

local select_one_or_multi = function(prompt_bufnr, variant)
  -- https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-1991532321
  -- https://github.com/nvim-telescope/telescope.nvim/issues/1048#issuecomment-2177826003
  local picker = action_state.get_current_picker(prompt_bufnr)
  local multi = picker:get_multi_selection()
  if not vim.tbl_isempty(multi) then
    actions.close(prompt_bufnr)
    if variant == 'T' then vim.cmd('tabnew') end

    for _, j in pairs(multi) do
      local filename = j.path or j.filename or j.value
      local lnum = j.lnum or 1
      local lcol = j.col or 1

      if filename ~= nil then
        if variant == 'Enter' then
          vim.cmd(string.format('%s %s', 'edit', filename))
        elseif variant == 'X' then
          vim.cmd(string.format('%s %s', 'below split', filename))
        elseif variant == 'V' or variant == 'T' then
          vim.cmd(string.format('%s %s', 'vsplit', filename))
        end
        -- vim.cmd(string.format("normal! %dG%d|zz", lnum, lcol))
        vim.api.nvim_win_set_cursor(0, {lnum, lcol})
      end
    end

    if variant == 'T' then vim.cmd('wincmd w | q | wincmd p') end
  else
    if variant == 'Enter' then
      focus_or_open(prompt_bufnr)
    elseif variant == 'X' then
      actions.select_horizontal(prompt_bufnr)
      vim.cmd('WinShift down')
      -- builtin.resume() -- picker를 재실행, 연속적으로 선택할 수 있도록
    elseif variant == 'V' then
      actions.select_vertical(prompt_bufnr)
    elseif variant == 'T' then
      actions.select_tab(prompt_bufnr)
    end
  end

  if variant ~= 'T' then
    NvimTreeResetUI()
  end
end

vim.keymap.set('n', ',.gco', function()
  builtin.git_commits({
    git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", "HEAD", "--decorate", "--exclude=refs/stash"  },
    previewer = commits_delta,
    layout_config = wide_layout_config
	})
end)

vim.keymap.set('n', ',.gbco', function()
  builtin.git_bcommits({
    git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", "HEAD", "--decorate", "--exclude=refs/stash"  },
    previewer = commits_delta,
    layout_config = wide_layout_config
  })
end)


vim.keymap.set('n', ',.gd', function()
  builtin.git_status({
    previewer = diff_delta,
    layout_config = wide_layout_config
  })
end, {})

vim.keymap.set('n', ',.gss', function()
  builtin.git_stash({
    previewer = stash_delta,
    layout_config = wide_layout_config
  })
end, {})

vim.keymap.set({ "n", 'v' }, ',.t', function()
  builtin.buffers {
    default_text = 'Term: ',
    prompt_title = 'Terminals',
    attach_mappings = function(_, map)
      map({"i", "n"}, "<CR>", function(_prompt_bufnr) focus_or_open_terminal_buffer(_prompt_bufnr) end)

      -- map({"i", "n"}, "<C-r>", function(_prompt_bufnr)
      --   print "You typed <C-r>"
      -- end)


      map({ "i" }, "<C-r>", function(_prompt_bufnr)
        local default_text = "Term:  " -- 왜인지 두 칸을 띄워야한다.
        vim.cmd('normal! dd')
        vim.cmd('normal! i' .. default_text)
      end)

      map({ "n" }, "<C-r>", function(_prompt_bufnr)
        local default_text = "Term:  " -- 왜인지 두 칸을 띄워야한다.
        vim.cmd('normal! dd')
        vim.cmd('normal! i' .. default_text)
        vim.cmd('startinsert')
      end)

      return true -- default mapping applied as well
    end,
  }
end, {})

-- vim.keymap.set({ 'n', 'v' }, ',.t', '<Cmd>Telescope toggleterm_manager<CR>', {})
vim.keymap.set('n', ',.f', builtin.find_files, {})
vim.keymap.set('v', ',.f', function()
  vim.cmd('normal! y')
  local search_text = vim.fn.getreg('0')
  builtin.find_files({ default_text = search_text })
end, {})
vim.keymap.set('n', ',.w', builtin.live_grep, {})
vim.keymap.set('v', ',.w', function()
  vim.cmd('normal! y')
  local search_text = vim.fn.getreg('0')
  builtin.live_grep({ default_text = search_text })
end, {})
vim.keymap.set('n', ',.c', builtin.grep_string, {})
vim.keymap.set('v', ',.c', function()
  vim.cmd('normal! y')
  local search_text = vim.fn.getreg('0')
  builtin.grep_string({ search = search_text })
end, {})
vim.keymap.set('n', ',.m', builtin.marks, {})
vim.keymap.set('n', ',.b', function()
  CloseEmptyUnnamedBuffers()
  builtin.buffers { file_ignore_patterns = { '^Term:' } } -- 터미널 버퍼는 제외
end, {})
vim.keymap.set('n', ',.H', builtin.help_tags, {})
vim.keymap.set({ 'n', 'i' }, ',.r', builtin.registers, {})
vim.keymap.set('n', ',.R', builtin.resume, {})
vim.keymap.set('n', ',.q', builtin.quickfix, {})
vim.keymap.set('n', ',.o', function() builtin.oldfiles({only_cwd = true}) end, {})
vim.keymap.set('n', ',.T', '<cmd>TodoTelescope<CR>', {})
vim.keymap.set('n', ',.gst', builtin.git_status, {})
vim.keymap.set('n', ',.gbr', builtin.git_branches, {})
-- 현재 버퍼에 열린 파일에서만 검색
vim.keymap.set('n', ',..w', function()
  local scope = vim.fn.expand('%:p')
  builtin.live_grep {
    search_dirs = { scope }
  }
end) -- Regex search current file
vim.keymap.set('v', ',..w', function()
  local scope = vim.fn.expand('%:p')

  vim.cmd('normal! y')
  local text = vim.fn.getreg('0')

  builtin.live_grep {
    search_dirs = { scope },
    default_text = text
  }
end)
vim.keymap.set('n', ',..c', function()
  local scope = vim.fn.expand('%:p')

  builtin.grep_string {
    search_dirs = { scope }
  }
end, {})


require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    },
    hop = {
      -- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
      keys = { "a", "s", "d", "f", "g", "h", "j", "k", "l", ";",
        "q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
        "A", "S", "D", "F", "G", "H", "J", "K", "L", ":",
        "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
        "z", "x", "c", "v", "b", "n", "m", ",", ".", "/",
        "Z", "X", "C", "V", "B", "N", "M", "<", ">", "?",
      },
      -- Highlight groups to link to signs and lines; the below configuration refers to demo
      -- sign_hl typically only defines foreground to possibly be combined with line_hl
      sign_hl = { "WarningMsg", "Title" },
      -- optional, typically a table of two highlight groups that are alternated between
      line_hl = { "CursorLine", "Normal" },
      -- options specific to `hop_loop`
      -- true temporarily disables Telescope selection highlighting
      clear_selection_hl = false,
      -- highlight hopped to entry with telescope selection highlight
      -- note: mutually exclusive with `clear_selection_hl`
      trace_entry = true,
      -- jump to entry where hoop loop was started from
      reset_selection = true,
    },
    coc = {
      prefer_locations = true,    -- always use Telescope locations to preview definitions/declarations/implementations etc
      push_cursor_on_edit = true, -- save the cursor position to jump back in the future
      timeout = 3000,             -- timeout for coc commands
    },
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  },
  defaults = {
    mappings = {
      n = {
        ['gq'] = "close",
        ['<C-g>'] = require("telescope").extensions.hop.hop,
        ['<A-Space>'] = focus_preview,
        ['<A-p>'] = action_layout.toggle_preview,
        ['<A-k>'] = actions.preview_scrolling_up,
        ['<A-j>'] = actions.preview_scrolling_down,
        ['<C-u>'] = actions.results_scrolling_up,
        ['<C-d>'] = actions.results_scrolling_down,
        ["<CR>"] = focus_or_open,
      },
      i = {
        ['<C-r>'] = clear_prompt,
        ['<C-j>'] = actions.move_selection_next,
        ['<C-k>'] = actions.move_selection_previous,
        ['gq'] = "close",
        ['<C-g>'] = require("telescope").extensions.hop.hop,
        ['<A-Space>'] = focus_preview,
        ['<A-p>'] = action_layout.toggle_preview,
        ['<A-k>'] = actions.preview_scrolling_up,
        ['<A-j>'] = actions.preview_scrolling_down,
        ['<C-u>'] = actions.results_scrolling_up,
        ['<C-d>'] = actions.results_scrolling_down,
        ['<C-a>'] = actions.add_to_qflist,
        ['<A-a>'] = actions.add_selected_to_qflist,
        ["<CR>"] = focus_or_open,
        ['<C-Enter>'] = function(prompt_bufnr) select_one_or_multi(prompt_bufnr, 'Enter') end,
        ['<C-x>'] = function(prompt_bufnr) select_one_or_multi(prompt_bufnr, 'X') end,
        ['<C-v>'] = function(prompt_bufnr) select_one_or_multi(prompt_bufnr, 'V') end,
        ['<C-t>'] = function(prompt_bufnr) select_one_or_multi(prompt_bufnr, 'T') end,
      },
    },
    layout_config = {
      horizontal = {
        preview_width = 0.7,
      },
      -- preview_width = 0.7
    },
    set_env = {
      LESS = '',
      DELTA_PAGER = 'less',
    },
  },
  pickers = {
    buffers = {
      mappings = {
        n = {
          ['dd'] = "delete_buffer",
        },
        i = {
          ['<C-d>'] = "delete_buffer"
        },
      },
      ignore_current_buffer = false, -- quickfix에 전체 리스트 넣을 때 불편할 수 있겠다.
      preview = {
        hide_on_startup = true,
      },
      -- file_ignore_patterns = { '^Term:' }, -- buftype으로 체크가 된다!  ignore buffer
    },
    find_files = {
      preview = {
        hide_on_startup = true,
      },
    },
    git_stash = {
      mappings = {
        n = {
          ['dd'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.cmd('Git stash drop ' .. selection.value)
            actions.close(prompt_bufnr)
            builtin.git_stash({
              previewer = stash_delta,
              layout_config = wide_layout_config
            })
            switch_to_normal_mode()
          end,
          ['ap'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.cmd('Git stash apply ' .. selection.value)
            actions.close(prompt_bufnr)
          end,
          ['pp'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.cmd('Git stash pop ' .. selection.value)
            actions.close(prompt_bufnr)
          end,
        },
        i = {
          ['<C-d>'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.cmd('Git stash drop ' .. selection.value)
            actions.close(prompt_bufnr)
            builtin.git_stash({
              previewer = stash_delta,
              layout_config = wide_layout_config
            })
            switch_to_normal_mode()
          end,
          ['<C-a>'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.cmd('Git stash apply ' .. selection.value)
            actions.close(prompt_bufnr)
          end,
          ['<C-p>'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.cmd('Git stash pop ' .. selection.value)
            actions.close(prompt_bufnr)
          end,
        },
      },
    },
  },
}

require("telescope").load_extension("ui-select")
require("telescope").load_extension("hop")
require("telescope").load_extension("coc")
require('telescope').load_extension('fzf')
