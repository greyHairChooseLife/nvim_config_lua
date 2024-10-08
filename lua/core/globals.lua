vim.opt.clipboard = "unnamedplus"
vim.opt.number = true;
vim.opt.relativenumber = true;

vim.opt.expandtab = true;
vim.opt.autoindent = true;
vim.opt.swapfile = false;

vim.opt.tabstop = 2;
vim.opt.shiftwidth = 2;

vim.diagnostic.config({
  underline = true,
  virtual_text = false,
  signs = true,
  update_in_insert = false,
})

vim.opt.foldmethod = "manual"
--vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
-- vim.opt.foldlevel = 99

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

vim.opt.foldmethod = "indent"
vim.opt.foldenable = false

vim.g.mapleader = "\\" -- <leader> as Space

-- Set fillchars
vim.o.fillchars = 'vert:┃'

vim.opt.splitright = true -- 수직 분할시 오른쪽에 창 생성
