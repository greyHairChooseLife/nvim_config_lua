local M = {}

M.icons = {
	diagnostics = {
		Error = " ",
		Warn = " ",
		Hint = " ",
		Info = " ",
	},
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
		Error = " ",
		Warn = " ",
		Hint = " ",
		Info = " ",
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

M.tree = {
	api = require("nvim-tree.api"),
	is_visible = function(self)
		return self.api.tree.is_visible()
	end,
	open = function(self)
		local tree_api = self.api.tree

		tree_api.toggle({ find_files = true, focus = false })
		if self:is_visible() then
			ShowCursor()
		end
	end,
}

return M
