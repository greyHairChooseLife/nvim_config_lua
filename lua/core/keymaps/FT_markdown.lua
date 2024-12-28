vim.api.nvim_create_autocmd("FileType", {
	pattern = "markdown",
	callback = function()
		-- GUI
		-- vim.cmd('IBLEnable')
		-- vim.api.nvim_set_hl(0, "LineNr", { fg = "#24283B" })
		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#24283B" })
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#24283B" })

		-- SNIPPET
		vim.keymap.set("i", ",,h2", function()
			vim.api.nvim_feedkeys("## ", "i", true)
		end)
		vim.keymap.set("i", ",,h3", function()
			vim.api.nvim_feedkeys("### ", "i", true)
		end)
		vim.keymap.set("i", ",,h4", function()
			vim.api.nvim_feedkeys("#### ", "i", true)
		end)

		-- KEYMAPS
		vim.keymap.set("n", "PP", "<cmd>MarkdownPreview<CR>", { buffer = true })
		vim.keymap.set("v", "i", "<ESC>i", { buffer = true })
		vim.keymap.set("v", "a", "<ESC>a", { buffer = true })
	end,
})
