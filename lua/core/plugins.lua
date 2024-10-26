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
  use "nvim-lua/plenary.nvim"
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
  -- NOTE: 
  -- reddit에 보면 아래 대체품이 커스터마이징이 더 쉽고 자유롭다고 한다.
  -- https://github.com/Robitx/gp.nvim/

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

  use {
    'antonk52/markdowny.nvim',
    commit = '9881051', -- 내 나름대로 수정한 버전으로 고정해서 사용. 이후에 딱히 변경도 없다.
    config = function()
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

  use { 'stevearc/quicker.nvim' }   -- https://github.com/stevearc/quicker.nvim
  use { 'pteroctopus/faster.nvim' } -- handle big big files

  use {
    "ryanmsnyder/toggleterm-manager.nvim",
    requires = {
      "akinsho/nvim-toggleterm.lua",
      "nvim-telescope/telescope.nvim",
      "nvim-lua/plenary.nvim", -- only needed because it's a dependency of telescope
    },
    -- config = true, fixed with https://github.com/wbthomason/packer.nvim/issues/908#issuecomment-1133901800
  }

  use({ "stevearc/oil.nvim" })

  -- https://github.com/yetone/avante.nvim/issues/581#issuecomment-2394807552 packer 전용 플러그인 정의
  -- https://github.com/yetone/avante.nvim/issues/612#issuecomment-2375729928 설치 후 build 방법
  -- https://github.com/yetone/avante.nvim/issues/612#issuecomment-2401169692 cnofig에 앞서 avante_lib을 불러와야한다.
  use {
    "yetone/avante.nvim",
    build = "make BUILD_FROM_SOURCE=true",
    lazy = false,
    version = false,
    BUILD_FROM_SOURCE = true,
    config = function()
      require("avante_lib").load()
      require("avante").setup()
    end,
    requires = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      --- The below dependencies are optional,
      "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
      "HakonHarnes/img-clip.nvim",
    },
  }

  use {
      "ThePrimeagen/harpoon",
      branch = "harpoon2",
      commit = "e76cb03",   -- primegin 이양반 버그가 있는데 개선을 안한다. https://github.com/ThePrimeagen/harpoon/issues/577#issuecomment-2275638768
      requires = { {"nvim-lua/plenary.nvim"} }
  }

  use {
    'letieu/harpoon-lualine',
    opt = false,
    requires = {{'ThePrimeagen/harpoon'}}
  }

  -- use 'folke/trouble.nvim' -- coc.nvim은 쓰기 어렵고, 내장 lsp 매니저(?)로 전환할 때 활용하자

  -- NOTE: 너무 초기라 시기상조다. 일단은 q:를 활용하자.
  -- use { "smilhey/ed-cmd.nvim" }

  -- TODO:  http client inside neovim
  -- https://github.com/rest-nvim/rest.nvim
  -- https://www.reddit.com/r/neovim/comments/1eh0yr6/restnvim_is_back/
  -- OR alternative: https://github.com/mistweaverco/kulala.nvim
  --
  -- TODO:  indent or chunk marker(visualizer)
  -- https://github.com/shellRaining/hlchunk.nvim
  --
  -- TODO: chat with copilot
  -- https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file

  if packer_bootstrap then
    require('packer').sync()
  end
end)
