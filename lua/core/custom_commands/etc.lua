local utils = require("core.utils")

-- =========================================================================
-- =========================================================================
--                           general
-- =========================================================================
-- =========================================================================
-- TODO::
-- 1. 종료 시 relativenumber 하이라이트가 바뀐다.
-- 2. 버퍼 또는 윈도우마다 별도의 상태를 가지는데, 이럼 안된다.
function ShareCursor()
	if vim.o.cursorline then
		vim.o.cursorline = false
		vim.o.cursorcolumn = false
		vim.o.relativenumber = false
	else
		vim.o.cursorline = true
		vim.o.cursorcolumn = true
		vim.o.relativenumber = true
		vim.cmd([[
      highlight CursorColumn guifg=white guibg=#AB82A5
      highlight CursorLine guifg=white guibg=#AB82A5
    ]])
	end
end

vim.cmd("command! ShareCursor lua ShareCursor()")

function BlinkCursorLine(duration)
	duration = duration or 50 -- 기본값 50ms
	vim.cmd("highlight CursorLine guibg=#2CB67D")
	vim.wo.cursorline = true
	vim.defer_fn(function()
		if vim.bo.filetype == "NvimTree" then
			vim.cmd("highlight CursorLine guibg=#242024")
		else
			vim.cmd("highlight CursorLine guibg=#3e4452")
			vim.wo.cursorline = false
		end
	end, duration)
end

function ExpandGlow()
	vim.cmd([[
    Glow
    resize 999
    vertical resize 999'
  ]])
end

vim.cmd("command! GlowFull lua ExpandGlow()")

function Save_current_buffer_path()
	local path = vim.fn.expand("%:p:h") -- 현재 버퍼의 전체 경로 얻기
	vim.fn.setreg("+", path) -- 클립보드에 경로 복사
	-- Notify('Saved current buffer path', 2, { render = 'minimal' })
end

-- 플로팅 윈도우로 포커스를 이동하는 Lua 함수
function FocusFloatingWindow()
	local wins = vim.api.nvim_list_wins()
	for _, win in ipairs(wins) do
		local config = vim.api.nvim_win_get_config(win)
		if config.focusable and config.relative ~= "" then
			vim.api.nvim_set_current_win(win)
			return
		end
	end
end

function ShowCursor()
	vim.cmd("hi Cursor blend=0")
	vim.cmd("set guicursor-=a:Cursor/lCursor")
end

function NvimTreeResetUI()
	vim.cmd("NvimTreeClose")
	require("nvim-tree.api").tree.toggle({ find_files = true, focus = false })

	ShowCursor()
end

-- =========================================================================
-- =========================================================================
--                           Telescope
-- =========================================================================
-- =========================================================================
-- visual block만 서치하기
function TelescopeSearchVisual()
	local text = utils.get_visual_text()
	require("telescope.builtin").live_grep({ default_text = text })
end

-- =========================================================================
-- =========================================================================
--                           Shell command insdie Vim Buffer
-- =========================================================================
-- =========================================================================
function RunBufferWithSh()
	local temp_file = vim.fn.tempname()
	vim.api.nvim_command("silent! write! " .. temp_file)
	vim.api.nvim_command("setlocal buftype=nofile")

	-- 현재 윈도우의 id와 우측 포커싱 후 id 확인
	local current_win = vim.api.nvim_get_current_win()
	vim.api.nvim_command("wincmd l")
	local new_win = vim.api.nvim_get_current_win()

	-- 포커스가 바뀌지 않았다면, 현재 우측 끝임
	if current_win == new_win then
		vim.api.nvim_command("vert belowright new")
	else
		vim.api.nvim_set_current_win(current_win)
		vim.api.nvim_command("wincmd l | new")
	end

	vim.api.nvim_command(
		[[r !date "+\%T" | awk '{line="=========================="; print line "\n===== time: " $1 " =====\n" line}']]
	)
	vim.api.nvim_command("setlocal buftype=nofile | silent! read !sh " .. temp_file)

	vim.fn.delete(temp_file)
	vim.api.nvim_set_current_win(current_win)
end

function RunBufferWithShCover()
	local temp_file = vim.fn.tempname()
	vim.api.nvim_command("silent! write! " .. temp_file)
	vim.api.nvim_command("setlocal buftype=nofile")

	-- 현재 윈도우의 id와 우측 포커싱 후 id 확인
	local current_win = vim.api.nvim_get_current_win()
	vim.api.nvim_command("wincmd l")
	local new_win = vim.api.nvim_get_current_win()

	-- 포커스가 바뀌지 않았다면, 현재 우측 끝임
	if current_win == new_win then
		vim.api.nvim_command("vert belowright new")
	else
		vim.api.nvim_set_current_win(current_win)
		vim.api.nvim_command("wincmd l | %delete")
	end

	vim.api.nvim_command(
		[[r !date "+\%T" | awk '{line="=========================="; print line "\n===== time: " $1 " =====\n" line}']]
	)
	vim.api.nvim_command("setlocal buftype=nofile | silent! read !sh " .. temp_file)

	vim.api.nvim_set_current_win(current_win)
	vim.fn.delete(temp_file)
end

function RunSelectedLinesWithSh()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local start_line = start_pos[2]
	local end_line = end_pos[2]
	local temp_file = vim.fn.tempname()
	vim.api.nvim_command("silent! " .. start_line .. "," .. end_line .. "write! " .. temp_file)

	-- 현재 윈도우의 id와 우측 포커싱 후 id 확인
	local current_win = vim.api.nvim_get_current_win()
	vim.api.nvim_command("wincmd l")
	local new_win = vim.api.nvim_get_current_win()

	-- 포커스가 바뀌지 않았다면, 현재 우측 끝임
	if current_win == new_win then
		vim.api.nvim_command("vert belowright new")
	else
		vim.api.nvim_set_current_win(current_win)
		vim.api.nvim_command("wincmd l | new")
	end

	vim.api.nvim_command(
		[[r !date "+\%T" | awk '{line="=========================="; print line "\n===== time: " $1 " =====\n" line}']]
	)
	vim.api.nvim_command("setlocal buftype=nofile | silent! read !sh " .. temp_file)

	vim.api.nvim_set_current_win(current_win)
	vim.fn.delete(temp_file)
end

function RunSelectedLinesWithShCover()
	local start_pos = vim.fn.getpos("'<")
	local end_pos = vim.fn.getpos("'>")
	local start_line = start_pos[2]
	local end_line = end_pos[2]
	local temp_file = vim.fn.tempname()
	vim.api.nvim_command("silent! " .. start_line .. "," .. end_line .. "write! " .. temp_file)

	-- 현재 윈도우의 id와 우측 포커싱 후 id 확인
	local current_win = vim.api.nvim_get_current_win()
	vim.api.nvim_command("wincmd l")
	local new_win = vim.api.nvim_get_current_win()

	-- 포커스가 바뀌지 않았다면, 현재 우측 끝임
	if current_win == new_win then
		vim.api.nvim_command("vert belowright new")
	else
		vim.api.nvim_set_current_win(current_win)
		vim.api.nvim_command("wincmd l | %delete")
	end

	vim.api.nvim_command(
		[[r !date "+\%T" | awk '{line="=========================="; print line "\n===== time: " $1 " =====\n" line}']]
	)
	vim.api.nvim_command("setlocal buftype=nofile | silent! read !sh " .. temp_file)

	vim.api.nvim_set_current_win(current_win)
	vim.fn.delete(temp_file)
end

function NewTabWithPrompt()
	-- 입력 프롬프트 표시
	local tabname = vim.fn.input("Enter tab name: ")
	if tabname == "" then
		-- tabname = 'Tab ' .. vim.fn.tabpagenr('$') + 1
		-- 입력이 없거나 ESC를 누른 경우, 함수 종료
		return
	end
	-- 새로운 탭 생성 및 이름 설정
	vim.cmd("tabnew")
	local tabnr = vim.fn.tabpagenr()
	vim.fn.settabvar(tabnr, "tabname", tabname)
end

function RenameCurrentTab()
	-- 현재 탭 번호를 가져옵니다
	local tabnr = vim.fn.tabpagenr()

	-- 입력 프롬프트를 표시하여 새 탭 이름을 입력받습니다
	local tabname = vim.fn.input("Enter new tab name: ")
	if tabname == "" then
		-- tabname = 'Tab ' .. tabnr
		-- 입력이 없거나 ESC를 누른 경우, 함수 종료
		return
	end

	-- 현재 탭의 이름을 설정합니다
	vim.fn.settabvar(tabnr, "tabname", tabname)
	-- 탭라인을 업데이트합니다
	vim.cmd("redrawtabline")
end

function MoveTabLeft()
	local current_tab = vim.fn.tabpagenr()
	if current_tab == 1 then
		vim.cmd("tabmove $")
	elseif current_tab > 1 then
		vim.cmd("tabmove " .. (current_tab - 2))
	end
end

function MoveTabRight()
	local current_tab = vim.fn.tabpagenr()
	local total_tabs = vim.fn.tabpagenr("$")
	if current_tab < total_tabs then
		vim.cmd("tabmove " .. current_tab + 1)
	else
		vim.cmd("tabmove 0")
	end
end

function CloseOtherBuffersInCurrentTab()
	local current_buf = vim.api.nvim_get_current_buf()
	local current_tab = vim.api.nvim_get_current_tabpage()
	local windows = vim.api.nvim_tabpage_list_wins(current_tab)

	-- 현재 탭의 다른 윈도우 닫기
	for _, win in ipairs(windows) do
		if vim.api.nvim_win_get_buf(win) ~= current_buf then
			vim.api.nvim_win_close(win, true)
		end
	end

	-- 히든 버퍼 중 다른 탭에서 사용되지 않는 버퍼 삭제
	local buffers = vim.api.nvim_list_bufs()
	for _, buf in ipairs(buffers) do
		if vim.api.nvim_buf_is_loaded(buf) and buf ~= current_buf then
			-- 다른 탭에서 열려있는지 확인
			local is_open_elsewhere = false
			for _, tab in ipairs(vim.api.nvim_list_tabpages()) do
				if tab ~= current_tab then
					local tab_wins = vim.api.nvim_tabpage_list_wins(tab)
					for _, tw in ipairs(tab_wins) do
						if vim.api.nvim_win_get_buf(tw) == buf then
							is_open_elsewhere = true
							break
						end
					end
				end
				if is_open_elsewhere then
					break
				end
			end

			-- 다른 탭에서 사용되지 않는 히든 버퍼 삭제
			if not is_open_elsewhere and vim.fn.bufwinnr(buf) == -1 then
				local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
				if filetype ~= "VoltWindow" then
					vim.api.nvim_buf_delete(buf, { force = true })
				end
			end
		end
	end

	vim.api.nvim_command("only")
end

function TabOnlyAndCloseHiddenBuffers()
	vim.cmd("TTimerlyToggle")
	-- 현재 탭에서 열린 버퍼 번호들을 저장
	local open_buffers = {}
	for _, win in ipairs(vim.api.nvim_tabpage_list_wins(0)) do
		local buf = vim.api.nvim_win_get_buf(win)
		open_buffers[buf] = true
	end

	-- 모든 버퍼를 순회하며, 열린 버퍼에 포함되지 않은(hidden 상태인) 버퍼를 닫기
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if not open_buffers[buf] and vim.api.nvim_buf_is_loaded(buf) then
			local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
			if filetype ~= "VoltWindow" then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	end

	print("tab only, wipe invisible buffers")
	vim.cmd("silent tabonly")
end

function _G.close_FT_buffers(FT)
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) then
			local filetype = vim.api.nvim_buf_get_option(buf, "filetype")
			if filetype == FT then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	end
end

-- 모든 탭 내에서 현재 버퍼만 남기기
-- :%bdelete|edit#|bdelete#

function CloseEmptyUnnamedBuffers()
	-- 현재 모든 윈도우에 로드된 활성 버퍼 목록 가져오기
	local active_buffers = {}
	for _, win in ipairs(vim.api.nvim_list_wins()) do
		local buf = vim.api.nvim_win_get_buf(win)
		active_buffers[buf] = true
	end

	-- 모든 버퍼를 확인하면서, 비어있고 이름이 없는 비활성 버퍼를 닫기
	for _, buf in ipairs(vim.api.nvim_list_bufs()) do
		if vim.api.nvim_buf_is_loaded(buf) and vim.api.nvim_buf_get_name(buf) == "" and not active_buffers[buf] then
			local lines = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
			if #lines == 0 or (#lines == 1 and lines[1] == "") then
				vim.api.nvim_buf_delete(buf, { force = true })
			end
		end
	end
end

function GetCurrentTabName()
	local tabnr = vim.fn.tabpagenr()
	return vim.fn.gettabvar(tabnr, "tabname", "No Name")
end

function OpenOrFocusTerm()
	-- Step 0: 기존에 "Term: "으로 시작하는 이름을 가진 터미널 버퍼가 있다면 아래와 같이 Early Return
	local CB = {} -- current buffer
	CB.number = vim.fn.bufnr()
	CB.name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(CB.number), ":t")
	CB.info = vim.fn.getbufinfo(CB.number)[1]

	if CB.name:find("Term: ") and CB.info.variables and CB.info.variables.terminal_job_id then
		local input = vim.fn.input("Change name: ")
		if input ~= "" then
			vim.api.nvim_buf_set_name(CB.number, "Term: " .. input)
			PrintTime("Changed to: " .. input, 1.5)
		else
			PrintTime("Canceled", 0.5)
		end
		return -- 입력값 없이 입력 또는 ESC를 누른 경우, 함수 종료
	elseif CB.name:find("Term: ") and CB.info.variables and not CB.info.variables.terminal_job_id then
		vim.cmd("term bash")
		vim.cmd("bdelete" .. CB.number) -- :trem은 새로운 버퍼를 생성하므로 기존 버퍼를 삭제한다. 그렇지 않으면 버퍼 이름 중복으로 에러가 발생한다.
		local new_bufnr = vim.fn.bufnr()

		-- vim.schedule을 사용해 이름 설정을 지연하여 터미널 초기화 후 실행
		vim.schedule(function()
			vim.api.nvim_buf_set_name(new_bufnr, CB.name)
			-- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], {buffer = new_bufnr})
		end)
		return
	end

	-- Step 1: ex 커맨드 라인에서 사용자 입력 요청
	local input = vim.fn.input("Term: ")
	if input == "" then
		-- 입력이 없거나 ESC를 누른 경우, 함수 종료
		return
	end

	-- Step 2: 입력된 이름을 가진 버퍼가 있는지 확인
	local term_name = "Term: " .. input
	local existing_buf = nil

	for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
		-- 버퍼 이름에서 basename만 추출하여 비교
		local buf_name = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(bufnr), ":t")
		if buf_name == term_name then
			existing_buf = bufnr
			break
		end
	end

	if existing_buf then
		-- 이미 동일한 이름을 가진 버퍼가 있을 경우
		local is_visible = false
		for _, win in ipairs(vim.api.nvim_list_wins()) do
			if vim.api.nvim_win_get_buf(win) == existing_buf then
				-- 해당 버퍼가 열려 있는 윈도우로 포커스 이동
				vim.api.nvim_set_current_win(win)
				is_visible = true
				break
			end
		end
		if not is_visible then
			-- 버퍼가 존재하지만, 윈도우에 로드되어 있지 않은 경우 로드
			vim.cmd("buffer " .. existing_buf)
		end
		return -- 이미 열린 버퍼로 이동했으므로 함수 종료
	end

	-- Step 3: 터미널 버퍼 생성 후 이름 설정
	vim.cmd("term") -- 새로운 터미널 버퍼 생성
	local term_bufnr = vim.api.nvim_get_current_buf() -- 새로 생성된 터미널 버퍼 ID 저장

	-- vim.schedule을 사용해 이름 설정을 지연하여 터미널 초기화 후 실행
	vim.schedule(function()
		vim.api.nvim_buf_set_name(term_bufnr, term_name)
		-- vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], {buffer = term_bufnr}) -- TermOpen같은 autocmd 이벤트로 달아버리면 fugitive git push -p 로 생성된 터미널 버퍼에서 불편함을 초래한다.
	end)
end

-- 노멀 모드: 전체 버퍼 내용을 주석과 함께 md 코드블록 형식으로 레지스트리에 저장
function Save_entire_buffer_to_register_for_AI_prompt()
	local content = vim.fn.join(vim.fn.getline(1, "$"), "\n") -- 전체 버퍼 내용 가져오기
	local relative_path = vim.fn.expand("%:p"):sub(#vim.fn.getcwd() + 2)
	local filetype = vim.bo.filetype
	local result = string.format("```%s\n## File Path: %s\n%s\n```", filetype, relative_path, content)

	vim.fn.setreg("+", result)
end

-- 비주얼 모드: 선택한 텍스트를 주석과 함께 md 코드블록 형식으로 레지스트리에 저장
function Save_visual_selection_to_register_for_AI_prompt()
	-- Visual 모드 종료 후 Normal 모드로 돌아가기
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", false)

	vim.schedule(function()
		-- MEMO:: '<' 또는 '>' 이놈들은 기본적으로 이전 visual mode의 시작과 끝을 가져온다. 그러니 일단 nomal모드로 돌아간 뒤에 가져와야 정상 순서다.
		local start_line, start_col = unpack(vim.api.nvim_buf_get_mark(0, "<"))
		local end_line, end_col = unpack(vim.api.nvim_buf_get_mark(0, ">"))

		local content = table.concat(vim.fn.getline(start_line, end_line), "\n")
		local relative_path = vim.fn.expand("%:p"):sub(#vim.fn.getcwd() + 2)
		local filetype = vim.bo.filetype
		local range = start_line .. "-" .. end_line

		local result = string.format("```%s\n## File Path: %s, %s\n%s\n```", filetype, relative_path, range, content)

		-- 텍스트를 레지스트리에 저장
		vim.fn.setreg("+", result)
	end)
end

function ReloadLayout()
	local curr_win = vim.api.nvim_get_current_win()
	local win_count_curr_tab = #vim.api.nvim_tabpage_list_wins(0)
	local is_tree_open = require("core.utils").tree:is_visible()

	if win_count_curr_tab == 1 and is_tree_open then
		require("nvim-tree.api").tree.reload()
		return
	end

	-- 공통
	vim.cmd("wincmd = | echon")

	-- check nvim-tree
	if is_tree_open then
		NvimTreeResetUI()
	end

	-- check FileType for: aerial, avante
	local function is_ft_open()
		-- Get all windows in current tab
		local wins = vim.api.nvim_tabpage_list_wins(0)
		local is_aerial_open = false
		local is_avante_open = false

		-- Check each window's buffer filetype
		for _, win in ipairs(wins) do
			local buf = vim.api.nvim_win_get_buf(win)
			local ft = vim.api.nvim_buf_get_option(buf, "filetype")
			if ft == "aerial" then
				is_aerial_open = true
			end
			if ft == "Avante" then
				is_avante_open = true
			end
		end

		return is_aerial_open, is_avante_open
	end
	local is_aerial_open, is_avante_open = is_ft_open()

	if is_aerial_open then
		vim.cmd("AerialToggle")
		vim.cmd("AerialToggle")
	end

	if is_avante_open then
		vim.cmd("AvanteToggle")
		vim.cmd("AvanteToggle")
	end

	-- WARN:: 문제를 이르키는지 다시 살펴볼 필요가 있음
	-- require('quicker').refresh()

	-- focus origianal window
	vim.defer_fn(function()
		if vim.api.nvim_win_is_valid(curr_win) then -- avante window의 경우 항상 새로운 window가 생성되므로 에러를 이르킬 수 있다.
			vim.api.nvim_set_current_win(curr_win)
		end
	end, 1)
end

function IsCursorOnEmptySpace()
	-- 현재 커서 위치 가져오기 (1-based index)
	local row, col = unpack(vim.api.nvim_win_get_cursor(0))
	-- 현재 줄 텍스트 가져오기
	local line = vim.api.nvim_get_current_line()
	-- 커서 위치의 문자 확인
	local char = line:sub(col + 1, col + 1) -- Lua는 1-based, col은 0-based
	return char == " " or char == ""
end

function HilightSearch()
	local text = utils.get_visual_text()
	if text and #text > 0 then
		vim.cmd("normal! bh")
		-- local pos = vim.api.nvim_win_get_cursor(0)
		-- vim.api.nvim_win_set_cursor(0, { pos[1] - 1, 1 })

		local keys = "/" .. text .. "\n"
		vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(keys, true, false, true), "n", true)
	end
end

function ToggleHilightSearch()
	if vim.v.hlsearch == 1 then
		vim.cmd("nohlsearch | echon")
	else
		if not IsCursorOnEmptySpace() then
			vim.cmd("normal! viw")
			HilightSearch()
		end
	end
end

-- NVIM-TREE BUFFER 또는 (조건에 따라)DIFFVIEWFILE PANEL로 즉시 이동
function DiffviewFilePanelFocusConditional()
	local buffers = vim.api.nvim_list_bufs()
	local diffviewOpen = false

	for _, buf in ipairs(buffers) do
		local ft = vim.bo[buf].filetype
		if ft == "DiffviewFiles" then
			diffviewOpen = true
			break
		end
	end

	if diffviewOpen then
		vim.cmd("DiffviewFocusFiles")
	else
		-- Diffview가 열려 있지 않을 경우, NvimTreeFocus 명령을 실행합니다.
		vim.cmd("NvimTreeFocus")
	end
end

function UpdateCommandWinodwHistory()
	vim.fn.histdel("cmd", -1)
	for i = 1, vim.fn.line("$") do
		local cmd = vim.fn.getline(i)
		if cmd ~= "" then -- 빈 줄은 무시
			vim.fn.histadd("cmd", cmd)
		end
	end
	print("Command-line history updated.")
end

function VDiffSplitOnTab()
	vim.cmd("sp | wincmd T | Gvdiffsplit | wincmd l")

	local tabnr = vim.fn.tabpagenr()
	vim.fn.settabvar(tabnr, "tabname", "Diff")
end

function NavBuffAfterCleaning(DIR)
	CloseEmptyUnnamedBuffers()
	vim.cmd(DIR == "prev" and "bprev" or "bnext")

	local bufname = vim.api.nvim_buf_get_name(0)
	if bufname:find("Term: ") then
		vim.cmd(DIR == "prev" and "bprev" or "bnext")
	end

	local listed_buffers = vim.fn.getbufinfo({ buflisted = true })
	-- "Term: "으로 시작하는 버퍼를 제거
	local filtered_buffers = vim.tbl_filter(function(buf)
		return not string.find(buf.name, "Term:")
	end, listed_buffers)

	local current_bufnr = vim.fn.bufnr()
	local current_buf_index

	for i, buf in ipairs(filtered_buffers) do
		if buf.bufnr == current_bufnr then
			current_buf_index = i
			break
		end
	end

	PrintTime("  Buffers .. [" .. current_buf_index .. "/" .. #filtered_buffers .. "]", 1)
end

-- message history에는 남기지 않는다.
function PrintTime(msg, time)
	vim.api.nvim_echo({ { msg } }, false, {})

	-- vim.defer_fn(function()
	--   vim.api.nvim_echo({{''}}, false, {})  -- 빈 문자열로 메시지 지우기
	-- end, time * 1000)
	-- 성능 이슈가 있어 아래를 사용한다.
	local timer = vim.loop.new_timer()
	timer:start(
		time * 1000,
		0,
		vim.schedule_wrap(function()
			vim.api.nvim_echo({ { "" } }, false, {}) -- 빈 문자열로 메시지 지우기
			timer:stop()
			timer:close()
		end)
	)
end

-- 삭제된 단어들을 저장할 Lua 테이블
local deleted_words = {}

-- 단어를 삭제하고 테이블에 저장하는 함수
function DeleteAndStore()
	vim.cmd("normal! b") -- 커서를 단어의 시작으로 이동
	local word = vim.fn.expand("<cword>") -- 현재 단어를 가져옴
	table.insert(deleted_words, 1, word) -- 테이블 맨 앞에 단어 추가
	vim.cmd("normal! diw") -- 단어 삭제
end

-- 삭제된 단어들을 순차적으로 붙여넣는 함수
function PasteFromHistory()
	if #deleted_words > 0 then
		local word = table.remove(deleted_words, 1) -- 가장 최근에 추가된 단어 가져오기
		vim.api.nvim_put({ word }, "c", true, true) -- 현재 커서 위치에 단어 삽입
	end
end

-- DEPRECATED:: 2024-12-28
-- function CocScrollUp()
--   -- floating 요소에 스크롤이 있는지 확인
--   if vim.fn['coc#float#has_scroll']() == 1 then
--     -- scroll
--     vim.fn['coc#float#scroll'](0)
--   else
--     vim.cmd('tabnext')
--   end
-- end
-- function CocScrollDown()
--   if vim.fn['coc#float#has_scroll']() == 1 then
--     -- scroll
--     vim.fn['coc#float#scroll'](1)
--   end
-- end

-- DEPRECATED:: 2024-12-28
-- function CocScrollUp_K()
--   -- floating 요소에 스크롤이 있는지 확인
--   if vim.fn['coc#float#has_scroll']() == 1 then
--     -- scroll
--     vim.fn['coc#float#scroll'](0)
--   else
--     vim.cmd('wincmd k')
--   end
-- end
-- function CocScrollDown_J()
--   if vim.fn['coc#float#has_scroll']() == 1 then
--     -- scroll
--     vim.fn['coc#float#scroll'](1)
--   else
--     vim.cmd('wincmd j')
--   end
-- end

function DiffviewOpenWithVisualHash()
	local hash = utils.get_visual_text()
	vim.cmd("DiffviewOpen " .. hash .. "^.." .. hash)
end

function RemoveTrailingWhitespace()
	local pos = vim.api.nvim_win_get_cursor(0)
	vim.cmd([[%s/\s\+$//e]])
	vim.api.nvim_win_set_cursor(0, pos)
end

function BufferNextDropLast()
	local last_buf = vim.api.nvim_get_current_buf()
	local listed_buffers = vim.fn.getbufinfo({ buflisted = true })

	-- "Term: "으로 시작하는 버퍼를 제거
	local filtered_buffers = vim.tbl_filter(function(buf)
		return not string.find(buf.name, "Term:")
	end, listed_buffers)

	-- hidden 버퍼만 필터링
	local hidden_bufs = {}

	for _, buf in ipairs(filtered_buffers) do
		if buf.hidden == 1 then
			table.insert(hidden_bufs, buf.bufnr)
		end
	end

	-- 테이블에 요소가 1개 이상이라면, 다음 버퍼로 0번째 버퍼로 이동
	if #hidden_bufs > 0 then
		vim.api.nvim_set_current_buf(hidden_bufs[1])
	end

	-- 어쨋든 최근 버퍼는 닫는다.
	vim.cmd("bd " .. last_buf)
end

local function is_buffer_active_somewhere(bufnr)
	-- 모든 창 확인
	local windows = vim.api.nvim_list_wins()
	for _, winid in ipairs(windows) do
		-- 각 창의 버퍼 번호 확인
		if vim.api.nvim_win_get_buf(winid) == bufnr then
			return true -- 버퍼가 하나 이상의 창에 활성화됨
		end
	end
	return false -- 어떤 창에도 표시되지 않음
end

function ManageBuffer_gq()
	local win_count = vim.fn.winnr("$")
	local tab_count = vim.fn.tabpagenr("$")
	local bufnr = vim.fn.bufnr("%")

	vim.cmd("q!")

	if win_count == 1 and tab_count == 1 then
	elseif win_count == 1 and tab_count > 1 then
	elseif win_count == 2 and require("nvim-tree.view").is_visible() then
	else
	end

	if
		not is_buffer_active_somewhere(bufnr)
		and vim.api.nvim_buf_is_valid(bufnr)
		and not vim.bo[bufnr].filetype == "help"
		and not vim.fn.bufname(bufnr) == ""
	then
		vim.cmd.bdelete(bufnr)
	end
end

function ManageBuffer_ge()
	vim.cmd("w") -- 일단 저장

	ManageBuffer_gq()

	vim.notify("Saved last buffers", 3, { render = "minimal" })
end

function ManageBuffer_gQ() -- loaded buffer를 모두 닫는다.
	local bufnr = vim.fn.bufnr("%")

	vim.cmd("q")

	if vim.api.nvim_buf_is_valid(bufnr) then
		vim.api.nvim_buf_delete(bufnr, { force = true }) -- bwipeout
	end
end

function ManageBuffer_gE() -- 저장 후, loaded buffer를 모두 닫는다.
	vim.cmd("w")

	ManageBuffer_gQ()
	vim.notify("Saved last buffers", 3, { render = "minimal" })
end

function ManageBuffer_gtq()
	-- 예외처리: 특수 탭
	local tabname = GetCurrentTabName()
	if tabname == " Commit" or tabname == " File" or tabname == "GV" or tabname == "Diff" then
		vim.cmd("tabclose!")
		return
	end

	-- 예외처리: 전체 탭의 개수가 1개
	if vim.fn.tabpagenr("$") == 1 then
		vim.notify("Cannot close the last tab page", 4, { render = "minimal" })
		return
	end

	-- 현재 탭의 모든 윈도우 순회하며 조건에 맞을 때 종료(조건: is_buffer_active_somewhere)
	local tabid = vim.api.nvim_get_current_tabpage() -- 탭 ID 가져오기
	local wins = vim.api.nvim_tabpage_list_wins(tabid) -- 현재 탭의 윈도우 목록 가져오기, 인자로 받는 것은 탭 번호가 아니라 탭 ID
	for _, win in ipairs(wins) do
		if vim.bo.filetype == "NvimTree" then
			vim.cmd("q")
		elseif vim.api.nvim_win_is_valid(win) then
			local bufnr = vim.api.nvim_win_get_buf(win) -- 윈도우에 연결된 버퍼 번호 가져오기
			vim.cmd("q") -- 일단 꺼
			if not is_buffer_active_somewhere(bufnr) then -- 다른데 활성화(눈에 보이게) 되어있지 않은것만 꺼
				vim.api.nvim_buf_delete(bufnr, { force = true })
			end
		end
	end
end

function ManageBuffer_gtQ()
	-- 그간의 경험을 돌아보면 딱히 쓴 일, 쓸 일이 없는데?
end

function SearchWithBrowser()
	local selected = utils.get_visual_text()
	if selected == "" then
		print("No text selected!")
		return
	end

	local encoded_text = utils.url_encode(selected)
	local search_url = "--app=https://www.google.com/search?q=" .. encoded_text

	vim.fn.system("brave " .. search_url)

	-- 이런것도 가능하다. xdg-open으로 열기!
	-- vim.ui.open(search_url2)
end
