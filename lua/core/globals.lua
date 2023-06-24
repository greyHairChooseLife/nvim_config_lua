vim.opt.clipboard = "unnamedplus"
vim.opt.number = true;
vim.opt.relativenumber = true;

vim.opt.expandtab = true;
vim.opt.autoindent = true;
vim.opt.swapfile = false;

vim.opt.tabstop = 2;
vim.opt.shiftwidth = 2;

--vim.opt.foldmethod = "manual"
vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 9

-- Set the line number color
vim.cmd("highlight LineNr guifg=grey ctermfg=red")
