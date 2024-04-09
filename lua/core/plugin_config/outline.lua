require("outline").setup({
  symbols = {
    icons = {
      File = { icon = '󰈔', hl = 'Identifier' },
      Module = { icon = '󰆧', hl = 'Include' },
      Namespace = { icon = '󰅪', hl = 'Include' },
      Package = { icon = '󰏗', hl = 'Include' },
      Class = { icon = '𝓒', hl = 'Type' },
      Method = { icon = 'ƒ', hl = 'Function' },
      Property = { icon = '', hl = 'Identifier' },
      Field = { icon = '󰆨', hl = 'Identifier' },
      Constructor = { icon = '', hl = 'Special' },
      Enum = { icon = 'ℰ', hl = 'Type' },
      Interface = { icon = '󰜰', hl = 'Type' },
      Function = { icon = 'Fnc', hl = 'Function' },
      Variable = { icon = 'var', hl = 'Constant' },
      Constant = { icon = '', hl = 'Constant' },
      String = { icon = '𝓐', hl = 'String' },
      Number = { icon = '#', hl = 'Number' },
      Boolean = { icon = '⊨', hl = 'Boolean' },
      Array = { icon = '󰅪', hl = 'Constant' },
      Object = { icon = '⦿', hl = 'Type' },
      Key = { icon = '🔐', hl = 'Type' },
      Null = { icon = 'NULL', hl = 'Type' },
      EnumMember = { icon = '', hl = 'Identifier' },
      Struct = { icon = '𝓢', hl = 'Structure' },
      Event = { icon = '🗲', hl = 'Type' },
      Operator = { icon = '+', hl = 'Identifier' },
      TypeParameter = { icon = '𝙏', hl = 'Identifier' },
      Component = { icon = '󰅴', hl = 'Function' },
      Fragment = { icon = '󰅴', hl = 'Constant' },
      -- ccls
      TypeAlias = { icon = ' ', hl = 'Type' },
      Parameter = { icon = ' ', hl = 'Identifier' },
      StaticMethod = { icon = ' ', hl = 'Function' },
      Macro = { icon = ' ', hl = 'Function' },
    },
  },
  outline_window = {
    width = 40,
    relative_width = false,
    ---@type boolean|string?
    show_cursorline = true,
    hide_cursor = false,
    winhl = 'Normal:OutlineNormal',
  },
  keymaps = {
    up_and_jump = '<C-p>',
    down_and_jump = '<C-n>',
  }
})

vim.cmd("highlight OutlineNormal guifg=#a9b1d6 guibg=#1f2335")
vim.cmd("highlight OutlineCurrent guifg=#1d202f guibg=#9ece6a")
