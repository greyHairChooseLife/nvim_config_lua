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

  use 'vimwiki/vimwiki'

  use 'tpope/vim-fugitive'
  use 'tpope/vim-surround'        -- check advanced usage https://www.youtube.com/watch?v=96FS45IaUgo
  use 'greyhairchooselife/gv.vim' -- 일부 개선을 위해 'junegunn/gv.vim' folk 해옴

  use {
    'ldelossa/gh.nvim',
    requires = { { 'ldelossa/litee.nvim' }, { 'nvim-tree/nvim-web-devicons', opt = true } }
  }

  use({
    "iamcco/markdown-preview.nvim",
    run = function() vim.fn["mkdp#util#install"]() end,
  })

  use "norcalli/nvim-colorizer.lua"

  use "junegunn/goyo.vim"
  use "junegunn/vim-easy-align"

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use 'github/copilot.vim'

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

  use { 'lewis6991/gitsigns.nvim', }

  use { "akinsho/toggleterm.nvim" }

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

  use {
    "folke/todo-comments.nvim",
    requires = "nvim-lua/plenary.nvim",
  }

  use { 'nvim-telescope/telescope-hop.nvim' }
  use { 'fannheyward/telescope-coc.nvim' }
  use { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' }
  -- use 'rcarriga/nvim-notify'


  use { "tpope/vim-dadbod" }
  use { "kristijanhusak/vim-dadbod-ui" }
  use { "kristijanhusak/vim-dadbod-completion" }

  use { "goolord/alpha-nvim" }

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  use { 'ryanoasis/vim-devicons' }
  use { 'MeanderingProgrammer/markdown.nvim' } -- for config, https://github.com/MeanderingProgrammer/markdown.nvim?tab=readme-ov-file#setup
  -- use { 'OXY2DEV/markview.nvim' }

  -- TODO:  http client inside neovim
  -- https://github.com/rest-nvim/rest.nvim
  -- https://www.reddit.com/r/neovim/comments/1eh0yr6/restnvim_is_back/
  if packer_bootstrap then
    require('packer').sync()
  end
end)
