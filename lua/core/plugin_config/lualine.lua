--󰳟

local colors = {
  blue = '#61afef',
  green = '#98c379',
  purple = '#c678dd',
  red = '#e06c75',
  yellow = '#e5c07b',
  wwhite = '#abb2bf',
  white = '#ffffff',
  bblack = '#282c34',
  black = '#000000',
  grey = '#5c6370',
}

local my_theme = {
  normal = {
    a = { fg = colors.yellow, bg = colors.black, gui = 'bold' },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.black, bg = colors.green },
    x = { fg = colors.white, bg = colors.black },
    y = { fg = colors.grey, bg = colors.black },
    z = { fg = colors.yellow, bg = colors.black },
  },
  inactive = {
    a = { fg = colors.yellow, bg = colors.black },
    b = { fg = colors.white, bg = colors.black },
    c = { fg = colors.grey, bg = colors.black },
    x = { fg = colors.grey, bg = colors.black },
    y = { fg = colors.grey, bg = colors.black },
    z = { fg = colors.yellow, bg = colors.black },
  },
}

require('lualine').setup {
  options = {
    icons_enabled = true,
    theme = my_theme,
    component_separators = { left = '', right = ''},
    section_separators = { left = '', right = ''},
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    globalstatus = false,
    refresh = {
      statusline = 1000,
      tabline = 1000,
      winbar = 1000,
    }
  },
  sections = {
    lualine_a = {'filename'},
    lualine_b = {'diagnostics'},
    lualine_c = {'progress'},
    lualine_x = {},
    lualine_y = {{'filetype', colored = true, icon_only = true}},
    lualine_z = { 
      {
        'diff',
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.yellow },
          removed = { fg = colors.red }
        },
        symbols = { 
          added = '+ ',
          modified = '󰔷 ',
          removed = '- '
        },
      },
    }
  },
  inactive_sections = {
    lualine_a = {'filename'},
    lualine_b = {'diagnostics'},
    lualine_c = {},
    lualine_x = {},
    lualine_y = {
      {'filetype', colored = true, icon_only = true}
    },
    lualine_z = {
      {
        'diff',
        diff_color = {
          added = { fg = colors.green },
          modified = { fg = colors.yellow },
          removed = { fg = colors.red }
        },
        symbols = { 
          added = '+ ',
          modified = '󰔷 ',
          removed = '- '
        },
      },

    }
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {}
}
