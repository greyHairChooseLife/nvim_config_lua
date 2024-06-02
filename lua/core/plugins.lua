local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({ 'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path })
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()

vim.cmd([[:highlight CustomSignsAdd guifg=#1abc9c]])
vim.cmd([[:highlight CustomSignsAddBg guibg=#afccc7]])
vim.cmd([[:highlight CustomSignsChange guifg=#ff007c]])
vim.cmd([[:highlight CustomSignsChangeBg guibg=#e0af68]])
vim.cmd([[:highlight CustomSignsDelete guifg=#e06c75]])
vim.cmd([[:highlight CustomSignsDeleteBg guibg=#e06c75]])

vim.cmd("highlight OutlineCurrent guifg=#e5c07b guibg=#3e4452")
vim.cmd("highlight MyOutlineNormal guibg=#2e2e2e")


return require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'folke/tokyonight.nvim'
  use 'nvim-tree/nvim-tree.lua'
  use 'nvim-tree/nvim-web-devicons'
  use {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate'
  }
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.5',
    requires = { { 'nvim-lua/plenary.nvim' } }
  }
  use 'nvim-telescope/telescope-ui-select.nvim'

  use { 'neoclide/coc.nvim', branch = 'release' }
  -- manually: CocInstall coc-tsserver, coc-pairs, coc-css, coc-html, coc-json, coc-prettier, coc-word, coc-graphql

  use 'pangloss/vim-javascript'    -- JavaScript support
  use 'leafgarland/typescript-vim' -- TypeScript syntax
  use 'maxmellon/vim-jsx-pretty'   -- JS and JSX syntax
  use 'jparise/vim-graphql'        -- GraphQL syntax

  use 'itchyny/calendar.vim'

  -- use 'mhinz/vim-startify'

  use 'vimwiki/vimwiki'

  use 'tpope/vim-fugitive'
  use 'junegunn/gv.vim'

  use {
    'ldelossa/gh.nvim',
    requires = { { 'ldelossa/litee.nvim' }, { 'nvim-tree/nvim-web-devicons', opt = true } }
  }

  use { "ellisonleao/glow.nvim", config = function() require("glow").setup() end }

  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use "norcalli/nvim-colorizer.lua"

  use "junegunn/goyo.vim"
  use "junegunn/vim-easy-align"

  --	project 내에서 동일한 단어를 일괄 변경하기 위해서였는데, 실제로 잘 쓰지 않고 쓰더라도 오류가 나더라. %s/old/new 를 응용한 keymap으로 임시 대체한다.
  --	use {
  --		'nvim-pack/nvim-spectre',
  --		requires = { {'nvim-lua/plenary.nvim'} }
  --	}

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  --  use {
  --    'pwntester/octo.nvim',
  --    requires = {
  --      'nvim-lua/plenary.nvim',
  --      'nvim-telescope/telescope.nvim',
  --      'kyazdani42/nvim-web-devicons',
  --    },
  --    config = function ()
  --      require"octo".setup()
  --    end
  --  }

  use 'github/copilot.vim'
  --  use {
  --    "zbirenbaum/copilot.lua",
  --    cmd = "Copilot",
  --    event = "InsertEnter",
  --    config = function()
  --      require("copilot").setup({
  --        panel = {
  --          enabled = true,
  --          auto_refresh = false,
  --          keymap = {
  --            jump_prev = "[[",
  --            jump_next = "]]",
  --            accept = "<CR>",
  --            refresh = "gr",
  --            open = "<M-CR>"
  --          },
  --          layout = {
  --            position = "right", -- | top | left | right
  --            ratio = 0.2
  --          },
  --        },
  --        suggestion = {
  --          enabled = true,
  --          auto_trigger = true,
  --          debounce = 20,
  --          keymap = {
  --            accept = "<M-CR>",
  --            accept_word = "<M-k>",
  --            accept_line = "<M-l>",
  --            next = "<M-]>",
  --            prev = "<M-[>",
  --            dismiss = "<C-]>"
  --          },
  --        },
  --        filetypes = {
  --          yaml = false,
  --          markdown = true,
  --          help = false,
  --          gitcommit = true,
  --          gitrebase = false,
  --          hgcommit = false,
  --          svn = false,
  --          cvs = false,
  --          css = true,
  --          ["."] = false,
  --        },
  --        copilot_node_command = "node", -- Node.js version must be > 18.x
  --        server_opts_overrides = {},
  --      })
  --    end,
  --  }

  use {
    'akinsho/flutter-tools.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
    },
  }

  use 'sindrets/winshift.nvim'

  use({
    "jackMort/ChatGPT.nvim",
    requires = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  })
  --☇⚊✔⛖⛖☞✍✍✍✂✂✎✎▼▼▼⮯⮯♲♲
  use {
    'lewis6991/gitsigns.nvim',
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require('gitsigns').setup({
        -- signs = {
        --   add          = {
        --     hl = 'CustomSignsAdd',
        --     linehl = 'CustomSignsAddBg',
        --     text = '▍'
        --   },
        --   change       = {
        --     hl = 'CustomSignsChange',
        --     linehl = 'CustomSignsChangeBg',
        --     text = '▍'
        --   },
        --   delete       = {
        --     hl = 'CustomSignsDelete',
        --     text = '▼'
        --   },
        --   topdelete    = { text = '‾' },
        --   changedelete = { text = '~' },
        --   untracked    = { text = '┆' },
        -- },
        signs = {
          add          = {
            hl = 'CustomSignsAdd',
            linehl = 'CustomSignsAddBg',
            text = '+'
          },
          change       = {
            hl = 'CustomSignsChange',
            linehl = 'CustomSignsChangeBg',
            text = '~'
          },
          delete       = {
            hl = 'CustomSignsDelete',
            text = '_'
          },
          topdelete    = { text = '‾' },
          changedelete = { text = '~' },
          untracked    = { text = '┆' },
        },
        update_debounce = 30,
      })
    end
  }

  use { "akinsho/toggleterm.nvim", tag = '*', config = function()
    require("toggleterm").setup()
  end }

  use 'onsails/lspkind.nvim'

  --image renderer
  --dependencies
  --pacman -S imagemagick
  --pacman -S luarocks
  --luarocks --lua-version 5.1 install --local magick
  -- Example for configuring Neovim to load user-installed installed Lua rocks:
  package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?/init.lua;"
  package.path = package.path .. ";" .. vim.fn.expand("$HOME") .. "/.luarocks/share/lua/5.1/?.lua;"
  --pacman -S kitty
  use '3rd/image.nvim'

  use { 'antonk52/markdowny.nvim', config = function()
    require('markdowny').setup({ filetypes = { 'markdown' } })
  end }

  -- https://github.com/hedyhli/outline.nvim
  use { 'hedyhli/outline.nvim'
    -- , config = function()
    -- require("outline").setup({})
    -- end
  }

  -- https://github.com/numToStr/Comment.nvim?tab=readme-ov-file
  use { 'numToStr/Comment.nvim', config = function()
    require('Comment').setup()
  end }
  --use {'JoosepAlviste/nvim-ts-context-commentstring'}
  --block comment 달면 되는데 꼭 설치해야할까? 일단 미루자.

  -- https://github.com/ggandor/leap.nvim
  use { 'ggandor/leap.nvim' }
  -- require('leap').create_default_mappings()

  -- https://github.com/rmagatti/auto-session
  use {
    'rmagatti/auto-session',
    config = function()
      require("auto-session").setup {
        log_level = "error",
        auto_session_suppress_dirs = { "~/", "~/test", "~/Downloads", "/*" },
        session_lens = {
          -- If load_on_setup is set to false, one needs to eventually call `require("auto-session").setup_session_lens()` if they want to use session-lens.
          buftypes_to_ignore = {}, -- list of buffer types what should not be deleted from current session
          load_on_setup = true,
          theme_conf = { border = true },
          previewer = false,
        },
        auto_save_enabled = false
      }
    end
  }

  use {
    'rmagatti/session-lens',
    requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' },
    config = function()
      require('session-lens').setup({
        path_display = { 'shorten' },
      })
    end
  }
  -- 라이브러리 뒤져봤더니, floating 메뉴에서 세션 삭제하는 기본 키맵이 <C-d>다.

  use "lukas-reineke/indent-blankline.nvim"

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end)
