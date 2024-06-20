require('gitsigns').setup({
  -- signs = {
  --   add          = {
  --     hl = 'CustomSignsAdd',
  --     linehl = 'CustomSignsAddBg',
  --     text = '▍'
  --   },
  --   change       = {
  --     hl = 'CustomSignsChange',
  --     linehl = 'CustomSignsChangeBg',
  --     text = '▍'
  --   },
  --   delete       = {
  --     hl = 'CustomSignsDelete',
  --     text = '▼'
  --   },
  --   topdelete    = { text = '‾' },
  --   changedelete = { text = '~' },
  --   untracked    = { text = '┆' },
  -- },
  signs = {
    add          = { hl = 'DevIconQt', text = '+' },
    change       = { hl = 'DevIconGuix', text = '~' },
    delete       = { hl = 'DevIconFreeCADConfig', text = '_' },
    topdelete    = { hl = 'DevIconFreeCADConfig', text = '‾' },
    changedelete = { hl = 'DevIconFreeCADConfig', text = '~' },
    untracked    = { hl = 'DevIconLXQt', text = '+' },
  },
  update_debounce = 300,
})

vim.cmd "set statusline+={get(b:,'gitsigns_statusline',')}"
