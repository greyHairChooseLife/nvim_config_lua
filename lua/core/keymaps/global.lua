-- =========================================================================
-- =========================================================================
--                           custom shortcuts
-- =========================================================================
-- =========================================================================
-- MISC TIPS
vim.keymap.set('n', ',q', ':nohlsearch<CR>:echon<CR>', { silent = true }) -- 검색 기록 제거
-- vim.keymap.set('n', ',r', ':wincmd =<CR>', { silent = true })            -- 창 크기 동일하게
vim.keymap.set('n', ',r', function()
  vim.cmd('wincmd =');
  vim.cmd('NvimTreeRefresh')
end)                                                                     -- 창 크기 동일하게
vim.keymap.set({ 'n', 'v' }, ',p', '"0p')                                -- paste last thing yanked, not deleted
vim.keymap.set("n", ",C", [[:%s/<C-r><C-w>//g<Left><Left>]])             -- change word under cursor globally
vim.keymap.set("n", ",ss", ":sp<CR>:wincmd w<CR><Plug>(coc-definition)") -- go to definition in splitted window (horizontal)
vim.keymap.set("n", ",sv", ":vs<CR>:wincmd w<CR><Plug>(coc-definition)") -- go to definition in splitted window (vertical)
vim.keymap.set("n", "vv", "viw")                                         -- easy visual block for word
vim.keymap.set({ 'n', 'v' }, 'zo', 'za')                                 -- toggle fold uni-key
vim.keymap.set({ 'n', 'v' }, 'gH', '0')                                  -- move cursor
vim.keymap.set({ 'n', 'v' }, 'gh', '^')                                  -- move cursor
vim.keymap.set({ 'n', 'v' }, 'gl', '$')                                  -- move cursor
vim.keymap.set({ 'n', 'v' }, 'gL', '$')                                  -- move cursor
vim.keymap.set({ 'n' }, ',,p', '"*p')                                    -- easy-paste system clipboard
vim.keymap.set({ 'n' }, "'", '*N')                                       -- search current word
vim.keymap.set({ 'n', 'v' }, ',U', '<Esc>bvU')                           -- search current word
vim.keymap.set({ 'n' }, '<A-Enter>', ':on<CR>')                          -- for :on command
vim.keymap.set({ 'v' }, '<A-Enter>', '<Esc>:on<CR>')                     -- for :on command
vim.keymap.set({ 'n' }, '<A-space>', FocusFloatingWindow, { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<Space>', BlinkCursorLine)

vim.keymap.set("v", "<", "<gv")
vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "p", '"_dP') -- paste without yanking in visual mode

-- 선택한 줄 이동
-- vim.keymap.set("v", "<A-k>", ":m .-2<CR>==gv")
-- vim.keymap.set("v", "<A-j>", ":m .+1<CR>==gv")
vim.keymap.set('x', '<A-k>', ':move \'<-2<CR>gv-gv')
vim.keymap.set('x', '<A-j>', ':move \'>+1<CR>gv-gv')


-- 디버깅
vim.keymap.set('i', 'cl<cr>', Insert_console_log, { noremap = true, silent = true })
vim.keymap.set('v', 'cl<cr>', ":<C-U>lua Insert_console_log_Visual()<CR>", { noremap = true, silent = true })


-- BUFFER & WINDOW 관리
vim.keymap.set('n', '<leader>q', ':q!<CR>')
vim.keymap.set('n', '<leader>bq', ':bd!<CR>') -- close buffer, saving memory
vim.keymap.set('n', '<leader>Q', ':qa!<CR>')
vim.keymap.set('n', '<leader>w', function()
  vim.cmd('w')
  vim.notify('Saved current buffers', 3, { render = 'minimal' })
  vim.cmd('echon')
end)
vim.keymap.set('n', '<leader>W', function()
  vim.cmd('wa')
  vim.notify('Saved all buffers', 3, { render = 'minimal' })
end)
vim.keymap.set('n', '<leader>e', function()
  vim.cmd('wq')
  vim.notify('Saved last buffers', 3, { render = 'minimal' })
end)
vim.keymap.set('n', '<leader>tq', ':tabclose!<CR>')
vim.keymap.set('n', '<leader>cp', Save_current_buffer_path)


-- fold는 항상  mkview
vim.keymap.set('n', 'zc', 'zc:mkview<CR>')
vim.keymap.set('n', 'zo', 'zo:mkview<CR>')
vim.keymap.set('n', 'zO', 'zO:mkview<CR>')
vim.keymap.set('n', 'zm', 'zm:mkview<CR>')
vim.keymap.set('n', 'zM', 'zM:mkview<CR>')
vim.keymap.set('n', 'zr', 'zr:mkview<CR>')
vim.keymap.set('n', 'zR', 'zR:mkview<CR>')


-- EASY ALIGN
vim.keymap.set('x', 'al', '<Plug>(LiveEasyAlign)', {})
vim.keymap.set('x', 'tal', '<Plug>(EasyAlign)*||', {})


-- NEW WINDOW & TAB
vim.keymap.set('n', '<A-n>x', ':rightbelow new<CR>')
vim.keymap.set('n', '<A-n>v', ':vert rightbelow new<CR>')
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
vim.keymap.set('n', '<A-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<A-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<A-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<A-l>', ':wincmd l<CR>')
-- MOVE WINDOW POSITION
vim.keymap.set('n', '<A-H>', '<Cmd>WinShift left<CR>')
vim.keymap.set('n', '<A-J>', '<Cmd>WinShift down<CR>')
vim.keymap.set('n', '<A-K>', '<Cmd>WinShift up<CR>')
vim.keymap.set('n', '<A-L>', '<Cmd>WinShift right<CR>')
vim.keymap.set('n', ',mt', '<C-w>T')        -- move window to tab
vim.keymap.set('n', ',st', ':sp<CR><C-w>T') -- copy window to tab
-- WINDOW RESIZE
vim.keymap.set("n", "<A-Left>", ":vertical resize -2<CR>", {})
vim.keymap.set("n", "<A-Right>", ":vertical resize +2<CR>", {})
vim.keymap.set("n", "<A-Down>", ":horizontal resize -2<CR>", {})
vim.keymap.set("n", "<A-Up>", ":horizontal resize +2<CR>", {})
-- WINDOW RESIZE HARD
vim.keymap.set("n", "<A-S-Left>", ":vertical resize -8<CR>", {})
vim.keymap.set("n", "<A-S-Right>", ":vertical resize +8<CR>", {})
vim.keymap.set("n", "<A-S-Down>", ":horizontal resize -8<CR>", {})
vim.keymap.set("n", "<A-S-Up>", ":horizontal resize +8<CR>", {})
-- WINDOW RESIZE 고정 값으로
-- 잘 안씀
-- vim.keymap.set('n', '<A-R>h', ':resize ')
-- vim.keymap.set('n', '<A-R>v', ':vertical resize ')
-- BUFFER FOCUS
vim.keymap.set('n', "<A-'>", ':bnext<CR>', { silent = true })
vim.keymap.set('n', '<A-;>', ':bprevious<CR>', { silent = true })


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

vim.keymap.set("n", ",d", DiffviewFilePanelFocusConditional, { silent = true, noremap = true })




-- =========================================================================
-- =========================================================================
--                           plugin shortcuts
-- =========================================================================
-- =========================================================================
-- NVIM-TREE
vim.keymap.set('n', ',,d', function()
  require('nvim-tree.api').tree.toggle({ find_files = true, focus = false })
end)
--vim.keymap.set("n", ",d", ":NvimTreeFocus<CR>") -- focus on nvim-tree right away  -> diffview 쪽이랑 통합했다. 조건부로 동작.


-- TELESCOPE
local builtin = require('telescope.builtin')
vim.keymap.set('n', ',.f', builtin.find_files, {})
vim.keymap.set('n', ',.w', builtin.live_grep, {})
vim.keymap.set('v', ',.w', 'y<ESC>:Telescope live_grep default_text=<c-r>0<CR>', {})
vim.keymap.set('n', ',.c', builtin.grep_string, {})
vim.keymap.set('n', ',.m', builtin.marks, {})
vim.keymap.set('n', ',.b', builtin.buffers, {})
vim.keymap.set('n', ',.H', builtin.help_tags, {})
vim.keymap.set('n', ',.r', builtin.registers, {})
vim.keymap.set('n', ',.T', '<cmd>TodoTelescope<CR>', {})
vim.keymap.set('v', ',.c', TelescopeSearchVisual)
vim.keymap.set('n', ',.gsts', builtin.git_stash, {})
vim.keymap.set('n', ',.gstt', builtin.git_status, {})
vim.keymap.set('n', ',.gco', builtin.git_commits, {})
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
-- vim.keymap.set('n', '<leader><leader>C', ':Calendar<CR>')
-- vim.keymap.set('n', '<leader><leader>S', ':Startify<CR>')


-- FUGITIVE && GV && DIFFVIEW
-- log 확인
vim.keymap.set('n', '<leader>glg', ':GV --graph<CR>')
vim.keymap.set('n', '<leader>glf', ':GV!<CR>')
-- git status 관리
vim.keymap.set('n', '<leader>gg', ':G<CR>')
-- 즉시 커밋
vim.keymap.set('n', '<leader>cc', ':G commit<CR>')
vim.keymap.set('n', '<leader>ce', ':G commit --amend<CR>')
-- 현재 버퍼 gitdiff 확인
vim.keymap.set('n', ',vd', ':sp<CR><C-w>T:Gvdiffsplit<CR>:wincmd l<CR>')
-- git review
-- TODO:
-- workflow를 고려해서 재구성할 필요가 있다.
-- 1. remote에서 fetch 한 것과 local 최신을 비교
-- 2. 특정 커밋과 직전 커밋의 변경 내역 비교
-- 3. PR을 받아서 (현재 최신과)비교
-- 4. 다양한 range적용
-- * 이것들을 임의 입력하는게 아니라 설명과 함께 telescope에서 선택할 수 있도록 하면 좋겠다. fzf처럼
vim.keymap.set('n', '<leader>rer', ':DiffviewFileHistory --range=origin')
vim.keymap.set('n', '<leader>rec', ':DiffviewFileHistory --range=origin/main...HEAD<CR>')
vim.keymap.set('n', '<leader>rea', ':DiffviewFileHistory<CR>')
vim.keymap.set('n', '<leader>ref', ':DiffviewFileHistory %<CR>')
vim.keymap.set('n', '<leader>reF', ':DiffviewFileHistory --range=HEAD...FETCH_HEAD<CR>')
vim.keymap.set('n', '<leader>res', ':DiffviewOpen --staged<CR>')
vim.keymap.set('n', '<leader>rew', ':DiffviewOpen<CR>')


-- GITSIGNS
vim.keymap.set("n", "<leader><leader>d", ":Gitsigns toggle_word_diff<CR>")            -- word diff
vim.keymap.set({ 'n', 'v' }, ']c', '<cmd>Gitsigns next_hunk<CR>')                     -- move hunk
vim.keymap.set({ 'n', 'v' }, '[c', '<cmd>Gitsigns prev_hunk<CR>')                     -- move hunk
vim.keymap.set('n', 'gsth', '<cmd>Gitsigns stage_hunk<CR><cmd>NvimTreeRefresh<CR>')   -- stage hunk
vim.keymap.set('v', 'gsth', Visual_stage)                                             -- stage hunk
vim.keymap.set('v', 'gstH', Visual_undo_stage)                                        -- stage hunk
vim.keymap.set('n', 'gstb', '<cmd>Gitsigns stage_buffer<CR><cmd>NvimTreeRefresh<CR>') -- stage buffer
vim.keymap.set('n', 'greh', '<cmd>Gitsigns reset_hunk<CR><cmd>NvimTreeRefresh<CR>')   -- reset hunk, de-active
vim.keymap.set('v', 'greh', Visual_reset)                                             -- reset hunk, de-active
vim.keymap.set('n', 'gpre', '<cmd>Gitsigns preview_hunk<CR>')                         -- show diff


-- OUTLINE
vim.keymap.set({ 'n' }, ',,o', ":Outline<CR>")
vim.keymap.set({ 'n' }, ',o', ":OutlineFocusOutline<CR>")


-- AUTO-SESSION
vim.keymap.set("n", "<leader><leader>s", ":SessionSave<CR>") -- save
vim.keymap.set("n", ",.S", require("auto-session.session-lens").search_session, {
  noremap = true,
}) -- search and load


-- LEAP
vim.keymap.set({ 'n', 'v' }, ',l', '<Plug>(leap-forward)')
vim.keymap.set({ 'n', 'v' }, ',L', '<Plug>(leap-backward)')
vim.keymap.set({ 'n' }, ',gl', '<Plug>(leap-from-window)')


-- INDENT-BLANKLINE
vim.keymap.set({ 'n', 'v' }, '<F2>', '<cmd>IBLToggle<CR>')


-- VIMWIKI
vim.keymap.set('i', ',T', '<ESC>:VimwikiTable ')




-- =========================================================================
-- =========================================================================
--                           특정 모드로 진입
-- =========================================================================
-- =========================================================================
vim.keymap.set('n', ',,q', QF_ToggleList, { noremap = true, silent = true })





-- NOTE:
-- 이놈들은 정확히 뭐하는건지 모르겠다.
--
-- vim.keymap.set('n', '<leader><leader>o', ':lua vim.lsp.buf.code_action()<CR>')


-- NOTE:
-- 이놈들은 당분간 안쓰는 것들

-- -- FLUTTER-TOOLS
-- vim.keymap.set('n', '<leader><leader>Fo', ':FlutterOutlineToggle<CR>') -- toggle widget outline
-- -- GET DOCS OF K AS INDEPENDENTLY
-- vim.keymap.set("n", "<Leader><Leader>K",
--   ':sp<CR>:wincmd L<CR><CMD>lua _G.show_docs()<CR>:sleep 20ms<CR>:wincmd w<CR>:sp<CR>:wincmd j<CR>:q<CR>')
