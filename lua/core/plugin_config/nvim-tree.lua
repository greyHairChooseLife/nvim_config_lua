-- disable netrw at the very start of your init.lua (strongly advised)
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups vim.opt.termguicolors = true

local function my_on_attach(bufnr)
  local api = require('nvim-tree.api')
  local function opts(desc)
    return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
  end

  -- put some default mappings here
  -- user mappings
  vim.keymap.set('n', 'g?', api.tree.toggle_help, opts('Help'))
  vim.keymap.set('n', '.', api.tree.toggle_hidden_filter, opts('Toggle Dotfiles'))
  vim.keymap.set('n', 'r', function()
    api.tree.change_root_to_node()
    api.tree.toggle() -- lualine 표시를 위해
    api.tree.toggle()
  end, opts('CD'))
  vim.keymap.set('n', 'h', function()
    local line = vim.fn.line('.')
    local node = api.tree.get_node_under_cursor()

    if line == 1 then -- 최상위 디렉토리 노드
      api.tree.change_root_to_parent()
      api.tree.toggle() -- lualine 표시를 위해, reload는 branch 표시가 부족하다.
      api.tree.toggle()
    elseif node.type == 'directory' and node.open then
      api.node.open.preview() -- 그냥 닫기만 해
    else -- 닫힌 디렉퇼 또는 파일이면
      api.node.navigate.parent() -- 부모 디엑토리로 이동만
    end
  end, opts('Up'))
  vim.keymap.set('n', 'K', api.node.show_info_popup, opts('Info'))
  vim.keymap.set('n', 'o', api.node.open.preview, opts('Open Preview'))
  vim.keymap.set('n', 'O', api.node.open.edit, opts('Open'))
  vim.keymap.set('n', 'T', api.node.open.tab, opts('Open in New Tab' ))
  vim.keymap.set('n', 'l', function()
      local node = api.tree.get_node_under_cursor()
      if node.type == 'directory' then
        if not node.open then -- is_dir_expanded?
          -- from help doc
          -- node.open.edit({node})                        *nvim-tree-api.node.open.edit()*
          --     File:   open as per |nvim-tree.actions.open_file|
          --     Folder: expand or collapse
          --     Root:   change directory up
          api.node.open.edit()
        end
        vim.cmd('normal j')
      else
        vim.cmd('vert rightbelow new')
        vim.cmd('edit ' .. node.absolute_path)
        vim.cmd('NvimTreeToggle')
        vim.cmd('NvimTreeToggle')
        vim.cmd('NvimTreeFocus')
      end
    end,
    opts('action l')
  )
  vim.keymap.set('n', 'L', function()
      local node = api.tree.get_node_under_cursor()
      if node.type == 'directory' then
        if not node.open then
          api.node.open.edit()
        end
        vim.cmd('normal j')
      else
        vim.cmd('vert rightbelow new')
        vim.cmd('edit ' .. node.absolute_path)
        vim.cmd('NvimTreeToggle')
        vim.cmd('NvimTreeToggle')
        vim.cmd('wincmd w')
      end
    end,
    opts('action L')
  )
  vim.keymap.set('n', 'N', api.fs.create, opts('Create'))
  vim.keymap.set('n', 'D', api.fs.trash, opts('Trash'))
  vim.keymap.set('n', 'X', api.fs.cut, opts('Cut'))
  vim.keymap.set('n', 'C', api.fs.copy.node, opts('Copy'))
  vim.keymap.set('n', 'P', api.fs.paste, opts('Paste'))
  vim.keymap.set('n', 'R', api.fs.rename, opts('Rename'))
  vim.keymap.set('n', 'I', api.tree.toggle_gitignore_filter, opts('Toggle Filter: Git Ignore'))
  vim.keymap.set('n', '<Tab>', api.marks.toggle, opts('Toggle Bookmark'))
  vim.keymap.set('n', 'M', api.tree.toggle_no_bookmark_filter, opts('Toggle Filter: No Bookmark'))
  vim.keymap.set('n', 'bD', api.marks.bulk.trash, opts('Trash Bookmarked'))
  vim.keymap.set('n', 'bmv', api.marks.bulk.move, opts('Move Bookmarked'))
  vim.keymap.set('n', '<BS>', api.node.navigate.parent_close, opts('Close Directory'))
  vim.keymap.set('n', 'p', api.node.navigate.parent, opts('Parent Directory'))

  vim.keymap.set('n', 'gp', api.node.navigate.git.prev_recursive, opts('git prev'))
  vim.keymap.set('n', 'gn', api.node.navigate.git.next_recursive, opts('git next'))
  vim.keymap.set('n', 'bp', api.node.navigate.opened.prev, opts('active buffer prev'))
  vim.keymap.set('n', 'bn', api.node.navigate.opened.next, opts('active buffer next'))

  vim.keymap.set('n', 'zr', api.tree.expand_all, opts('Expand All'))
  vim.keymap.set('n', 'zm', api.tree.collapse_all, opts('Collapse'))
  vim.keymap.set('n', 'ya', api.fs.copy.absolute_path, opts('Copy Absolute Path'))
  vim.keymap.set('n', 'yr', api.fs.copy.relative_path, opts('Copy Relative Path'))
  vim.keymap.set('n', 'yf', api.fs.copy.filename, opts('Copy Name'))
  vim.keymap.set('n', ',r', function()
    require('nvim-tree.api').tree.toggle({ find_files = true, focus = false })
    require('nvim-tree.api').tree.toggle({ find_files = true, focus = false })
    vim.cmd('AerialToggle')
    vim.cmd('AerialToggle')
    require('quicker').refresh()
    vim.cmd('wincmd = | echon | wincmd h');
  end, opts('Refresh'))
end

-- OR setup with some options
require("nvim-tree").setup({
  sort_by = "case_sensitive",
  view = { width = 40 },
  -- sync_root_with_cwd = true,
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
    highlight_opened_files = "name", -- active buffer 표시
    highlight_modified = "none",
    indent_width = 3,
    indent_markers = {
      enable = true,
      inline_arrows = true,
      icons = {
        corner = "└",
        edge = "│",
        item = "│",
        bottom = "─",
        none = " ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "after",
      modified_placement = "before",
      padding = " ",
      symlink_arrow = "➛",
      show = {
        file = true,
        folder = true,
        folder_arrow = false,
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
          empty_open = "", -- 
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
    update_root = false,
    ignore_list = {},
  },
  diagnostics = {
    enable = false, -- 오랫동안 봐 왔지만 실용적인 적이 딱히 없는듯?
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
