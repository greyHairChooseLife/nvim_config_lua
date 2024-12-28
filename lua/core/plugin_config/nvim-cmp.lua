--nvim-cmp
require("luasnip.loaders.from_vscode").lazy_load()
local luasnip = require("luasnip")

local has_words_before = function()
	unpack = unpack or table.unpack
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local cmp = require("cmp")
local state = {
	sort = "buf", -- 'buf', 'lsp' or 'snip', 어떤 completion이 로드되었는지 상태를 저장
	is_loading = false, -- completion이 로드되었는지 상태를 저장
}

cmp.setup({
	snippet = {
		-- REQUIRED - you must specify a snippet engine
		expand = function(args)
			luasnip.lsp_expand(args.body) -- For `luasnip` users.
		end,
	},

	window = {
		completion = { side_padding = 1 },
		documentation = {
			border = { "", "", "", "", "", "", "", "▊" },
			winhighlight = "FloatBorder:CmpDocBorder",
			max_width = 120,
			max_height = 50,
		},
	},

	mapping = cmp.mapping.preset.insert({
		["<A-j>"] = cmp.mapping.scroll_docs(2),
		["<A-k>"] = cmp.mapping.scroll_docs(-2),
		-- ['<C-l>'] = cmp.mapping.complete(), -- cmp창 강제 열기
		["<C-e>"] = cmp.mapping.abort(),
		["<CR>"] = cmp.mapping.confirm({ select = false }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
		["<TAB>"] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.

		["<C-j>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item({ behavior = cmp.SelectBehavior.Select })
			elseif luasnip.expand_or_jumpable() then
				luasnip.expand_or_jump()
			else
				fallback()
			end
		end, { "i" }),

		["<C-k>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_prev_item({ behavior = cmp.SelectBehavior.Select })
			elseif luasnip.jumpable(-1) then
				luasnip.jump(-1)
			else
				fallback()
			end
		end, { "i" }),

		["<C-n>"] = cmp.mapping(function(fallback)
			if state.is_loading then
				return
			end
			if has_words_before() and state.sort == "buf" then
				cmp.abort()
				state.is_loading = true
				state.sort = "lsp"
				cmp.complete({
					config = {
						sources = {
							{ name = "nvim_lsp", max_item_count = 15 },
						},
					},
				})
				cmp.event:on("menu_opened", function()
					state.is_loading = false
				end)
				return
			end
			if has_words_before() and state.sort == "lsp" then
				cmp.abort()
				state.is_loading = true
				state.sort = "snip"
				cmp.complete({
					config = {
						sources = {
							{ name = "luasnip", max_item_count = 15, keyword_length = 3 },
						},
					},
				})
				cmp.event:on("menu_opened", function()
					state.is_loading = false
				end)
				return
			end
			if has_words_before() and state.sort == "snip" then
				cmp.abort()
				state.is_loading = true
				state.sort = "buf"
				cmp.complete({
					config = {
						sources = {
							{ name = "buffer" },
							{ name = "path" },
						},
					},
				})
				cmp.event:on("menu_opened", function()
					state.is_loading = false
				end)
				return
			end

			fallback()
		end, { "i", "s" }),

		["<C-p>"] = cmp.mapping(function(fallback)
			if state.is_loading then
				return
			end

			if has_words_before() and state.sort == "snip" then
				cmp.abort()
				state.is_loading = true
				state.sort = "lsp"
				cmp.complete({
					config = {
						sources = {
							{ name = "nvim_lsp", max_item_count = 15 },
						},
					},
				})
				cmp.event:on("menu_opened", function()
					state.is_loading = false
				end)
				return
			end
			if has_words_before() and state.sort == "lsp" then
				cmp.abort()
				state.is_loading = true
				state.sort = "buf"
				cmp.complete({
					config = {
						sources = {
							{ name = "buffer" },
							{ name = "path" },
						},
					},
				})
				cmp.event:on("menu_opened", function()
					state.is_loading = false
				end)
				return
			end
			if has_words_before() and state.sort == "buf" then
				cmp.abort()
				state.is_loading = true
				state.sort = "snip"
				cmp.complete({
					config = {
						sources = {
							{ name = "luasnip", max_item_count = 15, keyword_length = 3 },
						},
					},
				})
				cmp.event:on("menu_opened", function()
					state.is_loading = false
				end)
				return
			end

			fallback()
		end, { "i", "s" }),
	}),
	sources = cmp.config.sources(
		-- {{  name = "nvim_lsp", max_item_count = 10 }, }, -- lsp
		{ { name = "buffer" } }, -- text within current buffer
		{ { name = "path" } } -- file system paths
		-- { name = "luasnip", max_item_count = 15 }, -- 우선적으로 로드
	),
})

-- Use buffer source for `/` and `?` (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline({ "/", "?" }, {
	mapping = cmp.mapping.preset.cmdline(),
	sources = {
		{ name = "buffer" },
	},
})

-- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
cmp.setup.cmdline(":", {
	mapping = cmp.mapping.preset.cmdline(),
	sources = cmp.config.sources({
		{ name = "path" },
	}, {
		{ name = "cmdline" },
	}),
})
