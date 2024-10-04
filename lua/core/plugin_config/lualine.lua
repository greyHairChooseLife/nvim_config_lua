local colors = {
  blue = '#61afef',
  green = '#2F8132',
  greenbg = '#98c379',
  purple = '#c678dd',
  red = '#a43838',
  yellow = '#FF8C00',
  wwhite = '#abb2bf',
  white = '#ffffff',
  bblack = '#282c34',
  black = '#000000',
  grey = '#333342',
  bg = '#24283b',
  active_qf = '#db4b4b',
  nvimTree = '#333342',
  active_oil = '#BDB80B',
}

local my_theme = {
  normal = {
    a = { fg = colors.yellow, bg = colors.yellow },
    b = { fg = colors.yellow, bg = colors.bg },
    c = { fg = colors.black, bg = colors.greenbg },
    x = { fg = colors.white, bg = colors.black },
    y = { fg = colors.black, bg = colors.yellow },
    z = { fg = colors.black, bg = colors.yellow },
  },
  inactive = {
    a = { fg = colors.yellow, bg = colors.bg },
    b = { fg = colors.yellow, bg = colors.bg },
    c = { fg = colors.grey, bg = colors.grey },
    x = { fg = colors.grey, bg = colors.grey },
    y = { fg = colors.grey, bg = colors.grey },
    z = { fg = colors.yellow, bg = colors.grey },
  },
}

local function empty()
  return ' '
end

local my_quickfix = {
  filetypes = {'qf'},
  sections = {
    lualine_a = {
      {
        'filetype',
        color = { bg = colors.active_qf, fg = colors.white, gui = 'bold,italic' },
        padding = { left = 3, right = 5 },
      },
    },
  },
  inactive_sections = {
    lualine_a = {
      {
        'filetype',
        color = { bg = colors.active_qf, fg = colors.white, gui = 'bold,italic' },
        padding = { left = 3, right = 5 },
        separator = { right = '' },
      },
    },
    lualine_b = { { empty, color = { bg = colors.grey } } },
  },
}

local my_nvimTree = {
  filetypes = {'NvimTree'},
  sections = {
    lualine_a = {
      {
        'branch',
        color = { bg = colors.nvimTree, fg = colors.yellow, gui = 'bold,italic' },
        padding = { left = 3 },
      },
    },
  },
  inactive_sections = {
    lualine_a = {
      {
        'branch',
        color = { bg = colors.nvimTree, fg = colors.yellow, gui = 'bold,italic' },
        padding = { left = 3 },
      },
    },
  },
}

local my_oil = {
  filetypes = {'oil'},
  sections = {
    lualine_a = {
      {
        'filetype',
        color = { bg = colors.active_oil, fg = colors.bblack, gui='bold,italic' },
        padding = { left = 3, right = 5 },
      },
    },
  },
  inactive_sections = {
    lualine_a = {
      {
        'filetype',
        color = { bg = colors.active_oil, fg = colors.bblack, gui='bold,italic' },
        padding = { left = 3, right = 5 },
        separator = { right = '' },
      },
    },
    lualine_b = { { empty, color = { bg = colors.grey } } },
  },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = my_theme,
    -- component_separators = { left = '', right = '' },
    -- section_separators = { left = '', right = '' },
    component_separators = { left = ' 󰪍󰪍 ', right = '' },
    section_separators = { left = '', right = '' },
    disabled_filetypes = {
      statusline = { 'packer', 'alpha', 'vimwiki' },
      -- winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = false,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {
      {
        'filename',
         symbols = {
           modified = '[]',      -- Text to show when the file is modified.
           readonly = '[]',      -- Text to show when the file is non-modifiable or readonly.
           unnamed = 'No Name', -- Text to show for unnamed buffers.
           newfile = 'New',     -- Text to show for newly created file before first write
         },
         color = {
           fg = colors.black,
           gui = 'bold',
         },
      },
    },
    lualine_b = {
      {
        'diff',
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.yellow },
          removed = { fg = colors.red }
        },
        symbols = {
          added = '+',
          -- modified = '󰔷 ',
          modified = '~',
          removed = '-'
        },
      },
      {'diagnostics'}
    },
    lualine_c = {},
    lualine_x = {},
    lualine_y = { 'location', },
    lualine_z = {{ 'progress', padding = { right = 2 }} },
  },
  inactive_sections = {
    lualine_a = {
      {
        'filename',
         symbols = {
           modified = '[]',      -- Text to show when the file is modified.
           readonly = '[]',      -- Text to show when the file is non-modifiable or readonly.
           unnamed = 'No Name', -- Text to show for unnamed buffers.
           newfile = 'New',     -- Text to show for newly created file before first write
         },
         color = {
           fg = colors.black,
           gui = 'italic',
         },
      },
    },
    lualine_b = {
      {
        'diff',
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.yellow },
          removed = { fg = colors.red }
        },
        symbols = {
          added = '+',
          -- modified = '󰔷 ',
          modified = '~',
          removed = '-'
        },
      },
      {'diagnostics'}
    },
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {'fugitive', 'toggleterm', my_quickfix, my_nvimTree, my_oil},
}
