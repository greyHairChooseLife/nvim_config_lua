-- =========================================================================
-- =========================================================================
--                           custom shortcuts
-- =========================================================================
-- =========================================================================
-- MISC TIPS
vim.keymap.set('n', ',q', '<cmd>nohlsearch<CR><cmd>echon<CR>', { silent = true }) -- 검색 기록 제거
vim.keymap.set('n', ',r', function()
  vim.cmd('wincmd =');
  require('nvim-tree.api').tree.toggle({ find_files = true, focus = false })
  require('nvim-tree.api').tree.toggle({ find_files = true, focus = false })
  require('quicker').refresh()
end)                                                                     -- 창 크기 동일하게
vim.keymap.set({ 'n', 'v' }, ',p', '"0p')                                -- paste last thing yanked, not deleted
vim.keymap.set("n", ",C", [[<cmd>%s/<C-r><C-w>//g<Left><Left>]])             -- change word under cursor globally
vim.keymap.set("n", ",ss", "<cmd>sp<CR><cmd>wincmd w<CR><Plug>(coc-definition)") -- go to definition in splitted window (horizontal)
vim.keymap.set("n", ",sv", "<cmd>vs<CR><cmd>wincmd w<CR><Plug>(coc-definition)") -- go to definition in splitted window (vertical)
vim.keymap.set("n", "vv", "viw")                                         -- easy visual block for word
vim.keymap.set({ 'n', 'v' }, 'zo', 'za')                                 -- toggle fold uni-key
vim.keymap.set({ 'n', 'v' }, 'gH', '0')                                  -- move cursor
vim.keymap.set({ 'n', 'v' }, 'gh', '^')                                  -- move cursor
vim.keymap.set({ 'n', 'v' }, 'gl', '$')                                  -- move cursor
vim.keymap.set({ 'n', 'v' }, 'gL', '$')                                  -- move cursor
vim.keymap.set({ 'n' }, ',,p', '"*p')                                    -- easy-paste system clipboard
vim.keymap.set({ 'n' }, "'", '*N')                                       -- search current word
vim.keymap.set('v', "'", '"zy/<C-R>z<CR>N')                              -- 비주얼 모드에서 선택한 텍스트 검색 후 이전 결과로 이동
vim.keymap.set('n', 'j', [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
vim.keymap.set('n', 'k', [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true });

vim.keymap.set({ 'n', 'v' }, ',U', '<Esc>bvU')                                                                           -- CamelCase
vim.keymap.set({ 'n', 'v' }, '<A-Enter>', OnlyThisBufferInCurrentTab)                                                    -- 현재 탭의 현재 버퍼만 남기기
vim.keymap.set({ 'n', 'v' }, '<A-t><CR>', '<cmd>%bdelete<bar>edit#<bar>bdelete#<CR>', { noremap = true, silent = true }) -- 모든 탭 지우고 현재 버퍼만 남기기
vim.keymap.set({ 'n' }, '<A-space>', FocusFloatingWindow, { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<Space>', BlinkCursorLine)

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "p", '"_dP')       -- paste without yanking in visual mode

vim.keymap.set({ 'n', 'v' }, ';', ':') -- repeat last command
vim.keymap.set({ 'n', 'v' }, ':', ';') -- repeat last command
vim.keymap.set({ 'n', 'v' }, 'Q', ',') -- repeat last command

vim.keymap.set('i', ';j', '<ESC>')     -- ESC를 두 번 누르지 않고도 편리하게 나가기
vim.keymap.set({ 'n', 'v' }, '<C-e>', '2<C-e>')
vim.keymap.set({ 'n', 'v' }, '<C-y>', '2<C-y>')
vim.keymap.set( 'n' , ',.<ESC>', '<Nop>') -- do nothing

-- 선택한 줄 이동
vim.keymap.set('x', '<A-k>', '<cmd>move \'<-2<CR>gv-gv')
vim.keymap.set('x', '<A-j>', '<cmd>move \'>+1<CR>gv-gv')


-- 디버깅
vim.keymap.set('i', 'cl<cr>', Insert_console_log, { noremap = true, silent = true })
vim.keymap.set('v', 'cl<cr>', "<cmd><C-U>lua Insert_console_log_Visual()<CR>", { noremap = true, silent = true })


-- BUFFER & WINDOW 관리
vim.keymap.set('n', '<leader>q', '<cmd>q!<CR>')
vim.keymap.set('n', '<leader>bq', '<cmd>bd!<CR>') -- close buffer, saving memory
vim.keymap.set('n', '<leader>Q', '<cmd>qa!<CR>')
vim.keymap.set('n', '<F1>', '<Plug>VimwikiIndex')
vim.keymap.set('n', '<leader>w', function()
  vim.cmd('silent w')
  vim.notify('Saved current buffers', 3, { render = 'minimal' })
end)
vim.keymap.set('n', '<leader>W', function()
  vim.cmd('wa')
  vim.notify('Saved all buffers', 3, { render = 'minimal' })
end)
vim.keymap.set('n', '<leader>e', function()
  vim.cmd('wq')
  vim.notify('Saved last buffers', 3, { render = 'minimal' })
end)
vim.keymap.set('n', '<leader>tq', '<cmd>tabclose!<CR>')
vim.keymap.set('n', '<leader>cp', Save_current_buffer_path)


-- fold는 항상  mkview
vim.keymap.set('n', 'zc', 'zc<cmd>mkview<CR>')
vim.keymap.set('n', 'zo', 'zo<cmd>mkview<CR>')
vim.keymap.set('n', 'zO', 'zO<cmd>mkview<CR>')
vim.keymap.set('n', 'zm', 'zm<cmd>mkview<CR>')
vim.keymap.set('n', 'zM', 'zM<cmd>mkview<CR>')
vim.keymap.set('n', 'zr', 'zr<cmd>mkview<CR>')
vim.keymap.set('n', 'zR', 'zR<cmd>mkview<CR>')
vim.keymap.set('n', 'zf', 'zf<cmd>mkview<CR>')
vim.keymap.set('n', 'zd', 'zd<cmd>mkview<CR>')


-- EASY ALIGN
vim.keymap.set('x', 'al', '<Plug>(LiveEasyAlign)', {})
vim.keymap.set('x', 'tal', '<Plug>(EasyAlign)*||', {})


-- NEW WINDOW & TAB
vim.keymap.set('n', '<A-n>x', '<cmd>rightbelow new<CR>')
vim.keymap.set('n', '<A-n>v', '<cmd>vert rightbelow new<CR>')
vim.keymap.set('n', '<A-n>t', NewTabWithPrompt)
vim.keymap.set('n', '<A-r>', RenameCurrentTab)
vim.keymap.set('n', '<A-m>l', MoveTabRight)
vim.keymap.set('n', '<A-m>h', MoveTabLeft)
-- FOCUS TABS
vim.keymap.set('n', '<A-p>', 'gt')
vim.keymap.set('n', '<A-o>', 'gT')
vim.keymap.set('n', '<A-1>', '1gt')
vim.keymap.set('n', '<A-2>', '2gt')
vim.keymap.set('n', '<A-3>', '3gt')
vim.keymap.set('n', '<A-4>', '4gt')
vim.keymap.set('n', '<A-5>', '5gt')
vim.keymap.set('n', '<A-6>', '6gt')
vim.keymap.set('n', '<A-7>', '7gt')
vim.keymap.set('n', '<A-8>', '8gt')
vim.keymap.set('n', '<A-9>', '9gt')
-- FOCUS WINDOW
vim.keymap.set('n', '<A-h>', '<cmd>wincmd h<CR>')
vim.keymap.set('n', '<A-j>', '<cmd>wincmd j<CR>')
vim.keymap.set('n', '<A-k>', '<cmd>wincmd k<CR>')
vim.keymap.set('n', '<A-l>', '<cmd>wincmd l<CR>')
-- MOVE WINDOW POSITION
vim.keymap.set('n', '<A-H>', '<Cmd>WinShift left<CR>')
vim.keymap.set('n', '<A-J>', '<Cmd>WinShift down<CR>')
vim.keymap.set('n', '<A-K>', '<Cmd>WinShift up<CR>')
vim.keymap.set('n', '<A-L>', '<Cmd>WinShift right<CR>')
vim.keymap.set('n', ',mt', '<C-w>T')        -- move window to tab
vim.keymap.set('n', ',st', '<cmd>sp<CR><C-w>T') -- copy window to tab
-- WINDOW RESIZE
vim.keymap.set("n", "<A-Left>", "<cmd>vertical resize -2<CR>", {})
vim.keymap.set("n", "<A-Right>", "<cmd>vertical resize +2<CR>", {})
vim.keymap.set("n", "<A-Down>", "<cmd>horizontal resize -2<CR>", {})
vim.keymap.set("n", "<A-Up>", "<cmd>horizontal resize +2<CR>", {})
-- WINDOW RESIZE HARD
vim.keymap.set("n", "<A-S-Left>", "<cmd>vertical resize -8<CR>", {})
vim.keymap.set("n", "<A-S-Right>", "<cmd>vertical resize +8<CR>", {})
vim.keymap.set("n", "<A-S-Down>", "<cmd>horizontal resize -8<CR>", {})
vim.keymap.set("n", "<A-S-Up>", "<cmd>horizontal resize +8<CR>", {})
-- WINDOW RESIZE 고정 값으로
-- 잘 안씀
-- vim.keymap.set('n', '<A-R>h', '<cmd>resize ')
-- vim.keymap.set('n', '<A-R>v', '<cmd>vertical resize ')
-- BUFFER FOCUS
vim.keymap.set('n', "<A-'>", '<cmd>bnext<CR>', { silent = true })
vim.keymap.set('n', '<A-;>', '<cmd>bprevious<CR>', { silent = true })


-- NVIM-TREE BUFFER 또는 (조건에 따라)DIFFVIEWFILE PANEL로 즉시 이동
function DiffviewFilePanelFocusConditional()
  local buffers = vim.api.nvim_list_bufs()
  local diffviewOpen = false

  for _, buf in ipairs(buffers) do
    local ft = vim.bo[buf].filetype
    if ft == 'DiffviewFiles' then
      diffviewOpen = true
      break
    end
  end

  if diffviewOpen then
    vim.cmd('DiffviewFocusFiles')
  else
    -- Diffview가 열려 있지 않을 경우, NvimTreeFocus 명령을 실행합니다.
    vim.cmd('NvimTreeFocus')
  end
end

-- vim.keymap.set("n", ",d", DiffviewFilePanelFocusConditional, { silent = true, noremap = true })




-- =========================================================================
-- =========================================================================
--                           plugin shortcuts
-- =========================================================================
-- =========================================================================
-- NVIM-TREE
vim.keymap.set('n', ',,d', function()
  require('nvim-tree.api').tree.toggle({ find_files = true, focus = false })
end)
vim.keymap.set("n", ",d", "<cmd>NvimTreeFocus<CR>") -- focus on nvim-tree right away  -> diffview 쪽이랑 통합했다. 조건부로 동작.


-- TELESCOPE
local builtin = require('telescope.builtin')
vim.keymap.set({ 'n', 'v' }, ',.t', '<Cmd>Telescope toggleterm_manager<CR>', {})
vim.keymap.set('n', ',.f', builtin.find_files, {})
vim.keymap.set('n', ',.w', builtin.live_grep, {})
vim.keymap.set('v', ',.w', 'y<ESC><cmd>Telescope live_grep default_text=<c-r>0<CR>', {})
-- vim.keymap.set('v', ',.c', TelescopeSearchVisual)  visual mode의 ,.w기능과 동일한듯 싶은데? 실 사용도 없어왔고.. 불필요한듯, 2024-08-16
vim.keymap.set('n', ',.c', builtin.grep_string, {})
vim.keymap.set('n', ',.m', builtin.marks, {})
vim.keymap.set('n', ',.b', builtin.buffers, {})
vim.keymap.set('n', ',.H', builtin.help_tags, {})
vim.keymap.set({ 'n', 'i' }, ',.r', builtin.registers, {})
vim.keymap.set('n', ',.R', builtin.resume, {})
vim.keymap.set('n', ',.q', builtin.quickfix, {})
-- vim.keymap.set('n', ',.T', '<cmd>TodoTelescope<CR>', {}) 사실상 안쓰는듯
vim.keymap.set('n', ',.gsts', builtin.git_stash, {})
vim.keymap.set('n', ',.gstt', builtin.git_status, {})
vim.keymap.set('n', ',.gco', function()
  builtin.git_commits({ git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", "--all", "--decorate" } })
end, {})
vim.keymap.set('n', ',.gbco', function() -- 현재 버퍼에 열린 파일에서만 검색
  builtin.git_bcommits({ git_command = { "git", "log", "--pretty=oneline", "--abbrev-commit", "--all", "--decorate" } })
end, {})
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


-- CALENDAR
-- 안씀
-- vim.keymap.set('n', '<leader><leader>C', '<cmd>Calendar<CR>')
-- vim.keymap.set('n', '<leader><leader>S', '<cmd>Startify<CR>')


-- FUGITIVE && GV && DIFFVIEW
-- log 확인
vim.keymap.set('n', '<leader>gl<Space>', '<cmd>GV<CR>')
vim.keymap.set('n', '<leader>gla', '<cmd>GV --all<CR>')
vim.keymap.set('n', '<leader>glr', '<cmd>GV reflog<CR>')
vim.keymap.set('n', '<leader>glf', '<cmd>GV!<CR>')
-- git status 관리
vim.keymap.set('n', '<leader>gq', '<cmd>G<CR>') -- 종료가 gq니까 편리할듯
-- 즉시 커밋, 버퍼가 상단이 아니라 우측에서 열리도록 하고 view는 유지
vim.keymap.set('n', '<leader>cc', '<cmd>silent G commit<CR>', { silent = true })
vim.keymap.set('n', '<leader>ce', '<cmd>silent G commit --amend<CR>', { silent = true })
-- 현재 버퍼 gitdiff 확인
vim.keymap.set('n', ',vd', '<cmd>sp<CR><C-w>T<cmd>Gvdiffsplit<CR><cmd>wincmd l<CR>')
vim.keymap.set('n', ',vD', '<cmd>vert diffsplit ')
-- git review
-- TODO:
-- workflow를 고려해서 재구성할 필요가 있다.
-- 3. (Fetch가 아니라)PR을 받아서 (현재 최신과)비교
vim.keymap.set('n', '<leader>reb', ':DiffviewFileHistory --range=')                      -- 특정 브랜치, 선택해야 한다.
vim.keymap.set('n', '<leader>re<Space>', '<cmd>DiffviewFileHistory<CR>')                     -- 현재 브랜치 히스토리
vim.keymap.set('n', '<leader>rea', '<cmd>DiffviewFileHistory --all<CR>')                     -- 모든 커밋 히스토리
vim.keymap.set('n', '<leader>ref', '<cmd>DiffviewFileHistory %<CR>')                         -- current file only, commit history
vim.keymap.set('n', '<leader>reF', '<cmd>DiffviewFileHistory --reverse --range=HEAD...FETCH_HEAD<CR>') -- something fetched
vim.keymap.set('n', '<leader>res', '<cmd>DiffviewOpen --staged<CR>')                         -- review staged
vim.keymap.set('n', '<leader>rew', '<cmd>DiffviewOpen<CR>')                                  -- review working status, staged + unstaged


-- GITSIGNS
vim.keymap.set("n", "<leader><leader>d", function()
  vim.cmd('Gitsigns toggle_word_diff')
  vim.cmd('Gitsigns toggle_linehl')
end)
vim.keymap.set({ 'n', 'v' }, ']c', '<cmd>silent Gitsigns next_hunk<CR>')                     -- move hunk
vim.keymap.set({ 'n', 'v' }, '[c', '<cmd>silent Gitsigns prev_hunk<CR>')                     -- move hunk
vim.keymap.set('n', 'gsth', '<cmd>Gitsigns stage_hunk<CR><cmd>NvimTreeRefresh<CR>')   -- stage hunk
vim.keymap.set('v', 'gsth', Visual_stage)                                             -- stage hunk
vim.keymap.set('v', 'gstH', Visual_undo_stage)                                        -- stage hunk
vim.keymap.set('n', 'gstb', '<cmd>Gitsigns stage_buffer<CR><cmd>NvimTreeRefresh<CR>') -- stage buffer
vim.keymap.set('n', 'greh', '<cmd>Gitsigns reset_hunk<CR><cmd>NvimTreeRefresh<CR>')   -- reset hunk, de-active
vim.keymap.set('v', 'greh', Visual_reset)                                             -- reset hunk, de-active
vim.keymap.set('n', 'gpre', '<cmd>Gitsigns preview_hunk<CR>')                         -- show diff


-- OUTLINE
vim.keymap.set({ 'n' }, ',,o', "<cmd>Outline<CR>")
vim.keymap.set({ 'n' }, ',o', "<cmd>OutlineFocusOutline<CR>")


-- AUTO-SESSION
vim.keymap.set("n", "<leader><leader>s", "<cmd>SessionSave<CR>") -- save
vim.keymap.set("n", ",.S", require("auto-session.session-lens").search_session, {
  noremap = true,
}) -- search and load


-- LEAP
vim.keymap.set({ 'n', 'v' }, ',l', '<Plug>(leap-forward)')
vim.keymap.set({ 'n', 'v' }, ',L', '<Plug>(leap-backward)')
vim.keymap.set({ 'n' }, ',gl', '<Plug>(leap-from-window)')


-- INDENT-BLANKLINE
vim.keymap.set({ 'n', 'v' }, '<F2>', '<cmd>IBLToggle<CR>')


-- TOGGLETERM
vim.keymap.set({ "n", "v", "t" }, "<C-\\><C-\\>", "<Cmd>99ToggleTerm direction=float name=genaral<CR>", {})



-- NOTE:
-- 이놈들은 정확히 뭐하는건지 모르겠다.
--
-- vim.keymap.set('n', '<leader><leader>o', '<cmd>lua vim.lsp.buf.code_action()<CR>')


-- NOTE:
-- 이놈들은 당분간 안쓰는 것들

-- -- FLUTTER-TOOLS
-- vim.keymap.set('n', '<leader><leader>Fo', '<cmd>FlutterOutlineToggle<CR>') -- toggle widget outline
-- -- GET DOCS OF K AS INDEPENDENTLY
-- vim.keymap.set("n", "<Leader><Leader>K",
--   '<cmd>sp<CR><cmd>wincmd L<CR><CMD>lua _G.show_docs()<CR><cmd>sleep 20ms<CR><cmd>wincmd w<CR><cmd>sp<CR><cmd>wincmd j<CR><cmd>q<CR>')
