-- test function
local function temp_test()
	vim.ui.select({ "one", "two" }, {
		prompt = "Select tabs or spaces:",
		format_item = function(item)
			return "I'd like to choose " .. item
		end,
	}, function(choice)
		print("choice: ", choice)
	end)
end

vim.keymap.set("n", "<leader>q", temp_test, { noremap = true, silent = true })
