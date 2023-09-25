vim.g.mapleader = " " -- <leader> as Space

vim.keymap.set('n', ',q', ':nohlsearch<CR>', {silent = true}) -- 검색 기록 제거

vim.keymap.set({'n', 'x'}, ',p', '"0p') -- paste last thing yanked, not deleted

vim.keymap.set('n', ',mv', ':mkview<CR>') -- make view
vim.keymap.set('n', ',lv', ':loadview<CR>') -- load view

vim.keymap.set('n', '<leader><leader>q', ':q!<CR>') -- 
vim.keymap.set('n', '<leader><leader>Q', ':qa!<CR>') -- 
vim.keymap.set('n', '<leader><leader>tq', ':tabclose!<CR>') -- 

vim.keymap.set('n', '<leader><leader>d', ':NvimTreeFindFileToggle<CR>') -- paste last thing yanked, not deleted
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader><leader>f', builtin.find_files, {}) -- telescope
vim.keymap.set('n', '<leader><leader>C', ':Calendar<CR>')
vim.keymap.set('n', '<leader><leader>S', ':Startify<CR>') 

vim.keymap.set('n', '<leader><leader>GG', ':G<CR>') 
vim.keymap.set('n', '<leader><leader>vd', ':Gvdiffsplit<CR>') 
vim.keymap.set('n', '<leader><leader>Gh', ':GV<CR>') 
vim.keymap.set('n', '<leader><leader>Ghf', ':GV!<CR>')  -- current file only

vim.keymap.set('n', '<leader><leader>rea', ':DiffviewOpen origin/main...HEAD --imply-local<CR>') 
vim.keymap.set('n', '<leader><leader>reh', ':DiffviewFileHistory --range=origin/main...HEAD<CR>') 
vim.keymap.set('n', '<leader><leader>ref', ':DiffviewFileHistory %<CR>') 



vim.keymap.set('x', 'al', '<Plug>(LiveEasyAlign)', {})
vim.keymap.set('x', 'tal', '<Plug>(EasyAlign)*||', {})

vim.keymap.set('n', '<leader><leader>sp', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
    desc = "Search current word"
})
vim.keymap.set('v', '<leader><leader>sp', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
    desc = "Search current visual block"
})
vim.keymap.set('n', '<leader><leader>spf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
    desc = "Search on current file"
})

-- window to tab
vim.keymap.set('n', '<leader><leader>tt', '<C-w>T')

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

vim.keymap.set("n", "<A-Left>", ":vertical resize -2<CR>", {})
vim.keymap.set("n", "<A-Right>", ":vertical resize +2<CR>", {})
vim.keymap.set("n", "<A-Down>", ":horizontal resize -2<CR>", {})
vim.keymap.set("n", "<A-Up>", ":horizontal resize +2<CR>", {})

vim.keymap.set("n", "<A-S-Left>", ":vertical resize -8<CR>", {})
vim.keymap.set("n", "<A-S-Right>", ":vertical resize +8<CR>", {})
vim.keymap.set("n", "<A-S-Down>", ":horizontal resize -8<CR>", {})
vim.keymap.set("n", "<A-S-Up>", ":horizontal resize +8<CR>", {})

vim.keymap.set('n', '<A-n>h', ':rightbelow new<CR>')
vim.keymap.set('n', '<A-n>v', ':vert rightbelow new<CR>')
vim.keymap.set('n', '<A-t>', ':tabnew<CR>')

vim.keymap.set('n', '<leader><leader>o', ':lua vim.lsp.buf.code_action()<CR>')

-- flutter-tools: toggle widget outline 
vim.keymap.set('n', '<leader><leader>Fo', ':FlutterOutlineToggle<CR>')

-- change word under cursor globally
vim.keymap.set("n", "<Leader>C", [[:%s/<C-r><C-w>//g<Left><Left>]])
