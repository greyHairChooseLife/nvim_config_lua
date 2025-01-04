local ensure_packer = function()
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		fn.system({ "git", "clone", "--depth", "1", "https://github.com/wbthomason/packer.nvim", install_path })
		vim.cmd([[packadd packer.nvim]])
		return true
	end
	return false
end

local packer_bootstrap = ensure_packer()

return require("packer").startup(function(use)
	use("wbthomason/packer.nvim")
	use("folke/tokyonight.nvim")
	use("nvim-tree/nvim-tree.lua")
	use("nvim-tree/nvim-web-devicons")
	use({ "nvim-treesitter/nvim-treesitter", run = ":TSUpdate" })
	use({ "nvim-telescope/telescope.nvim", tag = "0.1.8", requires = { "nvim-lua/plenary.nvim" } })
	use("nvim-telescope/telescope-ui-select.nvim")

	-- DEPRECATED:: 2024-12-28
	-- LSP with coc
	-- use { 'neoclide/coc.nvim', branch = 'release' }
	-- use { 'fannheyward/telescope-coc.nvim' }

	-- MEMO:: LSP with mason
	-- 1. mason
	-- 2. mason-lspconfig
	-- 3. nvim-lspconfig
	use({
		"williamboman/mason.nvim",
		config = function()
			require("mason").setup()
		end,
	})
	use({
		"williamboman/mason-lspconfig.nvim",
		after = "mason.nvim",
		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"ts_ls",
				},
			})
		end,
	})
	use({
		"neovim/nvim-lspconfig",
		after = { "mason-lspconfig.nvim", "cmp_nvim_lsp" },
		config = function()
			local lspconfig = require("lspconfig")
			local cmp_nvim_lsp = require("cmp_nvim_lsp")

			-- 내장 lsp에 nvim-cmp에서 요구하는 확장 기능을 추가해 준다.
			local capabilities = cmp_nvim_lsp.default_capabilities()

			lspconfig.lua_ls.setup({
				capabilities = capabilities,
			})
			lspconfig.ts_ls.setup({
				capabilities = capabilities,
			})
		end,
	})

	-- MEMO:: coc에서 제공하던 것들
	-- FIX: 이게 되는거야 안되는거야 진짜 화나네!!!!!
	use({
		"stevearc/conform.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("conform").setup({
				formatters_by_ft = {
					lua = { "stylua", stop_after_first = true },
					javascript = { "prettierd", "prettier", stop_after_first = true },
					typescript = { "prettierd", "prettier", stop_after_first = true },
					javascriptreact = { "prettierd", "prettier", stop_after_first = true },
					typescriptreact = { "prettierd", "prettier", stop_after_first = true },
					json = { "prettier", stop_after_first = true },
				},
				format_on_save = {
					timeout_ms = 500,
					lsp_fallback = true,
				},
			})
		end,
	})

	--nvim-cmp with sources
	use({ "hrsh7th/cmp-buffer" })
	use({ "hrsh7th/cmp-path" })
	use({ "hrsh7th/cmp-cmdline" })
	use({ "hrsh7th/cmp-nvim-lsp" })
	use({ "L3MON4D3/LuaSnip", tag = "v2.*", run = "make install_jsregexp" })
	use({ "saadparwaiz1/cmp_luasnip" })
	use({ "rafamadriz/friendly-snippets" })
	use({
		"hrsh7th/nvim-cmp",
		requires = {
			"windwp/nvim-autopairs",
			config = function()
				require("nvim-autopairs").setup()
			end,
		},
	})

	-- DEPRECATED:: 2024-12-28
	-- use({ "kevinhwang91/nvim-ufo", requires = "kevinhwang91/promise-async" }) -- folding

	-- DEPRECATED:: 2024-12-28
	-- use 'pangloss/vim-javascript'    -- JavaScript support
	-- use 'leafgarland/typescript-vim' -- TypeScript syntax
	-- use 'maxmellon/vim-jsx-pretty'   -- JS and JSX syntax
	-- use 'jparise/vim-graphql'        -- GraphQL syntax

	-- DEPRECATED:: 2024-12-28
	-- use("itchyny/calendar.vim")

	use("vimwiki/vimwiki")

	use("tpope/vim-fugitive")
	use("tpope/vim-surround") -- check advanced usage https://www.youtube.com/watch?v=96FS45IaUgo
	use("greyhairchooselife/gv.vim") -- 일부 개선을 위해 'junegunn/gv.vim' folk 해옴

	use({
		"ldelossa/gh.nvim",
		requires = { { "ldelossa/litee.nvim" }, { "nvim-tree/nvim-web-devicons", opt = true } },
	})

	use({
		"iamcco/markdown-preview.nvim",
		run = function()
			vim.fn["mkdp#util#install"]()
		end,
	})
	-- MEMO:
	--
	-- ETC
	--  markdown 파일 작성중에 workflow의 끊김없이 이미지를 캡쳐해오는 방법 https://github.com/kiran94/maim.nvim

	use("norcalli/nvim-colorizer.lua")

	-- DEPRECATED:: 2024-12-28
	-- use "junegunn/goyo.vim"
	-- use "junegunn/vim-easy-align"

	use({ "sindrets/diffview.nvim", requires = "nvim-lua/plenary.nvim" })

	use({
		"nvim-lualine/lualine.nvim",
		-- commit = '640260d', -- 이 이후 버전부터 성능 이유가 있다. github에 이슈 작성함. -> 이슈 해결(https://github.com/nvim-lualine/lualine.nvim/issues/1328)
		requires = { "nvim-tree/nvim-web-devicons", opt = true },
	})

	use("github/copilot.vim")

	-- DEPRECATED:: 2024-12-28
	-- use {
	--   'akinsho/flutter-tools.nvim',
	--   requires = {
	--     'nvim-lua/plenary.nvim',
	--   },
	-- }

	use("sindrets/winshift.nvim")

	use({ "lewis6991/gitsigns.nvim" })

	use({ "akinsho/toggleterm.nvim" })

	--image renderer
	--dependencies
	--pacman -S imagemagick
	--pacman -S luarocks
	--luarocks --lua-version 5.1 install --local magick
	-- Example for configuring Neovim to load user-installed installed Lua rocks:
	package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
	package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
	--pacman -S kitty
	use("3rd/image.nvim")

	use({
		"antonk52/markdowny.nvim",
		commit = "9881051", -- 내 나름대로 수정한 버전으로 고정해서 사용. 이후에 딱히 변경도 없다.
		-- DEPRECATED:: 2024-12-28
		-- config = function()
		-- 	require("markdowny").setup({ filetypes = { "markdown" } })
		-- end,
	})

	use("stevearc/aerial.nvim")
	-- MEMO::
	-- 대체제 -> 'hedyhli/outline.nvim'  -- react 파일 열어보면 parsing을 너무 못한다.

	use({
		"numToStr/Comment.nvim",
		requires = { "JoosepAlviste/nvim-ts-context-commentstring" },
		-- DEPRECATED:: 2024-12-28
		-- config = function()
		-- 	-- import comment plugin safely
		-- 	local comment = require("Comment")
		--
		-- 	local ts_context_commentstring = require("ts_context_commentstring.integrations.comment_nvim")
		-- 	-- enable comment
		-- 	comment.setup({
		-- 		-- for commenting tsx, jsx, svelte, html files
		-- 		pre_hook = ts_context_commentstring.create_pre_hook(),
		-- 	})
		-- end,
	})

	use({ "ggandor/leap.nvim" })

	use({
		"rmagatti/auto-session",
		config = function()
			require("auto-session").setup({
				log_level = "error",
				auto_session_suppress_dirs = { "~/", "~/test", "~/Downloads", "/*" },
				session_lens = {
					buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
					load_on_setup = true,
					theme_conf = {
						border = true,
						layout_config = {
							width = 1.8, -- Can set width and height as percent of window
							height = 0.5,
						},
					},
					previewer = false,
				},
				auto_save_enabled = false,
			})
		end,
	})

	use("lukas-reineke/indent-blankline.nvim")

	use({
		"folke/todo-comments.nvim",
		requires = "nvim-lua/plenary.nvim",
	})

	use({ "nvim-telescope/telescope-hop.nvim" })
	use({ "nvim-telescope/telescope-fzf-native.nvim", run = "make" })
	-- use 'rcarriga/nvim-notify'

	use({ "tpope/vim-dadbod" })
	use({ "kristijanhusak/vim-dadbod-ui" })
	use({ "kristijanhusak/vim-dadbod-completion" })

	use({ "goolord/alpha-nvim" }) -- dashboard

	use({ "ryanoasis/vim-devicons" })
	use({ "MeanderingProgrammer/markdown.nvim" })

	use({ "stevearc/quicker.nvim" }) -- quickfix superset

	use({ "pteroctopus/faster.nvim" }) -- handle big big files

	use({
		"ryanmsnyder/toggleterm-manager.nvim",
		requires = {
			"akinsho/nvim-toggleterm.lua",
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
		},
		-- config = true, fixed with https://github.com/wbthomason/packer.nvim/issues/908#issuecomment-1133901800
	})

	use({ "stevearc/oil.nvim" })

	use({
		"yetone/avante.nvim",
		build = "make BUILD_FROM_SOURCE=true",
		lazy = false,
		version = false,
		BUILD_FROM_SOURCE = true,
		requires = {
			"nvim-treesitter/nvim-treesitter",
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"HakonHarnes/img-clip.nvim",
		},
	})
	-- MEMO:
	--
	-- HOW TO INSTALL
	--  https://github.com/yetone/avante.nvim/issues/581#issuecomment-2394807552 packer 전용 플러그인 정의
	--  https://github.com/yetone/avante.nvim/issues/612#issuecomment-2375729928 설치 후 build 방법
	--  https://github.com/yetone/avante.nvim/issues/612#issuecomment-2401169692 cnofig에 앞서 avante_lib을 불러와야한다.

	use({
		"ThePrimeagen/harpoon",
		branch = "harpoon2",
		commit = "e76cb03", -- primegin 이양반 버그가 있는데 개선을 안한다. https://github.com/ThePrimeagen/harpoon/issues/577#issuecomment-2275638768
		requires = { "nvim-lua/plenary.nvim" },
	})

	use({
		"letieu/harpoon-lualine",
		opt = false,
		requires = { "ThePrimeagen/harpoon" },
	})

	use({ "metakirby5/codi.vim" })

	use({
		"greyhairchooselife/timerly.nvim",
		requires = { "nvzone/volt" },
	})

	use({
		"folke/twilight.nvim",
		opts = {
			context = 1, -- amount of lines we will try to show around the current line
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	})

	use({
		"mistricky/codesnap.nvim",
		run = "make",

		-- MEMO: code to img
		-- USAGE
		--  https://github.com/mistricky/codesnap.nvim?tab=readme-ov-file#usage
		-- ALTERNATIVE
		--  https://github.com/0oAstro/silicon.lua
		--  https://github.com/Aloxaf/silicon
	})

	use({ "cdmill/focus.nvim" })
	use({
		"kelvinauta/focushere.nvim",
		-- DEPRECATED:: 2024-12-28
		-- config = function()
		-- 	require("focushere").setup()
		-- end,
	})

	if packer_bootstrap then
		require("packer").sync()
	end
end)
