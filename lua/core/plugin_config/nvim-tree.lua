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
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'r', api.tree.change_root_to_node, opts('CD'))
  vim.keymap.set('n', 'h', api.tree.change_root_to_parent, opts('Up'))
  vim.keymap.set('n', 'K', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', 'o', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', 'O', api.node.open.edit, opts('Open'))
  -- vim.keymap.set('n', 'l', open_in_new_vertical_split_focus_stay, {desc = 'Open in new vertical split'})
  -- vim.keymap.set('n', 'L', open_in_new_vertical_split, {desc = 'Open in new vertical split'})
  vim.keymap.set('n', 'N', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'X', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'C', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'P', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'R', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Filter: Git Ignore'))
  vim.keymap.set('n', 'm', api.marks.toggle, opts('Toggle Bookmark'))
  vim.keymap.set('n', 'M', api.tree.toggle_no_bookmark_filter, opts('Toggle Filter: No Bookmark'))
  vim.keymap.set('n', 'bD', api.marks.bulk.trash, opts('Trash Bookmarked'))
  vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', 'p', api.node.navigate.parent, opts('Parent Directory'))

  vim.keymap.set('n', 'ee', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', 'cc', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'yya', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', 'yyr', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'yyf', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', '<C-l>', api.tree.reload, opts('Refresh'))
end

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  filters = {
    dotfiles = true,
    custom = {
      -- "node_modules",
    },
  },
  renderer = {
    add_trailing = false,
    group_empty = false,
    highlight_git = false,
    full_name = false,
    highlight_opened_files = "none",
    highlight_modified = "none",
    icons = {
      webdev_colors = true,
      git_placement = "before",
      modified_placement = "after",
      padding = " ",
      symlink_arrow = "➛",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
        modified = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        bookmark = "✓",
        modified = "●",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          -- unstaged = "✗",
          -- staged = "✓",
          -- unmerged = "",
          -- renamed = "➜",
          -- untracked = "★",
          -- deleted = "",
          -- ignored = "◌",
          unstaged = ")",
          staged = ")",
          unmerged = ")",
          renamed = "➜)",
          untracked = ")",
          deleted = "󰛌)",
          ignored = ")",
        },
      },
    },
  },
  git = {
    enable = true,
    ignore = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
    timeout = 400,
  },
  update_focused_file = {
    enable = true,
    update_root = true,
    ignore_list = {},
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
    debounce_delay = 50,
    severity = {
      min = vim.diagnostic.severity.HINT,
      max = vim.diagnostic.severity.ERROR,
    },
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    },
  },
  on_attach = my_on_attach,
  auto_reload_on_write = true,
  modified = {
    enable = true,
    show_on_dirs = true,
    show_on_open_dirs = false,
  },
  actions = {
    change_dir = {
      enable = true,
      global = true,
      restrict_above_cwd = false,
    },
  }
})
