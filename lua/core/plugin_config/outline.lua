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
    width = 25,
    relative_width = true,
    ---@type boolean|string?
    show_cursorline = false,
    hide_cursor = false,
    winhl = 'Normal:OutlineNormal',
  },
  outline_item = {
    highlight_hovered_item = true,
    auto_set_cursor = true,
  },
  keymaps = {
    up_and_jump = '<C-p>',
    down_and_jump = '<C-n>',
    close = 'gq'
  },
  providers = {
    priority = { 'lsp', 'coc', 'markdown', 'norg' },
    -- Configuration for each provider (3rd party providers are supported)
    lsp = {
      -- Lsp client names to ignore
      blacklist_clients = {},
    },
    markdown = {
      -- List of supported ft's to use the markdown provider
      filetypes = {'markdown', 'md', 'vimwiki'},
    },
  },
})
