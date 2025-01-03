local map = vim.keymap.set
local opt = { noremap = true, silent = true }

-- MEMO:: 이거 없으면 일부 터미널에서 한글 입력시 문제가 발생한다.
-- (의도) "저는 오늘 저녁으로 김치를 먹었습니다."
-- (결과) "저 는오 늘저녁으 로김치 를먹었습니다."
map("i", "<Space>", function()
	vim.defer_fn(function()
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Space>", true, false, true), "n", true)
	end, 20)
end, opt)

-- =========================================================================
-- =========================================================================
--                           custom shortcuts
-- =========================================================================
-- =========================================================================
-- MISC TIPS
map("n", "~", "<cmd>wincmd p<CR>") -- switch to the previous window, last cursor position
map("n", ",r", ReloadLayout) -- 창 크기 동일하게
map({ "n", "v" }, ",p", '"0p') -- paste last thing yanked, not deleted
map("n", ",C", [[:%s/<C-r><C-w>//g<Left><Left>]]) -- change word under cursor globally
map("n", ",sx", "<cmd>sp | wincmd w<CR>") -- go to definition in splitted window (horizontal)
map("n", ",sv", "<cmd>vs<CR>") -- go to definition in splitted window (vertical)
map("n", "vv", "viw") -- easy visual block for word
map({ "n", "v" }, "zo", "za") -- toggle fold uni-key
map({ "n", "v" }, "zz", "zz5<C-e>") -- toggle fold uni-key
map({ "n", "v" }, "gH", "0") -- move cursor
map({ "n", "v" }, "gh", "^") -- move cursor
map({ "n", "v" }, "gl", "$") -- move cursor
map({ "n", "v" }, "gL", "$") -- move cursor
map({ "n" }, ",,p", '"*p') -- easy-paste system clipboard
map("n", "'", ToggleHilightSearch)
-- map('v', "'", '"zy/<C-R>z<CR>N')                              -- 비주얼 모드에서 선택한 텍스트 검색 후 이전 결과로 이동
map("v", "'", HilightSearch) -- 비주얼 모드에서 선택한 텍스트 검색 후 이전 결과로 이동
map("n", "j", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'j']], { expr = true })
map("n", "k", [[(v:count > 1 ? 'm`' . v:count : 'g') . 'k']], { expr = true })

map({ "n", "v" }, ",U", "<Esc>bvU") -- CamelCase
map({ "n" }, "<A-space>", FocusFloatingWindow, opt)
map({ "n" }, "<Space>", function()
	vim.cmd("Twilight")
	BlinkCursorLine()
end)
map("v", "v", "<Esc>")
map({ "n", "v", "i", "c" }, "<leader>t", "<cmd>TTimerlyToggle<cr>")
map("v", "<Space>", ":'<,'>FocusHere<CR>", opt)
map("n", ",<Space>", "<cmd>FocusClear<CR>", opt)

-- map("v", "<", "<gv")
-- map("v", ">", ">gv")
map("v", "p", '"_dP') -- paste without yanking in visual mode

map({ "n", "v" }, ";", ":")
map({ "n", "v" }, ":", ";")
map({ "n", "v" }, "Q", ",")

map({ "i", "c", "t" }, ";j<Space>", function()
	vim.api.nvim_input("<Esc>") -- 실제 <Esc> 입력을 강제 실행
end, { noremap = true })
map({ "i", "c", "t" }, ";ㅓ<Space>", function()
	vim.api.nvim_input("<Esc>") -- 실제 <Esc> 입력을 강제 실행
	os.execute("xdotool key Escape") -- 영어 입력 모드로 전환 (kime에 ESC 입력 보내기), keyboard layout to English
end, { noremap = true })
map({ "n", "v" }, "<C-e>", "2<C-e>")
map({ "n", "v" }, "<C-y>", "2<C-y>")
map("n", ",.<ESC>", "<Nop>") -- do nothing

-- 선택한 줄 이동
map("x", "<A-k>", ":move '<-2<CR>gv-gv")
map("x", "<A-j>", ":move '>+1<CR>gv-gv")
map("v", "<A-h>", "<gv")
map("v", "<A-l>", ">gv")

map("n", "<C-t>", OpenOrFocusTerm)

-- 삽입 도중 undo
map("i", "<C-h>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
	DeleteAndStore()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("i", true, true, true), "n", true)
end, opt)

-- 삽입 도중 redo
map("i", "<C-l>", function()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, true, true), "n", true)
	PasteFromHistory()
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("a", true, true, true), "n", true)
end, opt)

-- 디버깅
map("i", "cl<cr>", Insert_console_log, opt)
-- DEPRECATED:: 2024-12-30, 한번 snippet으로 해보자
-- map("v", "cl<cr>", Insert_console_log_Visual, opt)

-- BUFFER & WINDOW 관리
map({ "n", "v" }, "<A-Enter><Space>", function()
	local utils = require("core.utils")
	local is_tree_visible = utils.tree:is_visible()

	CloseOtherBuffersInCurrentTab()

	if is_tree_visible then
		utils.tree:open()
	end
end)
map({ "n", "v" }, "<A-Enter>t", TabOnlyAndCloseHiddenBuffers)
map("n", "<leader>Q", "<cmd>qa!<CR>")
map("n", "gq", ManageBuffer_gq)
-- DEPRECATED::, 2024-12-24 향후 문제 없으면 제거
-- map('n', 'gq', function()
--   if vim.fn.winnr('$') == 1 and vim.fn.tabpagenr('$') == 1 then vim.cmd('q')  -- 마지막 탭의 마지막 윈도우라면 걍 끄면 됨
--   elseif vim.fn.winnr('$') == 1 and vim.fn.tabpagenr('$') ~= 1 then
--     local bufnr = vim.fn.bufnr('%')
--     vim.cmd('q')
--     if vim.api.nvim_buf_is_valid(bufnr) then
--       vim.api.nvim_buf_delete(bufnr, { force = true })
--     end
--   elseif vim.fn.winnr('$') == 2 and require('nvim-tree.api').tree.is_visible() then
--     local bufnr = vim.fn.bufnr('%')
--     vim.cmd('q')
--     if vim.api.nvim_buf_is_valid(bufnr) then
--       vim.api.nvim_buf_delete(bufnr, { force = true })
--     end
--   else vim.cmd('bd!') end
-- end) -- close buffer, saving memory
map("n", "qq", "<cmd>q<CR>") -- 버퍼를 남겨둘 필요가 있는 경우가 오히려 더 적다. 희안하게 !를 붙이면 hidden이 아니라 active상태다.
map("n", "g<Tab>", BufferNextDropLast)
map("n", "gw", function()
	vim.cmd("silent w")
	vim.notify("Saved current buffers", 3, { render = "minimal" })
end)
map("n", "gW", function()
	vim.cmd("wa")
	vim.notify("Saved all buffers", 3, { render = "minimal" })
end)

map("n", "ge", ManageBuffer_ge)
-- DEPRECATED:: 2024-12-24 향후 문제 없으면 제거
-- map('n', 'ge', function()
--   vim.cmd('w')
--   -- 현재 윈도우가 마지막 윈도우라면 q로 종료
--   if vim.fn.winnr('$') == 1 then vim.cmd('q')
--   else vim.cmd('bd') end
--   vim.notify('Saved last buffers', 3, { render = 'minimal' })
-- end)

map("n", "gtq", ManageBuffer_gtq)
-- DEPRECATED:: 2024-12-24 향후 문제 없으면 제거
-- map('n', 'gtq', function()
--   -- 탭 이름이 'abcd' 라면
--   local tabname = GetCurrentTabName()
--   if tabname == ' Commit' or tabname == ' File' or tabname == 'GV' or tabname == 'Diff' then
--     vim.cmd('tabclose!')
--     return
--   end
--
--   -- 전체 탭의 개수가 1개라면 아무것도 하지 않고 종료
--   if vim.fn.tabpagenr('$') == 1 then
--     vim.notify('Cannot close the last tab page', 4, { render = 'minimal' })
--     return
--   end
--
--   -- 현재 탭의 모든 윈도우를 순회하며 버퍼를 닫음
--   -- local tabnr = vim.fn.tabpagenr()  -- 현재 탭 번호 가져오기
--   local tabid = vim.api.nvim_get_current_tabpage()  -- 탭 ID 가져오기
--   local wins = vim.api.nvim_tabpage_list_wins(tabid) -- 현재 탭의 윈도우 목록 가져오기, 인자로 받는 것은 탭 번호가 아니라 탭 ID
--
--   for _, win in ipairs(wins) do
--       local bufnr = vim.api.nvim_win_get_buf(win) -- 윈도우에 연결된 버퍼 번호 가져오기
--       vim.api.nvim_buf_delete(bufnr, { force = true }) -- 버퍼 삭제 (force 옵션으로 강제 종료)
--   end
-- end, opt)

map("n", "gQ", ManageBuffer_gQ)
map("n", "gE", ManageBuffer_gE)
map("n", "gtQ", ManageBuffer_gtQ)

map("n", "gcp", Save_current_buffer_path)

-- fold는 항상  mkview
map("n", "zc", "zc<cmd>mkview<CR>")
map("n", "zo", "zo<cmd>mkview<CR>")
map("n", "zO", "zO<cmd>mkview<CR>")
map("n", "zm", "zm<cmd>mkview<CR>")
map("n", "zM", "zM<cmd>mkview<CR>")
map("n", "zr", "zr<cmd>mkview<CR>")
map("n", "zR", "zR<cmd>mkview<CR>")
map("n", "zf", "zf<cmd>mkview<CR>")
map("n", "zd", "zd<cmd>mkview<CR>")

-- DEPRECATED:: 2024-12-28
-- EASY ALIGN
-- map('x', 'al', '<Plug>(LiveEasyAlign)', {})
-- map('x', 'tal', '<Plug>(EasyAlign)*||', {})

-- NEW WINDOW & TAB
map("n", "<A-x>", "<cmd>rightbelow new<CR>")
map("n", "<A-v>", "<cmd>vnew<CR>")
map("n", "<A-t>", NewTabWithPrompt)
map("n", "<A-r>", RenameCurrentTab)
map("n", "<A-.>", MoveTabRight)
map("n", "<A-,>", MoveTabLeft)

-- DEPRECATED:: 2024-12-28
-- map('n', '<A-p>', CocScrollUp)
-- map('n', '<A-n>', CocScrollDown)
map("n", "<A-p>", "<cmd>tabnext<CR>")
-- FOCUS TABS
map("n", "<A-o>", "gT")
map("n", "<A-1>", "1gt")
map("n", "<A-2>", "2gt")
map("n", "<A-3>", "3gt")
map("n", "<A-4>", "4gt")
map("n", "<A-5>", "5gt")
map("n", "<A-6>", "6gt")
map("n", "<A-7>", "7gt")
map("n", "<A-8>", "8gt")
map("n", "<A-9>", "9gt")
-- FOCUS WINDOW
map("n", "<A-h>", "<cmd>wincmd h<CR>")
-- DEPRECATED:: 2024-12-28
-- map('n', '<A-j>', CocScrollDown_J)
-- map('n', '<A-k>', CocScrollUp_K)
map("n", "<A-j>", "<cmd>wincmd j<CR>")
map("n", "<A-k>", "<cmd>wincmd k<CR>")
map("n", "<A-l>", "<cmd>wincmd l<CR>")
-- MOVE WINDOW POSITION
map("n", "<A-H>", "<Cmd>WinShift left<CR>")
map("n", "<A-J>", "<Cmd>WinShift down<CR>")
map("n", "<A-K>", "<Cmd>WinShift up<CR>")
map("n", "<A-L>", "<Cmd>WinShift right<CR>")
map("n", ",mt", function() -- move window to tab
	vim.cmd("wincmd T")
	local tabnr = vim.fn.tabpagenr()
	local filename = vim.fn.expand("%:t")
	if filename ~= "" then
		vim.fn.settabvar(tabnr, "tabname", " mv: " .. filename)
	end
end)

map("n", ",st", function() -- Copy window to new tab
	vim.cmd("split | wincmd T")
	local tabnr = vim.fn.tabpagenr()
	local filename = vim.fn.expand("%:t")
	if filename ~= "" then
		vim.fn.settabvar(tabnr, "tabname", " sp: " .. filename)
	end
end)
-- WINDOW RESIZE
map("n", "<A-Left>", "<cmd>vertical resize -2<CR>", {})
map("n", "<A-Right>", "<cmd>vertical resize +2<CR>", {})
map("n", "<A-Down>", "<cmd>horizontal resize -2<CR>", {})
map("n", "<A-Up>", "<cmd>horizontal resize +2<CR>", {})
-- WINDOW RESIZE HARD
map("n", "<A-S-Left>", "<cmd>vertical resize -8<CR>", {})
map("n", "<A-S-Right>", "<cmd>vertical resize +8<CR>", {})
map("n", "<A-S-Down>", "<cmd>horizontal resize -8<CR>", {})
map("n", "<A-S-Up>", "<cmd>horizontal resize +8<CR>", {})
-- BUFFER FOCUS
map("n", "<Tab>", function()
	NavBuffAfterCleaning("next")
end)
map("n", "<S-Tab>", function()
	NavBuffAfterCleaning("prev")
end)

-- =========================================================================
-- =========================================================================
--                           plugin shortcuts
-- =========================================================================
-- =========================================================================
-- NVIM-TREE
map("n", ",,d", function()
	local tree_api = require("nvim-tree.api").tree

	tree_api.toggle({ find_files = true, focus = false })
	if tree_api.is_visible() then
		ShowCursor()
	end
end)
map("n", ",d", "<cmd>NvimTreeFocus<CR>") -- focus on nvim-tree right away  -> diffview 쪽이랑 통합했다. 조건부로 동작.

-- CALENDAR
-- 안씀
-- map('n', '<leader><leader>C', '<cmd>Calendar<CR>')
-- map('n', '<leader><leader>S', '<cmd>Startify<CR>')

-- FUGITIVE && GV && DIFFVIEW
-- log 확인
map("n", "<leader>gl<Space>", "<cmd>GV<CR>")
map("n", "<leader>gla", "<cmd>GV --all<CR>")
map("n", "<leader>glr", "<cmd>GV reflog<CR>")
map("n", "<leader>glf", "<cmd>GV!<CR>")
-- git status 관리
map("n", ",.gg", "<cmd>G<CR>")
-- 즉시 커밋, 버퍼가 상단이 아니라 우측에서 열리도록 하고 view는 유지
map("n", "<leader>cc", "<cmd>silent G commit<CR>", { silent = true })
map("n", "<leader>ce", "<cmd>silent G commit --amend<CR>", { silent = true })
-- 현재 버퍼 gitdiff 확인
map("n", ",vd", VDiffSplitOnTab)
map("n", ",vD", "<cmd>vert diffsplit ")
-- git review
-- TODO:
-- workflow를 고려해서 재구성할 필요가 있다.
-- 3. (Fetch가 아니라)PR을 받아서 (현재 최신과)비교
map("n", "<leader>reb", ":DiffviewFileHistory --range=") -- 특정 브랜치, 선택해야 한다.
map("n", "<leader>re<Space>", "<cmd>DiffviewFileHistory<CR>") -- 현재 브랜치 히스토리
map("n", "<leader>rea", "<cmd>DiffviewFileHistory --all<CR>") -- 모든 커밋 히스토리
map("n", "<leader>ref", "<cmd>DiffviewFileHistory %<CR>") -- current file only, commit history
map("n", "<leader>reF", "<cmd>DiffviewFileHistory --reverse --range=HEAD...FETCH_HEAD<CR>") -- something fetched
map("n", "<leader>res", "<cmd>DiffviewOpen --staged<CR>") -- review staged
map("n", "<leader>rew", "<cmd>DiffviewOpen<CR>") -- review working status, staged + unstaged
map("v", "<leader>re", DiffviewOpenWithVisualHash) -- gbl로 gitsigns blame line을 확인하고, 커밋의 변경사항을 확인

-- GITSIGNS
map("n", "<leader><leader>d", function()
	vim.cmd("Gitsigns toggle_word_diff")
	vim.cmd("Gitsigns toggle_linehl")
end)
map("n", "gsth", "<cmd>Gitsigns stage_hunk | NvimTreeRefresh<CR>") -- stage hunk
map("v", "gsth", Visual_stage) -- stage hunk
map("v", "gstH", Visual_undo_stage) -- stage hunk
map("n", "gstb", "<cmd>Gitsigns stage_buffer | NvimTreeRefresh<CR>") -- stage buffer
map("n", "greh", "<cmd>Gitsigns reset_hunk | NvimTreeRefresh<CR>") -- reset hunk, de-active
map("v", "greh", Visual_reset) -- reset hunk, de-active
map("n", "gpre", "<cmd>Gitsigns preview_hunk<CR>") -- show diff
map("n", "gbl", "<cmd>Gitsigns blame_line<CR>") -- show diff

-- OUTLINE to AERIAL
-- map({ 'n' }, ',,o', "<cmd>Outline<CR>")
-- map({ 'n' }, ',o', "<cmd>OutlineFocusOutline<CR>")
map("n", ",,a", function()
	vim.cmd("AerialToggle")
	vim.cmd("wincmd p")
end)
map("n", ",a", function()
	vim.cmd("norm ^ww")
	vim.cmd("AerialOpen")
end)

-- AUTO-SESSION
map("n", "<leader><leader>s", "<cmd>SessionSave<CR>") -- save
map("n", ",.S", require("auto-session.session-lens").search_session, {
	noremap = true,
}) -- search and load

-- LEAP
map({ "n", "v" }, ",l", "<Plug>(leap-forward)")
map({ "n", "v" }, ",L", "<Plug>(leap-backward)")
map({ "n" }, ",gl", "<Plug>(leap-from-window)")

-- INDENT-BLANKLINE
map({ "n", "v" }, "<F2>", "<cmd>IBLToggle<CR>")

-- TOGGLETERM
map({ "n", "v", "t" }, "<C-\\><C-\\>", "<Cmd>99ToggleTerm direction=float name=genaral<CR>", {})

-- REMOVE KEYMAP FROM NO-WHERE
vim.api.nvim_create_autocmd("VimEnter", {
	callback = function()
		pcall(vim.keymap.del, "i", "<C-G>s")
		pcall(vim.keymap.del, "i", "<C-G>S")
	end,
})

-- FOLD MOVE
map({ "n", "v" }, "<C-j>", "zjw")
map({ "n", "v" }, "<C-k>", "zkw")
map({ "n", "v" }, "<C-h>", "[zw")
map({ "n", "v" }, "<C-l>", "]zw")
map({ "n", "v" }, "<C-n>", "%][%zz")
map({ "n", "v" }, "<C-p>", "[]%zz")

map({ "n", "v" }, "<C-q>", "<Cmd>Focus<CR>")

map("n", "<leader>y", Save_entire_buffer_to_register_for_AI_prompt, opt)
map("v", "<leader>y", Save_visual_selection_to_register_for_AI_prompt, opt)

map("n", "ㅗ", function()
	os.execute("xdotool key Escape") -- 영어 입력 모드로 전환 (kime에 ESC 입력 보내기), keyboard layout to English
	vim.api.nvim_input("h")
end, opt)
map("n", "ㅓ", function()
	os.execute("xdotool key Escape") -- 영어 입력 모드로 전환 (kime에 ESC 입력 보내기), keyboard layout to English
	vim.api.nvim_input("j")
end, opt)
map("n", "ㅏ", function()
	os.execute("xdotool key Escape") -- 영어 입력 모드로 전환 (kime에 ESC 입력 보내기), keyboard layout to English
	vim.api.nvim_input("k")
end, opt)
map("n", "ㅣ", function()
	os.execute("xdotool key Escape") -- 영어 입력 모드로 전환 (kime에 ESC 입력 보내기), keyboard layout to English
	vim.api.nvim_input("l")
end, opt)

-- MEMO: lsp
local telescope = require("telescope.builtin")

map("n", "K", vim.lsp.buf.hover, opt)
map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, opt)
map("n", "<leader>re", vim.lsp.buf.rename, opt)
map("n", "<leader>rs", "<cmd>LspRestart<CR>", opt)

map("n", "dn", vim.diagnostic.goto_next, opt)
map("n", "dp", vim.diagnostic.goto_prev, opt)
map("n", "d<Space>", vim.diagnostic.open_float, opt)

-- MEMO:: `<C-l>`: show autocompletion menu to prefilter (i.e. `:warning:`)
map("n", ",.d", function()
	telescope.diagnostics({
		bufnr = 0, -- 현재 버퍼로 제한
		line_width = 200, -- 어차피 현재 파일일이다.
	})
end, opt)
map("n", ",.D", function()
	telescope.diagnostics({
		bufnr = nil, -- 모든 버퍼
		line_width = 0, -- diagnostic line은 필요 없고 파일만 구분되면 돼
	})
end, opt)

-- DEPRECATED:: 2025-01-03
-- map("n", ",.d", "<cmd>Telescope diagnostics bufnr=0<CR>", opt)
-- map("n", ",.D", "<cmd>Telescope diagnostics<CR>", opt)
-- map("n", "gd", "<cmd>Telescope lsp_definitions<CR>", opt)
-- map("n", "gy", "<cmd>Telescope lsp_type_definition<CR>", opt)
-- map("n", "gi", "<cmd>Telescope lsp_implementation<CR>", opt)
-- map("n", "gr", "<cmd>Telescope lsp_references<CR>", opt)
-- map("n", "gci", "<cmd>Telescope lsp_incoming_calls<CR>", opt)
-- map("n", "gco", "<cmd>Telescope lsp_outgoing_calls<CR>", opt)
map("n", "gD", vim.lsp.buf.declaration, opt)
map("n", "gd", function()
	telescope.lsp_definitions({
		jump_type = "never", -- 항상 preview 띄우기
		show_line = false, -- 결과 텍스트 표시
		trim_text = false, -- 텍스트 트림 비활성화
	})
end, opt)
map("n", "gy", function()
	telescope.lsp_type_definition({
		jump_type = "never", -- 항상 preview 띄우기
		show_line = false, -- 결과 텍스트 표시
		trim_text = false, -- 텍스트 트림 비활성화
	})
end, opt)
map("n", "gi", function()
	telescope.lsp_implementation({
		jump_type = "never", -- 항상 preview 띄우기
		show_line = false, -- 결과 텍스트 표시
		trim_text = false, -- 텍스트 트림 비활성화
	})
end, opt)
map("n", "gr", function()
	telescope.lsp_references({
		show_line = false, -- 결과 텍스트 표시
		include_declaration = true,
		include_current_line = false, --> false: ()커서가 위치한 요소도 결과에)포함, ture: 제외
	})
end, opt)
map("n", "gci", function()
	telescope.lsp_incoming_calls({
		show_line = false, -- 결과 텍스트 표시
	})
end, opt)
map("n", "gco", function()
	telescope.lsp_outgoing_calls({
		show_line = false, -- 결과 텍스트 표시
	})
end, opt)
map("n", "<leader>d", my_commands.diagnostics.ToggleVirtualText, opt)

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
	-- border = "none",
	border = {
		"▄",
		"▄",
		"▄",
		"█",
		"▀",
		"▀",
		"▀",
		"█",
	},
	-- title = "Hover",
	focusable = true, -- 포커스 비활성화
	max_width = 150, -- 최대 너비 제한
	max_height = 20, -- 최대 높이 제한
})
-- vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = "rounded" })

map("v", "<leader>s", SearchWithBrowser, { noremap = true, silent = true })
