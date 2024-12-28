require("tokyonight").setup({
	style = "storm",
	on_colors = function(colors)
		--   bg = "#24283b",
		--   bg_dark = "#1f2335",
		colors.bg_float = "#000000"
		colors.bg_highlight = "#545c7e"
		-- colors.bg_popup = colors.error
		colors.bg_search = "#1abc9c"
		--   bg_sidebar = "#1f2335",
		colors.bg_statusline = colors.red1
		colors.bg_visual = "#4D6B89"
		--   black = "#1d202f",
		--   blue = "#7aa2f7",
		--   blue0 = "#3d59a1",
		--   blue1 = "#2ac3de",
		--   blue2 = "#0db9d7",
		--   blue5 = "#89ddff",
		--   blue6 = "#b4f9f8",
		--   blue7 = "#394b70",
		--   border = "#1d202f",
		colors.border_highlight = "#29a4bd"
		--   comment = "#565f89",
		--   cyan = "#7dcfff",
		--   dark3 = "#545c7e",
		--   dark5 = "#737aa2",
		--   diff = {
		--     add = "#283b4d",
		--     change = "#272d43",
		--     delete = "#3f2d3d",
		--     text = "#394b70"
		--   },
		--   error = "#db4b4b",
		--   fg = "#c0caf5",
		--   fg_dark = "#a9b1d6",
		--   fg_float = "#c0caf5",
		--   fg_gutter = "#3b4261",
		--   fg_sidebar = "#a9b1d6",
		--   git = {
		--     add = "#4097a3",
		--     change = "#506d9b",
		--     delete = "#c47981",
		--     ignore = "#545c7e"
		--   },
		--   gitSigns = {
		--     add = "#399a96",
		--     change = "#6382bd",
		--     delete = "#c25d64"
		--   },
		--   green = "#9ece6a",
		--   green1 = "#73daca",
		--   green2 = "#41a6b5",
		--   hint = "#1abc9c",
		--   info = "#0db9d7",
		--   magenta = "#bb9af7",
		--   magenta2 = "#ff007c",
		--   none = "NONE",
		--   orange = "#ff9e64",
		--   purple = "#9d7cd8",
		--   red = "#f7768e",
		--   red1 = "#db4b4b",
		--   teal = "#1abc9c",
		--   terminal_black = "#414868",
		--   warning = "#e0af68",
		--   yellow = "#e0af68"
	end,
})

vim.cmd([[colorscheme tokyonight]])
