local opt = vim.opt
local g = vim.g
local diag = vim.diagnostic

-- General editor settings
opt.clipboard = "unnamedplus"
opt.mouse = ""
opt.undofile = true -- Maintain undo history between sessions
opt.swapfile = false

-- UI settings
opt.number = true
opt.relativenumber = true
opt.fillchars = 'vert:┃'
opt.splitright = true -- Open vertical splits to the right

-- Indentation settings
opt.expandtab = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2

-- Folding settings
opt.foldexpr = "nvim_treesitter#foldexpr()"
opt.foldlevel = 99
opt.foldmethod = "indent"
opt.foldenable = false
opt.formatoptions:remove('f') -- Prevent auto-folding during formatting

-- Session settings
opt.sessionoptions="globals,blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal,localoptions"

-- Global variables
g.mapleader = "\\" -- Set leader key

-- Diagnostic settings
diag.config({
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
})

vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
