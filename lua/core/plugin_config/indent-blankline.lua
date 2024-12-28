vim.api.nvim_set_hl(0, "MyBG", { fg = "#24283b" })
vim.api.nvim_set_hl(0, "MyFG", { fg = "#5F5F5F" })

require("ibl").setup({
	enabled = true,
	indent = {
		char = "▏",
		smart_indent_cap = true,
		repeat_linebreak = false,
		highlight = { "MyBG" },
	},
	-- whitespace = { highlight = { "Whitespace", "NonText" } },
	scope = {
		enabled = true,
		-- char = "▍",
		char = "▏",
		highlight = { "MyFG" },
		show_start = false,
		show_end = false,
		injected_languages = false,
		priority = 500,
		-- exclude = { language = { "lua" } },
	},
})
