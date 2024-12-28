-- MEMO:: "kelvinauta/focushere.nvim",
require("focushere").setup()

-- MEMO:: "rmagatti/session-lens",
require("session-lens").setup({
	path_display = { "shorten" },
})

-- MEMO:: "numToStr/Comment.nvim",
local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
-- enable comment
require("Comment").setup({
	-- for commenting tsx, jsx, svelte, html files
	pre_hook = ts_context_commentstring.create_pre_hook(),
})

-- MEMO:: "antonk52/markdowny.nvim",
require("markdowny").setup({ filetypes = { "markdown" } })

-- MEMO:: "pteroctopus/faster.nvim"
require("faster").setup()

-- MEMO:: "norcalli/nvim-colorizer.lua"
require("colorizer").setup()
