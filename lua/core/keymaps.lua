vim.g.mapleader = " " -- <leader> as Space

vim.keymap.set('n', ',q', ':nohlsearch<CR>', {silent = true}) -- 검색 기록 제거
vim.keymap.set('n', ',r', ':wincmd =<CR>', {silent = true}) -- 창 크기 동일하게

vim.keymap.set({'n', 'x'}, ',p', '"0p') -- paste last thing yanked, not deleted

vim.keymap.set('n', ',mv', ':mkview<CR>') -- make view
vim.keymap.set('n', ',lv', ':loadview<CR>') -- load view

vim.keymap.set('n', '<leader><leader>q', ':q!<CR>') -- 
vim.keymap.set('n', '<leader><leader>Q', ':qa!<CR>') -- 
vim.keymap.set('n', '<leader><leader>tq', ':tabclose!<CR>') -- 

vim.keymap.set('n', '<leader><leader>d', ':NvimTreeFindFileToggle<CR>') -- paste last thing yanked, not deleted
local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

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
vim.keymap.set('n', '<leader><leader>mt', '<C-w>T')
vim.keymap.set('n', '<leader><leader>st', ':sp<CR><C-w>T')

-- tap change
vim.keymap.set('n', '<A-p>', 'gt')
vim.keymap.set('n', '<A-o>', 'gT')

-- window controll
vim.keymap.set('n', '<A-h>', ':wincmd h<CR>')
vim.keymap.set('n', '<A-j>', ':wincmd j<CR>')
vim.keymap.set('n', '<A-k>', ':wincmd k<CR>')
vim.keymap.set('n', '<A-l>', ':wincmd l<CR>')

--vim.keymap.set('n', '<A-H>', ':wincmd H<CR>')
--vim.keymap.set('n', '<A-J>', ':wincmd J<CR>')
--vim.keymap.set('n', '<A-K>', ':wincmd K<CR>')
--vim.keymap.set('n', '<A-L>', ':wincmd L<CR>')

vim.keymap.set('n', '<A-H>', '<Cmd>WinShift left<CR>')
vim.keymap.set('n', '<A-J>', '<Cmd>WinShift down<CR>')
vim.keymap.set('n', '<A-K>', '<Cmd>WinShift up<CR>')
vim.keymap.set('n', '<A-L>', '<Cmd>WinShift right<CR>')

vim.keymap.set('n', '<A-R>h', ':resize ')
vim.keymap.set('n', '<A-R>v', ':vertical resize ')

vim.keymap.set("n", "<A-Left>", ":vertical resize -2<CR>", {})
vim.keymap.set("n", "<A-Right>", ":vertical resize +2<CR>", {})
vim.keymap.set("n", "<A-Down>", ":horizontal resize -2<CR>", {})
vim.keymap.set("n", "<A-Up>", ":horizontal resize +2<CR>", {})

vim.keymap.set("n", "<A-S-Left>", ":vertical resize -8<CR>", {})
vim.keymap.set("n", "<A-S-Right>", ":vertical resize +8<CR>", {})
vim.keymap.set("n", "<A-S-Down>", ":horizontal resize -8<CR>", {})
vim.keymap.set("n", "<A-S-Up>", ":horizontal resize +8<CR>", {})

vim.keymap.set('n', '<A-n>x', ':rightbelow new<CR>')
vim.keymap.set('n', '<A-n>v', ':vert rightbelow new<CR>')
vim.keymap.set('n', '<A-n>t', ':tabnew<CR>')

vim.keymap.set('n', '<leader><leader>o', ':lua vim.lsp.buf.code_action()<CR>')

-- flutter-tools: toggle widget outline 
vim.keymap.set('n', '<leader><leader>Fo', ':FlutterOutlineToggle<CR>')

-- change word under cursor globally
vim.keymap.set("n", "<Leader>C", [[:%s/<C-r><C-w>//g<Left><Left>]])

-- get docs of K as independently
vim.keymap.set("n", "<Leader><Leader>K", ':sp<CR>:wincmd L<CR><CMD>lua _G.show_docs()<CR>:sleep 20ms<CR>:wincmd w<CR>:sp<CR>:wincmd j<CR>:q<CR>')
