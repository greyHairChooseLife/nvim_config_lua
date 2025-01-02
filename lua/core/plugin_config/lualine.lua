local utils = require("core.utils")

local colors = {
	blue = "#61afef",
	git_add = "#40cd52",
	git_change = "#ffcc00",
	git_delete = "#f1502f",
	greenbg = "#98c379",
	purple = "#c678dd",
	orange = "#FF8C00",
	wwhite = "#abb2bf",
	white = "#ffffff",
	bblack = "#282c34",
	black = "#000000",
	grey = "#333342",
	bg = "#24283b",
	active_qf = "#db4b4b",
	nvimTree = "#333342",
	active_oil = "#BDB80B",
	purple1 = "#A020F0",
	red2 = "#DC143C",
}

local my_theme = {
	normal = {
		a = { fg = colors.orange, bg = colors.orange },
		b = { fg = colors.orange, bg = colors.bg },
		c = { fg = colors.black, bg = colors.greenbg },
		x = { fg = colors.black, bg = colors.orange },
		y = { fg = colors.wwhite, bg = colors.bg },
		z = { fg = colors.bg, bg = colors.orange },
	},
	inactive = {
		a = { fg = colors.orange, bg = colors.bg },
		b = { fg = colors.orange, bg = colors.bg },
		c = { fg = colors.grey, bg = colors.grey },
		x = { fg = colors.grey, bg = colors.grey },
		y = { fg = colors.grey, bg = colors.grey },
		z = { fg = colors.wwhite, bg = colors.grey },
	},
}

local function empty()
	return ""
end

local function this_is_space()
	return " "
end

local function get_git_branch()
	-- 현재 디렉토리가 Git 저장소인지 확인
	local git_dir = vim.fn.finddir(".git", ".;")
	if git_dir == "" then
		return "no git" -- Git 저장소가 아니면 빈 문자열 반환
	end

	-- 현재 Git 브랜치를 가져옴
	local handle = io.popen("git branch --show-current 2>/dev/null")
	local branch = handle:read("*a")
	handle:close()

	-- 줄바꿈 제거하고 브랜치 이름 반환
	return " " .. branch:gsub("%s+", "")
end

local function this_is_fugitive()
	return "- Fugitive -"
end

local function harpoon_length()
	-- get the length of the harpoon list
	local items = require("harpoon"):list():length()
	if items == 0 then
		return ""
	else
		return "󰀱 " .. items
	end
end

-- 각종 컴포넌트 스니펫이다.
-- https://github.com/nvim-lualine/lualine.nvim/wiki/Component-snippets

local my_quickfix = {
	filetypes = { "qf" },
	sections = {
		lualine_a = {
			{
				"filetype",
				color = { bg = colors.active_qf, fg = colors.white, gui = "bold,italic" },
				padding = { left = 3, right = 5 },
			},
		},
	},
	inactive_sections = {
		lualine_a = {
			{
				"filetype",
				color = { bg = colors.active_qf, fg = colors.white, gui = "bold,italic" },
				padding = { left = 3, right = 5 },
				separator = { right = "" },
			},
		},
		lualine_b = { { empty, color = { bg = colors.grey } } },
	},
}

local my_nvimTree = {
	filetypes = { "NvimTree" },
	sections = {
		lualine_a = {
			{
				get_git_branch,
				color = { bg = colors.nvimTree, fg = colors.orange, gui = "bold,italic" },
				padding = { left = 3 },
			},
			{
				harpoon_length,
				color = { bg = colors.nvimTree, fg = colors.orange, gui = "bold,italic" },
				padding = { left = 22, right = 3 },
			},
		},
	},
	inactive_sections = {
		lualine_a = {
			{
				get_git_branch,
				color = { bg = colors.nvimTree, fg = colors.orange, gui = "bold,italic" },
				padding = { left = 3 },
			},
		},
		lualine_z = {
			{
				harpoon_length,
				color = { bg = colors.nvimTree, fg = colors.orange, gui = "bold,italic" },
				padding = { left = 22, right = 4 },
			},
		},
	},
}

local my_fugitive = {
	filetypes = { "fugitive" },
	sections = {
		lualine_a = {
			{
				get_git_branch,
				color = { bg = colors.orange, fg = colors.bblack, gui = "bold,italic" },
				padding = { left = 3, right = 5 },
				-- separator = { right = "" },
			},
		},
		lualine_z = { { this_is_fugitive, color = { bg = colors.orange, fg = colors.bblack } } },
	},
	inactive_sections = {
		lualine_a = {
			{
				get_git_branch,
				color = { bg = colors.orange, fg = colors.bblack, gui = "bold,italic" },
				padding = { left = 3, right = 5 },
				-- separator = { right = "" },
			},
		},
		lualine_b = { { empty, color = { bg = colors.grey } } },
		lualine_z = { { this_is_fugitive, color = { bg = colors.grey, fg = colors.orange, gui = "italic" } } },
	},
}

local my_oil = {
	filetypes = { "oil" },
	sections = {
		lualine_a = {
			{
				"filetype",
				color = { bg = colors.active_oil, fg = colors.bblack, gui = "bold,italic" },
				padding = { left = 3, right = 5 },
			},
		},
	},
	inactive_sections = {
		lualine_a = {
			{
				"filetype",
				color = { bg = colors.active_oil, fg = colors.bblack, gui = "bold,italic" },
				padding = { left = 3, right = 5 },
				-- separator = { right = " " },
			},
		},
		lualine_b = { { empty, color = { bg = colors.grey } } },
		lualine_z = { { this_is_space, color = { bg = colors.grey } } },
	},
}

-- vim.api.nvim_set_hl(0, "CustomSeparator", { fg = "#98c379", bg = "NONE" })
--
require("lualine").setup({
	options = {
		icons_enabled = true,
		theme = my_theme,
		-- component_separators = { left = '', right = '' },
		-- section_separators = { left = '', right = '' },
		-- component_separators = { left = ' 󰪍󰪍 ', right = '' },
		-- section_separators = { left = '', right = '' },󰪍󰪍
		component_separators = { left = "%#CustomSeparator#████", right = "" },
		section_separators = { left = "", right = " " },
		disabled_filetypes = {
			statusline = { "packer", "alpha", "vimwiki", "aerial", "Avante", "AvanteInput" },
			-- winbar = {},
		},
		ignore_focus = {},
		always_divide_middle = false,
		globalstatus = false,
		refresh = {
			statusline = 50,
			tabline = 1000,
			winbar = 1000,
		},
	},
	sections = {
		lualine_a = {
			{
				"filename",
				file_status = false,
				newfile_status = false,
				symbols = {
					modified = "󰈸", -- Text to show when the file is modified.
					readonly = "", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "New", -- Text to show for unnamed buffers.
					newfile = "New", -- Text to show for newly created file before first write
				},
				color = {
					fg = colors.bg,
					gui = "bold",
				},
				separator = { right = "" },
			},
			{
				function()
					if vim.bo.modified then
						return "󰈸󰈸󰈸"
					elseif vim.bo.readonly or vim.bo.buftype == "nowrite" or vim.bo.buftype == "nofile" then
						return " "
					else
						return " "
					end
				end,
				padding = { left = 0, right = 1 },
				color = function()
					if vim.bo.modified then
						return { fg = colors.red2 }
					elseif vim.bo.readonly or vim.bo.buftype == "nowrite" or vim.bo.buftype == "nofile" then
						return { fg = colors.purple1 }
					else
						return {}
					end
				end,
			},
		},
		lualine_b = {
			{
				"diff",
				diff_color = {
					added = { fg = colors.git_add },
					modified = { fg = colors.git_change },
					removed = { fg = colors.git_delete },
				},
				symbols = {
					added = utils.icons.git.Add,
					modified = utils.icons.git.Change,
					removed = utils.icons.git.Delete,
				},
			},
			{
				"diagnostics",
				diagnostics_color = {
					error = "DiagnosticError",
					warn = "DiagnosticWarn",
					info = "DiagnosticInfo",
					hint = "DiagnosticHint",
				},
				symbols = {
					error = utils.icons.diagnostics.Error .. " ",
					warn = utils.icons.diagnostics.Warn .. " ",
					hint = utils.icons.diagnostics.Hint .. " ",
					info = utils.icons.diagnostics.Info .. " ",
				},
			},
		},
		lualine_c = {},
		lualine_x = {},
		lualine_y = {
			{
				"harpoon2",
				icon = "", -- 󰀱 󰃀 󰃃  󰆡  
				indicators = { "", "", "", "", "", "" },
				active_indicators = { "", "", "", "", "", "" },
				color_active = { fg = colors.orange, bg = colors.bg, gui = "bold" },
				_separator = "", --  󱋰 󰇜 󰇼 󱗘 󰑅 󱒖 󰩮 󰦟 󰓡    
				no_harpoon = "Harpoon not loaded",
				padding = { left = 1, right = 1 },
			},
		},
		lualine_z = {
			{ "location", padding = { left = 0, right = 1 } },
			{ "progress", padding = { left = 1, right = 1 } },
		},
	},
	inactive_sections = {
		lualine_a = {
			{
				"filename",
				file_status = false,
				newfile_status = false,
				symbols = {
					modified = "󰈸", -- Text to show when the file is modified.
					readonly = "", -- Text to show when the file is non-modifiable or readonly.
					unnamed = "New", -- Text to show for unnamed buffers.
					newfile = "New", -- Text to show for newly created file before first write
				},
				color = {
					fg = colors.wwhite,
					gui = "italic",
				},
				separator = { right = "" },
			},
			{
				function()
					if vim.bo.modified then
						return "󰈸"
					elseif vim.bo.readonly or vim.bo.buftype == "nowrite" or vim.bo.buftype == "nofile" then
						return ""
					else
						return " "
					end
				end,
				padding = { left = 0, right = 1 },
				color = {
					fg = colors.orange,
				},
			},
		},
		lualine_b = {
			{
				"diff",
				diff_color = {
					added = { fg = colors.git_add },
					modified = { fg = colors.git_change },
					removed = { fg = colors.git_delete },
				},
				symbols = {
					added = utils.icons.git.Add,
					modified = utils.icons.git.Change,
					removed = utils.icons.git.Delete,
				},
			},
			{
				"diagnostics",
				diagnostics_color = {
					error = "DiagnosticError",
					warn = "DiagnosticWarn",
					info = "DiagnosticInfo",
					hint = "DiagnosticHint",
				},
				symbols = {
					error = utils.icons.diagnostics.Error .. " ",
					warn = utils.icons.diagnostics.Warn .. " ",
					hint = utils.icons.diagnostics.Hint .. " ",
					info = utils.icons.diagnostics.Info .. " ",
				},
			},
		},
		lualine_z = {
			{
				"harpoon2",
				-- icon = '♥',
				icon = "",
				indicators = { "", "", "", "", "", "" },
				active_indicators = { "", "", "", "", "", "" },
				color_active = { fg = colors.orange, bg = colors.bg, gui = "bold" },
				_separator = "", --  󱋰 󰇜 󰇼 󱗘 󰑅 󱒖 󰩮 󰦟 󰓡    
				no_harpoon = "Harpoon not loaded",
			},
		},
	},
	tabline = {},
	winbar = {},
	inactive_winbar = {},
	extensions = { "toggleterm", my_quickfix, my_nvimTree, my_fugitive, my_oil },
})
