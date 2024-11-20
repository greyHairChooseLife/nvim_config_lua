local keyset = vim.keymap.set
-- =========================================================================
-- =========================================================================
--                           custom shortcuts
-- =========================================================================
-- =========================================================================
-- MISC TIPS
vim.keymap.set('n', '~', '<cmd>wincmd p<CR>') -- switch to the previous window, last cursor position
vim.keymap.set('n', ',r', ReloadLayout)   -- 창 크기 동일하게
vim.keymap.set({ 'n', 'v' }, ',p', '"0p')                                -- paste last thing yanked, not deleted
vim.keymap.set("n", ",C", [[:%s/<C-r><C-w>//g<Left><Left>]])             -- change word under cursor globally
vim.keymap.set("n", ",sx", "<cmd>sp | wincmd w<CR>") -- go to definition in splitted window (horizontal)
vim.keymap.set("n", ",sv", "<cmd>vs<CR>") -- go to definition in splitted window (vertical)
vim.keymap.set("n", "vv", "viw")                                         -- easy visual block for word
vim.keymap.set({ 'n', 'v' }, 'zo', 'za')                                 -- toggle fold uni-key
vim.keymap.set({ 'n', 'v' }, 'gH', '0')                                  -- move cursor
vim.keymap.set({ 'n', 'v' }, 'gh', '^')                                  -- move cursor
vim.keymap.set({ 'n', 'v' }, 'gl', '$')                                  -- move cursor
vim.keymap.set({ 'n', 'v' }, 'gL', '$')                                  -- move cursor
vim.keymap.set({ 'n' }, ',,p', '"*p')                                    -- easy-paste system clipboard
vim.keymap.set({ 'n' }, "'", ToggleHilightSearch)
vim.keymap.set('v', "'", '"zy/<C-R>z<CR>N')                              -- 비주얼 모드에서 선택한 텍스트 검색 후 이전 결과로 이동
vim.keymap.set('n', 'j', [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
vim.keymap.set('n', 'k', [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true });

vim.keymap.set({ 'n', 'v' }, ',U', '<Esc>bvU')                                                                           -- CamelCase
vim.keymap.set({ 'n' }, '<A-space>', FocusFloatingWindow, { noremap = true, silent = true })
vim.keymap.set({ 'n', 'v' }, '<Space>', BlinkCursorLine)
vim.keymap.set('v', 'v', '<Esc>')
vim.keymap.set('n', ',.ai', "<cmd>OrganizeImport<cr>") -- coc code action
vim.keymap.set({ 'n', 'v', 'i', 'c' }, '<leader>t', "<cmd>TTimerlyToggle<cr>") -- coc code action

-- vim.keymap.set("v", "<", "<gv")
-- vim.keymap.set("v", ">", ">gv")
vim.keymap.set("v", "p", '"_dP')       -- paste without yanking in visual mode

vim.keymap.set({ 'n', 'v' }, ';', ':')
vim.keymap.set({ 'n', 'v' }, ':', ';')
vim.keymap.set({ 'n', 'v' }, 'Q', ',')

vim.keymap.set({ 'i', 'c', 't' }, ';j<Space>', function()
  vim.api.nvim_input('<Esc>') -- 실제 <Esc> 입력을 강제 실행
end, { noremap = true })
vim.keymap.set({ 'i', 'c', 't' }, ';ㅓ<Space>', function()
  vim.api.nvim_input('<Esc>') -- 실제 <Esc> 입력을 강제 실행
  os.execute("xdotool key Escape") -- 영어 입력 모드로 전환 (kime에 ESC 입력 보내기), keyboard layout to English
end, { noremap = true })
vim.keymap.set({ 'n', 'v' }, '<C-e>', '2<C-e>')
vim.keymap.set({ 'n', 'v' }, '<C-y>', '2<C-y>')
vim.keymap.set( 'n' , ',.<ESC>', '<Nop>') -- do nothing

-- 선택한 줄 이동
vim.keymap.set('x', '<A-k>', ':move \'<-2<CR>gv-gv')
vim.keymap.set('x', '<A-j>', ':move \'>+1<CR>gv-gv')
vim.keymap.set("v", "<A-h>", "<gv")
vim.keymap.set("v", "<A-l>", ">gv")

vim.keymap.set('n', '<C-t>', OpenOrFocusTerm)

-- 삽입 도중 undo
vim.keymap.set('i', '<C-h>', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), 'n', true)
  DeleteAndStore()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, true, true), 'n', true)
end, { noremap = true, silent = true })

-- 삽입 도중 redo
vim.keymap.set('i', '<C-l>', function()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), 'n', true)
  PasteFromHistory()
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("a", true, true, true), 'n', true)
end, { noremap = true, silent = true })

-- 디버깅
vim.keymap.set('i', 'cl<cr>', Insert_console_log, { noremap = true, silent = true })
vim.keymap.set('v', 'cl<cr>', "<cmd><C-U>lua Insert_console_log_Visual()<CR>", { noremap = true, silent = true })


-- BUFFER & WINDOW 관리
vim.keymap.set({ 'n', 'v' }, '<A-Enter><Space>', CloseOtherBuffersInCurrentTab)
vim.keymap.set({ 'n', 'v' }, '<A-Enter>t', TabOnlyAndCloseHiddenBuffers)
vim.keymap.set('n', '<leader>Q', '<cmd>qa!<CR>')
vim.keymap.set('n', 'gq', function()
  if vim.fn.winnr('$') == 1 and vim.fn.tabpagenr('$') == 1 then vim.cmd('q')  -- 마지막 탭의 마지막 윈도우라면 걍 끄면 됨
  elseif vim.fn.winnr('$') == 1 and vim.fn.tabpagenr('$') ~= 1 then
    local bufnr = vim.fn.bufnr('%')
    vim.cmd('q')
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  elseif vim.fn.winnr('$') == 2 and require('nvim-tree.api').tree.is_visible() then
    local bufnr = vim.fn.bufnr('%')
    vim.cmd('q')
    if vim.api.nvim_buf_is_valid(bufnr) then
      vim.api.nvim_buf_delete(bufnr, { force = true })
    end
  else vim.cmd('bd!') end
end) -- close buffer, saving memory
vim.keymap.set('n', 'gQ', '<cmd>q<CR>') -- 버퍼를 남겨둘 필요가 있는 경우가 오히려 더 적다. 희안하게 !를 붙이면 hidden이 아니라 active상태다.
vim.keymap.set('n', 'g<Tab>', BufferNextDropLast)
vim.keymap.set('n', 'gw', function()
  vim.cmd('silent w')
  vim.notify('Saved current buffers', 3, { render = 'minimal' })
end)
vim.keymap.set('n', 'gW', function()
  vim.cmd('wa')
  vim.notify('Saved all buffers', 3, { render = 'minimal' })
end)
vim.keymap.set('n', 'ge', function()
  vim.cmd('w')
  -- 현재 윈도우가 마지막 윈도우라면 q로 종료
  if vim.fn.winnr('$') == 1 then vim.cmd('bd')
  else vim.cmd('bd') end
  vim.notify('Saved last buffers', 3, { render = 'minimal' })
end)
vim.keymap.set('n', 'gE', function()
  vim.cmd('wq')
  vim.notify('Saved last buffers', 3, { render = 'minimal' })
end)
vim.keymap.set('n', 'gtQ', '<cmd>tabclose!<CR>')
vim.keymap.set('n', 'gtq', function()
  -- 탭 이름이 'abcd' 라면
  local tabname = GetCurrentTabName()
  if tabname == ' Commit' or tabname == ' File' or tabname == 'GV' or tabname == 'Diff' then
    vim.cmd('tabclose!')
    return
  end

  -- 전체 탭의 개수가 1개라면 아무것도 하지 않고 종료
  if vim.fn.tabpagenr('$') == 1 then
    vim.notify('Cannot close the last tab page', 4, { render = 'minimal' })
    return
  end

  -- 현재 탭의 모든 윈도우를 순회하며 버퍼를 닫음
  -- local tabnr = vim.fn.tabpagenr()  -- 현재 탭 번호 가져오기
  local tabid = vim.api.nvim_get_current_tabpage()  -- 탭 ID 가져오기
  local wins = vim.api.nvim_tabpage_list_wins(tabid) -- 현재 탭의 윈도우 목록 가져오기, 인자로 받는 것은 탭 번호가 아니라 탭 ID

  for _, win in ipairs(wins) do
      local bufnr = vim.api.nvim_win_get_buf(win) -- 윈도우에 연결된 버퍼 번호 가져오기
      vim.api.nvim_buf_delete(bufnr, { force = true }) -- 버퍼 삭제 (force 옵션으로 강제 종료)
  end
end, { noremap = true, silent = true })


vim.keymap.set('n', 'gcp', Save_current_buffer_path)


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
-- vim.keymap.set('x', 'al', '<Plug>(LiveEasyAlign)', {})
-- vim.keymap.set('x', 'tal', '<Plug>(EasyAlign)*||', {})


-- NEW WINDOW & TAB
vim.keymap.set('n', '<A-x>', '<cmd>rightbelow new<CR>')
vim.keymap.set('n', '<A-v>', '<cmd>vnew<CR>')
vim.keymap.set('n', '<A-t>', NewTabWithPrompt)
vim.keymap.set('n', '<A-r>', RenameCurrentTab)
vim.keymap.set('n', '<A-.>', MoveTabRight)
vim.keymap.set('n', '<A-,>', MoveTabLeft)

vim.keymap.set('n', '<A-p>', CocScrollUp)
vim.keymap.set('n', '<A-n>', CocScrollDown)
-- FOCUS TABS
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
vim.keymap.set('n', '<A-j>', CocScrollDown_J)
vim.keymap.set('n', '<A-k>', CocScrollUp_K)
vim.keymap.set('n', '<A-l>', '<cmd>wincmd l<CR>')
-- MOVE WINDOW POSITION
vim.keymap.set('n', '<A-H>', '<Cmd>WinShift left<CR>')
vim.keymap.set('n', '<A-J>', '<Cmd>WinShift down<CR>')
vim.keymap.set('n', '<A-K>', '<Cmd>WinShift up<CR>')
vim.keymap.set('n', '<A-L>', '<Cmd>WinShift right<CR>')
vim.keymap.set('n', ',mt', function() -- move window to tab
  vim.cmd('wincmd T')
  local tabnr = vim.fn.tabpagenr()
  local filename = vim.fn.expand('%:t')
  if filename ~= '' then
    vim.fn.settabvar(tabnr, 'tabname', ' mv: ' .. filename)
  end
end)

vim.keymap.set('n', ',st', function() -- Copy window to new tab
  vim.cmd('split | wincmd T')
  local tabnr = vim.fn.tabpagenr()
  local filename = vim.fn.expand('%:t')
  if filename ~= '' then
    vim.fn.settabvar(tabnr, 'tabname', ' sp: ' .. filename)
  end
end)
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
-- BUFFER FOCUS
vim.keymap.set('n', "<Tab>", NextBuffAfterCleaning)
vim.keymap.set('n', '<S-Tab>', PrevBuffAfterCleaning)

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
vim.keymap.set('n', ',.gg', '<cmd>G<CR>')
-- 즉시 커밋, 버퍼가 상단이 아니라 우측에서 열리도록 하고 view는 유지
vim.keymap.set('n', '<leader>cc', '<cmd>silent G commit<CR>', { silent = true })
vim.keymap.set('n', '<leader>ce', '<cmd>silent G commit --amend<CR>', { silent = true })
-- 현재 버퍼 gitdiff 확인
vim.keymap.set('n', ',vd', VDiffSplitOnTab)
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
vim.keymap.set('v', '<leader>re', DiffviewOpenWithVisualHash) -- gbl로 gitsigns blame line을 확인하고, 커밋의 변경사항을 확인


-- GITSIGNS
vim.keymap.set("n", "<leader><leader>d", function()
  vim.cmd('Gitsigns toggle_word_diff')
  vim.cmd('Gitsigns toggle_linehl')
end)
vim.keymap.set('n', 'gsth', '<cmd>Gitsigns stage_hunk | NvimTreeRefresh<CR>')   -- stage hunk
vim.keymap.set('v', 'gsth', Visual_stage)                                             -- stage hunk
vim.keymap.set('v', 'gstH', Visual_undo_stage)                                        -- stage hunk
vim.keymap.set('n', 'gstb', '<cmd>Gitsigns stage_buffer | NvimTreeRefresh<CR>') -- stage buffer
vim.keymap.set('n', 'greh', '<cmd>Gitsigns reset_hunk | NvimTreeRefresh<CR>')   -- reset hunk, de-active
vim.keymap.set('v', 'greh', Visual_reset)                                             -- reset hunk, de-active
vim.keymap.set('n', 'gpre', '<cmd>Gitsigns preview_hunk<CR>')                         -- show diff
vim.keymap.set('n', 'gbl', '<cmd>Gitsigns blame_line<CR>')                         -- show diff


-- OUTLINE to AERIAL
-- vim.keymap.set({ 'n' }, ',,o', "<cmd>Outline<CR>")
-- vim.keymap.set({ 'n' }, ',o', "<cmd>OutlineFocusOutline<CR>")
vim.keymap.set("n", ",,a", function()
  vim.cmd('AerialToggle')
  vim.cmd('wincmd p')
end)
vim.keymap.set("n", ",a", "<cmd>AerialOpen<CR>")

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


-- REMOVE KEYMAP FROM NO-WHERE
vim.api.nvim_create_autocmd("VimEnter", {
  callback = function()
    pcall(vim.keymap.del, 'i', '<C-G>s')
    pcall(vim.keymap.del, 'i', '<C-G>S')
  end,
})


-- FOLD MOVE
vim.keymap.set({ 'n', 'v' }, '<C-j>', 'zjw')
vim.keymap.set({ 'n', 'v' }, '<C-k>', 'zkw')
vim.keymap.set({ 'n', 'v' }, '<C-h>', '[zw')
vim.keymap.set({ 'n', 'v' }, '<C-l>', ']zw')
vim.keymap.set({ 'n', 'v' }, '<C-n>', '%][%zz')
vim.keymap.set({ 'n', 'v' }, '<C-p>', '[]%zz')

vim.keymap.set({ 'n', 'v' }, '<C-q>', '<Cmd>Focus<CR>')

vim.keymap.set("n", "<leader>y", Save_entire_buffer_to_register_for_AI_prompt, { noremap = true, silent = true })
vim.keymap.set("v", "<leader>y", Save_visual_selection_to_register_for_AI_prompt, { noremap = true, silent = true })
