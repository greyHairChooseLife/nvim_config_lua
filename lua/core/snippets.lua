-- TODO: 스니펫은 아무래도 ,,로 시작해서 2개 캐릭터 정도로 좁히는게 적절할듯? 통일하자.

-- 날짜 찍기
vim.keymap.set("i", ",d", function()
	local date_text = vim.fn.system('date "+%Y-%m-%d"'):gsub("\n$", "")
	vim.api.nvim_put({ date_text }, "c", false, true)
end, { noremap = true, silent = true })
vim.keymap.set("i", ",D", function() -- 2024. 06. 11. (화) 17:52:17 KST
	local date_text = vim.fn.system("date"):gsub("\n$", "")
	vim.api.nvim_put({ date_text }, "c", false, true)
end, { noremap = true, silent = true })

-- 주석
local function Insert_comment(comment)
	vim.api.nvim_put({ comment }, "c", true, false)
	require("Comment.api").toggle.linewise.current()
	vim.cmd("startinsert!")
end

vim.keymap.set("i", ",,T", function()
	Insert_comment("TODO:: ")
end)
vim.keymap.set("i", ",,P", function()
	Insert_comment("PSEUDO_CODE:: ")
end)
vim.keymap.set("i", ",,M", function()
	Insert_comment("MEMO:: ")
end)
vim.keymap.set("i", ",,W", function()
	Insert_comment("WARN:: ")
end)
vim.keymap.set("i", ",,E", function()
	local date = vim.fn.system('date "+%Y-%m-%d"'):gsub("\n$", "")
	local text = string.format("DEPRECATED:: %s", date)
	vim.api.nvim_put({ text }, "c", true, false)
	require("Comment.api").toggle.linewise.current()
	vim.api.nvim_input("<Esc>o")
end)
vim.keymap.set("i", ",,D", function()
	local comment_text_start = "START_debug:"
	local comment_text_end = "END___debug:"
	vim.api.nvim_put({ comment_text_start, comment_text_end }, "c", false, false)

	require("Comment.api").toggle.linewise.count(2)
	vim.api.nvim_input("<Esc>o<Esc>cc")
end)

-- console.log
function Insert_console_log()
	local log_message = "console.log();"
	local current_pos = vim.api.nvim_win_get_cursor(0)
	vim.api.nvim_put({ log_message }, "c", true, true)
	vim.api.nvim_win_set_cursor(0, { current_pos[1], current_pos[2] + #log_message - 2 })
end

-- DEPRECATED:: 2024-12-26
-- -- 비주얼 모드에서 선택한 텍스트 가져오기
-- local function get_visual_selection()
--   local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
--   local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
--   if csrow == cerow then
--     return string.sub(vim.fn.getline(csrow), cscol, cecol)
--   else
--     local lines = vim.fn.getline(csrow, cerow)
--     lines[1] = string.sub(lines[1], cscol, -1)
--     lines[#lines] = string.sub(lines[#lines], 1, cecol)
--     return table.concat(lines, '\n')
--   end
-- end

function Insert_console_log_Visual()
	local file_path = vim.fn.expand("%:~:.") -- 상대경로
	local line_number = vim.fn.line(".")

	local selected_text = GetVisualText()
	local log_message =
		string.format("console.log('At: %s: %d\\n', '%s: ', %s);", file_path, line_number, selected_text, selected_text)

	vim.api.nvim_put({ log_message }, "l", true, true)
	vim.api.nvim_input("k")
end
