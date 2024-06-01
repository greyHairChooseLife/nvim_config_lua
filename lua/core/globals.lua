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
--vim.opt.foldlevel = 9

-- Set the line number color
vim.cmd("highlight LineNr guifg=#9ece6a ctermfg=red")
vim.cmd("highlight TabLine gui=bold guibg=black")
vim.cmd("highlight TabLineFill guibg=#24283b")
vim.cmd("highlight TabLineSel guibg=#98c379")
vim.cmd("highlight TabLine guifg=lightgrey")
vim.cmd("highlight Search guibg=#9ece6a guifg=#1d202f")
vim.cmd("highlight CurSearch gui=bold guibg=#1d3c9c guifg=white")
vim.cmd("highlight Visual guibg=#283b4d")

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
