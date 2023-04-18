vim.g.mapleader = " " -- <leader> as Space

vim.keymap.set('n', ',q', ':nohlsearch<CR>', {silent = true}) -- 검색 기록 제거

vim.keymap.set({'n', 'x'}, ',p', '"0p') -- paste last thing yanked, not deleted

vim.keymap.set('n', '<leader><leader>q', ':q!<CR>') -- 
vim.keymap.set('n', '<leader><leader>tq', ':tabclose<CR>') -- 

vim.keymap.set('n', '<leader><leader>s', ':Startify<CR>') -- paste last thing yanked, not deleted
vim.keymap.set('n', '<leader><leader>d', ':NvimTreeFindFileToggle<CR>') -- paste last thing yanked, not deleted
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>f', builtin.find_files, {}) -- telescope
vim.keymap.set('n', '<leader><leader>c', ':Calendar<CR>')

vim.keymap.set('n', '<leader><leader>gh', ':GV<CR>') 
vim.keymap.set('n', '<leader><leader>ghf', ':GV!<CR>')  -- current file only

vim.keymap.set('n', '<leader><leader>GG', ':G<CR>') 
vim.keymap.set('n', '<leader><leader>Gre', ':GHOpenPR<CR>') 
vim.keymap.set('n', '<leader><leader>Gpr', ':GHOpenToPR<CR>') 
vim.keymap.set('n', '<leader><leader>Giss', ':GHOpenIssue<CR>') 

vim.keymap.set('x', 'al', '<Plug>(LiveEasyAlign)', {})
vim.keymap.set('x', 'tal', '<Plug>(EasyAlign)*||', {})

-- window to tab
vim.keymap.set('n', '<A-t>', '<C-w>T')

-- tap change
vim.keymap.set('n', '<A-p>', 'gt')
vim.keymap.set('n', '<A-o>', 'gT')

-- window controll
vim.keymap.set('n', '<A-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<A-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<A-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<A-l>', ':wincmd l<CR>')

vim.keymap.set('n', '<A-H>', ':wincmd H<CR>')
vim.keymap.set('n', '<A-J>', ':wincmd J<CR>')
vim.keymap.set('n', '<A-K>', ':wincmd K<CR>')
vim.keymap.set('n', '<A-L>', ':wincmd L<CR>')

vim.keymap.set('n', '<A-R>', ':resize ')
vim.keymap.set('n', '<A-r>', ':vertical resize ')
