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

-- vim.opt.foldmethod = "manual"
--vim.opt.foldmethod = "expr"
vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 99

vim.o.sessionoptions = "blank,buffers,curdir,folds,help,tabpages,winsize,winpos,terminal"

vim.opt.foldmethod = "indent"
vim.opt.foldenable = false
vim.opt.formatoptions:remove('f') -- 코드 작성 시 폴드가 갑자기 접히는 문제가 있다면 formatoptions의 fold 플래그 때문일 수 있습니다. 이 플래그가 설정되어 있으면 포매팅 중에 폴드를 자동으로 다시 접을 수 있습니다.

vim.g.mapleader = "\\" -- <leader> as Space

-- Set fillchars
vim.o.fillchars = 'vert:┃'

vim.opt.splitright = true -- 수직 분할시 오른쪽에 창 생성
-- vim.opt.splitbelow = true -- 수평 분할시 아래쪽에 창 생성

vim.opt.undofile = true -- 종료시에도 undo 기록을 남김
