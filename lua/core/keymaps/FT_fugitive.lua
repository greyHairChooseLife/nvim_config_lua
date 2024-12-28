vim.api.nvim_create_autocmd("FileType", {
	pattern = "fugitive",
	callback = function()
		-- GUI
		vim.api.nvim_set_hl(0, "FugitiveBufferHighlight", { bg = "#242024" })
		vim.api.nvim_set_hl(0, "FugitiveBufferEOB", { fg = "#242024" })
		vim.cmd(
			"setlocal winhighlight=Normal:FugitiveBufferHighlight,SignColumn:FugitiveBufferHighlight,EndOfBuffer:FugitiveBufferEOB"
		)

		-- Keymap
		local opts = { buffer = true }

		vim.keymap.set("n", "P", ":G push", opts)
		vim.keymap.set("n", "F", "<Cmd>G fetch<CR>", opts)
		vim.keymap.set("n", "gq", function()
			vim.cmd("q")
			-- DEPRECATED:: 2024-12-28
			-- if vim.fn.winnr("$") == 1 then
			-- 	vim.cmd("q")
			-- elseif vim.fn.winnr("$") == 2 and require("nvim-tree.api").tree.is_visible() then
			-- 	vim.cmd("q")
			-- else
			-- 	vim.cmd("bd!")
			-- end
		end, opts) -- close buffer, saving memory
		vim.keymap.set("n", "i", function()
			vim.cmd("normal =")
		end, opts) -- do nothing
	end,
})
