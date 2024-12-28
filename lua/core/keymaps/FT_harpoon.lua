vim.api.nvim_create_autocmd("FileType", {
	pattern = "harpoon",
	callback = function()
		-- GUI

		-- KEYMAP
		vim.keymap.set("n", "gq", function()
			vim.cmd("silent q")
		end, { buffer = true })
		vim.keymap.set("n", "gw", function()
			vim.cmd("silent w")
			vim.notify("Harpoon Updated", 3, { render = "minimal" })
		end, { buffer = true })
		vim.keymap.set("n", "ge", function()
			vim.cmd("silent w")
			vim.notify("Harpoon Updated", 3, { render = "minimal" })
		end, { buffer = true })
	end,
})
