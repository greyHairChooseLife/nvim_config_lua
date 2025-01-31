require("litee.lib").setup({
	tree = {
		icon_set = "nerd",
	},
	panel = {
		orientation = "left",
		panel_size = 30,
	},
})
require("litee.gh").setup({
	-- deprecated, around for compatability for now.
	jump_mode = "invoking",
	-- remap the arrow keys to resize any litee.nvim windows.
	map_resize_keys = false,
	-- do not map any keys inside any gh.nvim buffers.
	disable_keymaps = false,
	-- the icon set to use.
	icon_set = "nerd",
	-- any custom icons to use.
	icon_set_custom = nil,
	-- whether to register the @username and #issue_number omnifunc completion
	-- in buffers which start with .git/
	git_buffer_completion = true,
	-- defines keymaps in gh.nvim buffers.
	keymaps = {
		-- when inside a gh.nvim panel, this key will open a node if it has
		-- any futher functionality. for example, hitting <CR> on a commit node
		-- will open the commit's changed files in a new gh.nvim panel.
		open = "<CR>",
		-- when inside a gh.nvim panel, expand a collapsed node
		expand = "zo",
		-- when inside a gh.nvim panel, collpased and expanded node
		collapse = "zc",
		-- when cursor is over a "#1234" formatted issue or PR, open its details
		-- and comments in a new tab.
		goto_issue = "<CR>",
		-- show any details about a node, typically, this reveals commit messages
		-- and submitted review bodys.
		details = "d",
		-- inside a convo buffer, submit a comment
		submit_comment = "<C-s>",
		-- inside a convo buffer, when your cursor is ontop of a comment, open
		-- up a set of actions that can be performed.
		actions = "<C-a>",
		-- inside a thread convo buffer, resolve the thread.
		resolve_thread = "<C-r>",
		-- inside a gh.nvim panel, if possible, open the node's web URL in your
		-- browser. useful particularily for digging into external failed CI
		-- checks.
		goto_web = "gw", -- go web
		-- if selectable, select the object under the cursor for additional operations.
		select = "gs",
		-- if selectable, clear all selected items.
		clear_selection = "gss",
	},
})

function GGOpenPRs()
	vim.cmd("GHOpenPR")
end

function GGstartReview()
	vim.cmd("GHStartReview")
end

function GGsubmitReview()
	vim.cmd("GHSubmitReview")
end

function GGdeleteReview()
	vim.cmd("GHDeleteReview")
end

function GGcomment()
	vim.cmd("GHCreateThread")
end

vim.cmd("command! GGopenPRs lua GGOpenPRs()")
vim.cmd("command! GGstartReview lua GGstartReview()")
vim.cmd("command! GGsubmitReview lua GGsubmitReview()")
vim.cmd("command! GGdeleteReview lua GGdeleteReview()")
vim.cmd("command! GGcomment lua GGcomment()")
