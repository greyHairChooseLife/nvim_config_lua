-- Quickfix list toggle 함수 정의
local function QF_ToggleList()
	-- Quickfix 창이 열려있는지 확인
	local is_open = false
	for _, win in pairs(vim.fn.getwininfo()) do
		if win.quickfix == 1 then
			is_open = true
			break
		end
	end

	if is_open then
		vim.cmd("cclose")
	else
		vim.cmd("copen | wincmd p")
	end
end

vim.keymap.set("n", ",,q", QF_ToggleList, { noremap = true, silent = true })
vim.keymap.set("n", ",q", "<cmd>copen<CR>", { noremap = true, silent = true })

-- Quickfix 항목 제거 함수 정의
local function QF_RemoveItem()
	local curqfidx = vim.fn.line(".") - 1
	local qfall = vim.fn.getqflist()
	if #qfall == 1 then
		vim.fn.setqflist({}, "r")
		vim.api.nvim_command("cclose")
		vim.api.nvim_echo({ { "Good job, Quickfix list cleared!!", "MoreMsg" } }, false, {})
	else
		table.remove(qfall, curqfidx + 1) -- Lua에서 table 인덱스는 1부터 시작함에 주의
		vim.fn.setqflist(qfall, "r")
		if curqfidx < #qfall then
			vim.api.nvim_command(tostring(curqfidx) .. "cfirst")
		else
			vim.api.nvim_command(tostring(#qfall) .. "cfirst")
		end
		if #qfall == 0 then
			vim.api.nvim_command("cclose")
			vim.api.nvim_echo({ { "Quickfix list cleared", "MoreMsg" } }, false, {})
		else
			vim.api.nvim_command("copen")
		end
	end
end

-- Quickfix list clear all 함수 정의
local function QF_ClearList()
	vim.fn.setqflist({}, "r")
	vim.api.nvim_command("cclose")
	vim.api.nvim_echo({ { "Quickfix list cleared", "MoreMsg" } }, false, {})
end

-- Quickfix 리스트 순환 이동
local function QF_MoveNext()
	local qf_list = vim.fn.getqflist()
	if #qf_list == 0 then
		-- Notify("List is empty", 3, { title = "Quickfix" })
		return
	end -- Quickfix 리스트가 비어있는 경우 아무 동작도 하지 않음
	local qf_info = vim.fn.getqflist({ idx = 0 })
	local qf_index = qf_info.idx
	if qf_index == #qf_list then
		vim.cmd("cfirst")
	else
		vim.cmd("cnext")
	end
	vim.cmd("wincmd p")
end

local function QF_MovePrev()
	local qf_list = vim.fn.getqflist()
	if #qf_list == 0 then
		-- Notify("List is empty", 3, { title = "Quickfix" })
		return
	end -- Quickfix 리스트가 비어있는 경우 아무 동작도 하지 않음
	local qf_info = vim.fn.getqflist({ idx = 0 })
	local qf_index = qf_info.idx
	if qf_index == 1 then
		vim.cmd("clast")
	else
		vim.cmd("cprev")
	end
	vim.cmd("wincmd p")
end

vim.api.nvim_create_autocmd("FileType", {
	pattern = "qf",
	callback = function()
		-- gui
		vim.api.nvim_command("wincmd L")
		vim.api.nvim_win_set_width(0, 100)
		vim.api.nvim_set_hl(0, "QFBufferBG", { bg = "#201010" })
		vim.api.nvim_set_hl(0, "QFBufferEOB", { fg = "#201010" })
		vim.cmd("setlocal winhighlight=Normal:QFBufferBG,EndOfBuffer:QFBufferEOB")

		-- keymap
		vim.keymap.set("n", "dd", QF_RemoveItem, { buffer = true, silent = true })
		vim.keymap.set("n", "DD", QF_ClearList, { buffer = true, silent = true })
		vim.keymap.set({ "n", "v" }, "<C-n>", QF_MoveNext, { buffer = true })
		vim.keymap.set({ "n", "v" }, "<C-p>", QF_MovePrev, { buffer = true })
		vim.keymap.set({ "n", "v" }, "gq", function()
			vim.cmd("q | wincmd p")
			BlinkCursorLine(500)
		end, { buffer = true, silent = true })
	end,
})

vim.keymap.set("n", "qn", function()
	-- if quickfix is empty, do nothing
	if #vim.fn.getqflist() == 0 then
		return
	end

	-- if last quickfix item, move to first
	if vim.fn.getqflist({ idx = 0 }).idx == #vim.fn.getqflist() then
		vim.cmd("cfirst")
	else
		vim.cmd("cnext")
	end
end, { buffer = false })
vim.keymap.set("n", "qp", function()
	-- if quickfix is empty, do nothing
	if #vim.fn.getqflist() == 0 then
		return
	end
	-- if first quickfix item, move to last
	if vim.fn.getqflist({ idx = 0 }).idx == 1 then
		vim.cmd("clast")
	else
		vim.cmd("cprev")
	end
end, { buffer = false })
