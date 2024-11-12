-- NOTE:: 이벤트 종류는 doc에서 아래를 검색하면 나온다.
-- 5. Events					*autocmd-events* *E215* *E216*

vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  callback = function()
    if vim.bo.filetype == 'NvimTree' then
      local api = require('nvim-tree.api')
      local view = require('nvim-tree.view')

      -- gui
      if not view.is_visible() then
        api.tree.open()
      end
    end

    if vim.bo.filetype == 'Avante' then
      vim.cmd("stopinsert")
      vim.opt.signcolumn = "yes"
    end

    if vim.bo.filetype == 'AvanteInput' then
      vim.cmd("stopinsert")
      vim.opt.wrap = true
      vim.defer_fn(function()
        os.execute("xdotool key Escape") -- 영어 입력 모드로 전환 (kime에 ESC 입력 보내기), keyboard layout to English
      end, 200) -- 약간의 딜레이가 필요하다. 왜냐면 내가 <A-hjkl>로 이동할 때 Alt키를 약간 느리게 떼는 경향이 있는데, 그럼 <A-Esc>가 되어버린다. 그래서 Alt키에서 손을 뗄 때까지 약간의 시간을 기다리는 딜레이를 준다.
    end
  end,
})

vim.api.nvim_create_autocmd("TabNew", {
  callback = function()
    local function DiffView탭이면_IBL_끄기()
      local tabname = GetCurrentTabName()
      if tabname == ' Commit' or tabname == ' File' then
        vim.cmd('IBLDisable')
      end
    end

    -- tabname이 커스텀 되는 것도 시간이 걸리기 떄문에, 약간의 딜레이를 줘야한다.
    vim.defer_fn(function()
      DiffView탭이면_IBL_끄기()
    end, 50)
  end,
})

vim.api.nvim_create_autocmd("TabEnter", {
  callback = function()
    local tabname = GetCurrentTabName()
    if tabname == ' Commit' or tabname == ' File' then
      vim.cmd('IBLDisable')
    end
  end,
})

vim.api.nvim_create_autocmd("TabLeave", {
  callback = function()
    local tabname = GetCurrentTabName()
    if tabname == ' Commit' or tabname == ' File' then
      vim.cmd('IBLEnable')
    end
  end,
})


vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.cmd("normal! zR")
    vim.cmd("silent! loadview")

    -- 마지막 커서 위치로 이동
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.fn.line("$") then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- highlight yanked area
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Sneak', timeout = 100 }
  end,
})

-- 파일 저장시 공백 제거
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- 예외 규정
    if vim.bo.filetype == "markdown" then
      return
    end

    -- 제거 로직
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})


-- WARN:  나는 자동완성으로 nvim-cmp가 아니라 coc을 쓰니까 coc-settings.json에 관련 설정을 추가해야한다.
-- -- sql파일 열면 자동완성에 vim-dadbod-completion 추가
-- local cmp = require "cmp"
-- cmp.setup.filetype({ "sql" }, {
--   sources = {
--     { name = "vim-dadbod-completion" },
--     { name = "buffer" },
--   },
-- })

-- SQL 파일 타입에 대해 vim-dadbod-completion.vim을 소스하는 설정
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sql',
  callback = function()
    vim.cmd('source ~/.config/nvim/plugged/vim-dadbod-completion/plugin/vim-dadbod-completion.vim')
  end
})

vim.api.nvim_create_augroup('GV', { clear = true })

-- GV에 탭이름 변경
vim.api.nvim_create_autocmd('FileType', {
  group = 'GV',
  pattern = 'GV',
  callback = function()
    local tabnr = vim.fn.tabpagenr()
    vim.fn.settabvar(tabnr, 'tabname', 'GV')
  end,
})

vim.api.nvim_create_autocmd("CmdlineEnter", {
  callback = function()
    -- -- 명령줄 입력 시에만 활성화
    -- vim.opt.cmdheight = 1
  end,
})

vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    -- -- 명령줄 입력 시에만 활성화
    -- vim.opt.cmdheight = 0
  end,
})
