local ensure_packer = function()
	local fn = vim.fn
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
	-- use 'Mofiqul/dracula.nvim'
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
  -- manually: CocInstall coc-tsserver, coc-pairs, coc-css, coc-html, coc-json, coc-prettier, coc-word

	use 'pangloss/vim-javascript'    -- JavaScript support
	use 'leafgarland/typescript-vim' -- TypeScript syntax 
	use 'maxmellon/vim-jsx-pretty'   -- JS and JSX syntax 
	--use 'jparise/vim-graphql'      -- GraphQL syntax 

--	-- filer
--	Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
  use 'itchyny/calendar.vim'

	use 'mhinz/vim-startify'

	use 'vimwiki/vimwiki'

  use 'tpope/vim-fugitive'
	use 'junegunn/gv.vim'

  use {
    'ldelossa/gh.nvim',
    requires = { { 'ldelossa/litee.nvim' } }
  }

  use {"ellisonleao/glow.nvim", config = function() require("glow").setup() end}

  use "norcalli/nvim-colorizer.lua"

  use "junegunn/goyo.vim"
  use "junegunn/vim-easy-align"

	-- Automatically set up your configuration after cloning packer.nvim   
	-- Put this at the end after all plugins 
	if packer_bootstrap then     
		require('packer').sync()   
	end 
end)
