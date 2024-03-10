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

vim.cmd([[:highlight CustomSignsAdd guifg=#1abc9c]])
vim.cmd([[:highlight CustomSignsAddBg guibg=#afccc7]])
vim.cmd([[:highlight CustomSignsChange guifg=#ff007c]])
vim.cmd([[:highlight CustomSignsChangeBg guibg=#e0af68]])
vim.cmd([[:highlight CustomSignsDelete guifg=#e06c75]])    
vim.cmd([[:highlight CustomSignsDeleteBg guibg=#e06c75]])    


return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'  
	use 'nvim-tree/nvim-tree.lua'
	use { 
		'nvim-telescope/telescope.nvim', 
		tag = '0.1.5',
		requires = { {'nvim-lua/plenary.nvim'} }
	}
  use 'nvim-telescope/telescope-ui-select.nvim'

  use 'tpope/vim-fugitive'
	use 'junegunn/gv.vim'

  use {
    'nvim-lualine/lualine.nvim',
    requires = { 'nvim-tree/nvim-web-devicons', opt = true }
  }
  use 'sindrets/winshift.nvim'

	-- Automatically set up your configuration after cloning packer.nvim   
	-- Put this at the end after all plugins 
	if packer_bootstrap then     
		require('packer').sync()   
	end 
end)
