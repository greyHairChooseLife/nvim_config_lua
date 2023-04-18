require'nvim-treesitter.configs'.setup {
	-- A list of parser names, or "all"
	ensure_installed = { "javascript", "typescript", "css", "diff", "dot", "dockerfile", "bash", "css", "html", "git_rebase", "gitattributes", "gitcommit", "gitignore", "jq", "json", "lua", "markdown", "markdown_inline", "sql", "regex", "scss", "vim", "vimdoc"  },

	sync_install = false,
	auto_install = true,
	highlight = {
		enable = true,
	},
}
