local M = {}

M.icons = {
	diagnostics = { Error = "✘", Warn = "", Hint = "i", Info = "i" },
	git = {
		Add = "+",
		Change = "~",
		Delete = "-",
	},
	kinds = {
		Array = "󰅪",
		Branch = "",
		Boolean = "󰨙",
		Class = "󰠱",
		Color = "󰏘",
		Constant = "󰏿",
		Constructor = "",
		Enum = "",
		EnumMember = "",
		Event = "",
		Field = "",
		File = "",
		Folder = "󰉋",
		Function = "󰊕",
		Interface = "",
		Key = "",
		Keyword = "󰌋",
		Method = "󰆧",
		Module = "󰏗 ",
		Namespace = "󰅩",
		Number = "󰎠",
		Null = "",
		Object = "",
		Operator = "+",
		Package = "",
		Property = "󰜢",
		Reference = "",
		Snippet = "",
		String = "𝓐",
		Struct = "󰙅",
		Text = "",
		TypeParameter = "󰆩",
		Unit = "",
		Value = "󰎠",
		Variable = "󰀫",
	},
	cmp_sources = {
		LSP = "✨",
		Luasnip = "🚀",
		Buffer = "📝",
		Path = "📁",
		Cmdline = "💻",
	},
	statusline = {
		Error = "❗",
		Warn = "⚠️ ",
		Hint = "i",
		Info = "💡",
	},
}

M.url_encode = function(str)
	if str then
		str = string.gsub(str, "\n", "\r\n")
		str = string.gsub(str, "([^%w %-%_%.%~])", function(c)
			return string.format("%%%02X", string.byte(c))
		end)
		str = string.gsub(str, " ", "+")
	end
	return str
end

M.get_visual_text = function()
	vim.cmd('noau normal! "vy"')
	local text = vim.fn.getreg("v")
	vim.fn.setreg("v", {})

	text = string.gsub(text, "\n", "")
	if #text > 0 then
		return text
	else
		return ""
	end
end

return M
