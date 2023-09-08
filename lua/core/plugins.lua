local ensure_packer = function() local fn = vim.fn
	local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'   
	if fn.empty(fn.glob(install_path)) > 0 then     
		fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})     
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
		tag = '0.1.0',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
  use 'nvim-telescope/telescope-ui-select.nvim'

  use { 'neoclide/coc.nvim', branch='release' }
  -- manually: CocInstall coc-tsserver, coc-pairs, coc-css, coc-html, coc-json, coc-prettier, coc-word, coc-graphql

	use 'pangloss/vim-javascript'    -- JavaScript support
	use 'leafgarland/typescript-vim' -- TypeScript syntax 
	use 'maxmellon/vim-jsx-pretty'   -- JS and JSX syntax 
	use 'jparise/vim-graphql'      -- GraphQL syntax 

  use 'itchyny/calendar.vim'

	use 'mhinz/vim-startify'

	use 'vimwiki/vimwiki'

  use 'tpope/vim-fugitive'
	use 'junegunn/gv.vim'

  use {
    'ldelossa/gh.nvim',
    requires = { { 'ldelossa/litee.nvim' }, { 'nvim-tree/nvim-web-devicons', opt = true } }
  }

  use {"ellisonleao/glow.nvim", config = function() require("glow").setup() end}

  use({
      "iamcco/markdown-preview.nvim",
      run = function() vim.fn["mkdp#util#install"]() end,
  })

  use "norcalli/nvim-colorizer.lua"

  use "junegunn/goyo.vim"
  use "junegunn/vim-easy-align"

	use { 
		'nvim-pack/nvim-spectre', 
		requires = { {'nvim-lua/plenary.nvim'} }
	}

  use { 'sindrets/diffview.nvim', requires = 'nvim-lua/plenary.nvim' }

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }

  use {
    'pwntester/octo.nvim',
    requires = {
      'nvim-lua/plenary.nvim',
      'nvim-telescope/telescope.nvim',
      'kyazdani42/nvim-web-devicons',
    },
    config = function ()
      require"octo".setup()
    end
  }

  use 'github/copilot.vim'

  use {
      'akinsho/flutter-tools.nvim',
      requires = {
          'nvim-lua/plenary.nvim',
      },
  }

	-- Automatically set up your configuration after cloning packer.nvim   
	-- Put this at the end after all plugins 
	if packer_bootstrap then     
		require('packer').sync()   
	end 
end)
