vim.g.mapleader = "\\" -- <leader> as Space
--
vim.keymap.set('n', ',q', ':nohlsearch<CR>', {silent = true}) -- 검색 기록 제거
vim.keymap.set('n', ',r', ':wincmd =<CR>', {silent = true}) -- 창 크기 동일하게

vim.keymap.set({'n', 'x'}, ',p', '"0p') -- paste last thing yanked, not deleted

-- vim.keymap.set('n', ',mv', ':mkview<CR>') -- make view
-- vim.keymap.set('n', ',lv', ':loadview<CR>') -- load view

vim.keymap.set('n', '<leader><leader>q', ':q!<CR>') -- 
vim.keymap.set('n', '<leader><leader>Q', ':qa!<CR>') -- 
vim.keymap.set('n', '<leader><leader>w', ':mkview<CR>:w<CR>') -- 
vim.keymap.set('n', '<leader><leader>W', ':mkview<CR>:wa<CR>') -- 
vim.keymap.set('n', '<leader><leader>e', ':mkview<CR>:wq<CR>') -- 
vim.keymap.set('n', '<leader><leader>tq', ':tabclose!<CR>') -- 

vim.keymap.set('n', ',,d', ':NvimTreeFindFileToggle<CR>') -- paste last thing yanked, not deleted
--vim.keymap.set("n", ",d", ":NvimTreeFocus<CR>") -- focus on nvim-tree right away
-- diffview 쪽이랑 통합했다. 조건부로 동작

local builtin = require('telescope.builtin')
vim.keymap.set('n', ',.f', builtin.find_files, {})
vim.keymap.set('n', ',.w', builtin.live_grep, {})
vim.keymap.set('n', ',.c', builtin.grep_string, {})
vim.keymap.set('n', ',.m', builtin.marks, {})
vim.keymap.set('n', ',.b', builtin.buffers, {})
vim.keymap.set('n', ',.s', builtin.git_stash, {})
vim.keymap.set('n', ',.g', builtin.git_status, {})
vim.keymap.set('n', ',.h', builtin.help_tags, {})

vim.keymap.set('n', '<leader><leader>C', ':Calendar<CR>')
-- vim.keymap.set('n', '<leader><leader>S', ':Startify<CR>') 

vim.keymap.set('n', ',vd', ':Gvdiffsplit<CR>') 
vim.keymap.set('n', '<leader>glg', ':GV --graph<CR>') 
vim.keymap.set('n', '<leader>glf', ':GV!<CR>')  -- current file only

vim.keymap.set('n', '<leader>gg', ':G<CR>') 
vim.keymap.set('n', '<leader>rer', ':DiffviewFileHistory --range=origin') 
vim.keymap.set('n', '<leader>rec', ':DiffviewFileHistory --range=origin/main...HEAD<CR>') 
vim.keymap.set('n', '<leader>rea', ':DiffviewFileHistory<CR>') 
vim.keymap.set('n', '<leader>ref', ':DiffviewFileHistory %<CR>') 
vim.keymap.set('n', '<leader>res', ':DiffviewOpen --staged<CR>') 



vim.keymap.set('x', 'al', '<Plug>(LiveEasyAlign)', {})
vim.keymap.set('x', 'tal', '<Plug>(EasyAlign)*||', {})

--vim.keymap.set('n', '<leader><leader>sp', '<cmd>lua require("spectre").open_visual({select_word=true})<CR>', {
--    desc = "Search current word"
--})
--vim.keymap.set('v', '<leader><leader>sp', '<esc><cmd>lua require("spectre").open_visual()<CR>', {
--    desc = "Search current visual block"
--})
--vim.keymap.set('n', '<leader><leader>spf', '<cmd>lua require("spectre").open_file_search({select_word=true})<CR>', {
--    desc = "Search on current file"
--})

-- window to tab
vim.keymap.set('n', ',mt', '<C-w>T')
vim.keymap.set('n', ',st', ':sp<CR><C-w>T')

-- tap change
vim.keymap.set('n', '<A-p>', 'gt')
vim.keymap.set('n', '<A-o>', 'gT')
--vim.keymap.set('n', '<Tab>', 'gt')
--vim.keymap.set('n', '<S-Tab>', 'gT')

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
vim.keymap.set("n", ",C", [[:%s/<C-r><C-w>//g<Left><Left>]])

-- get docs of K as independently
vim.keymap.set("n", "<Leader><Leader>K", ':sp<CR>:wincmd L<CR><CMD>lua _G.show_docs()<CR>:sleep 20ms<CR>:wincmd w<CR>:sp<CR>:wincmd j<CR>:q<CR>')

-- splitting easily
vim.keymap.set("n", ",ss", ":sp<CR>:wincmd w<CR><Plug>(coc-definition)")
vim.keymap.set("n", ",sv", ":vs<CR>:wincmd w<CR><Plug>(coc-definition)")

-- gitsigns shortcuts
-- vim.keymap.set("n", ",s", ":Gitsigns toggle_linehl<CR>:Gitsigns toggle_deleted<CR>")
vim.keymap.set("n", "<leader><leader>d", ":Gitsigns toggle_deleted<CR>")

-- easy visual block for word
vim.keymap.set("n", "vv", "viw")


function DiffviewFilePanelFocusConditional()
  local buffers = vim.api.nvim_list_bufs()
  local diffviewOpen = false

  for _, buf in ipairs(buffers) do
    local ft = vim.api.nvim_buf_get_option(buf, 'filetype')
    if ft == 'DiffviewFiles' then
      diffviewOpen = true
      break
    end
  end

  if diffviewOpen then
    vim.cmd('DiffviewFocusFiles')
  else
    -- Diffview가 열려 있지 않을 경우, NvimTreeFocus 명령을 실행합니다.
    vim.cmd('NvimTreeFocus')
  end
end

-- 기존의 NvimTree로 이동하는 키 매핑을 대체합니다.
vim.keymap.set("n", ",d", DiffviewFilePanelFocusConditional, {silent = true, noremap = true})


vim.keymap.set({'n', 'x'}, ',,o', ":Outline<CR>")
vim.keymap.set({'n', 'x'}, ',o', ":OutlineFocusOutline<CR>")

vim.keymap.set("n", ",.S", require("auto-session.session-lens").search_session, {
  noremap = true,
})

vim.keymap.set({'n', 'x', 'o'}, ',l',  '<Plug>(leap-forward)')
vim.keymap.set({'n', 'x', 'o'}, ',L',  '<Plug>(leap-backward)')
vim.keymap.set({'n', 'x', 'o'}, ',gl', '<Plug>(leap-from-window)')

vim.keymap.set("n", "<leader><leader>s", ":SessionSave<CR>")

vim.keymap.set({'n', 'x', 'o'}, 'zo', 'za')
