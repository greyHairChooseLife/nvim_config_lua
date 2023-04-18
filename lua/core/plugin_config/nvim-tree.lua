-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end
  -- put some default mappings here
  -- user mappings
  vim.keymap.set('n', 'g?',    api.tree.toggle_help,                  opts('Help'))
  vim.keymap.set('n', '.',     api.tree.toggle_hidden_filter,         opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'l', api.tree.change_root_to_node,              opts('CD'))
  vim.keymap.set('n', 'h',     api.tree.change_root_to_parent,        opts('Up'))
  vim.keymap.set('n', 'K', api.node.show_info_popup,                  opts('Info'))
  vim.keymap.set('n', 'o', api.node.open.preview,                     opts('Open Preview'))
  vim.keymap.set('n', 'O',     api.node.open.edit,                    opts('Open'))
  vim.keymap.set('n', 'N',     api.fs.create,                         opts('Create'))
  vim.keymap.set('n', 'D',     api.fs.trash,                          opts('Trash'))
  vim.keymap.set('n', 'X',     api.fs.cut,                            opts('Cut'))
  vim.keymap.set('n', 'C',     api.fs.copy.node,                      opts('Copy'))
  vim.keymap.set('n', 'P',     api.fs.paste,                          opts('Paste'))
  vim.keymap.set('n', 'R',     api.fs.rename,                         opts('Rename'))

  vim.keymap.set('n', 'ee',     api.tree.expand_all,                   opts('Expand All'))
  vim.keymap.set('n', 'cc',     api.tree.collapse_all,                opts('Collapse'))
  vim.keymap.set('n', 'yy',     api.fs.copy.relative_path,            opts('Copy Relative Path'))
  vim.keymap.set('n', 'ayy',    api.fs.copy.absolute_path,            opts('Copy Absolute Path'))
  vim.keymap.set('n', 'nyy',     api.fs.copy.filename,                opts('Copy Name'))
  vim.keymap.set('n', '<C-l>',     api.tree.reload,                   opts('Refresh'))
end


-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
  --auto_close = true,
  on_attach = my_on_attach
  --remove_keymaps = true
})
