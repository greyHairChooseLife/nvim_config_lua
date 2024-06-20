require('gitsigns').setup({
  signs = {
    add          = { hl = 'DevIconQt', text = '+' },
    change       = { hl = 'DevIconGuix', text = '~' },
    delete       = { hl = 'DevIconFreeCADConfig', text = '_' },
    topdelete    = { hl = 'DevIconFreeCADConfig', text = '‾' },
    changedelete = { hl = 'DevIconFreeCADConfig', text = '~' },
    untracked    = { hl = 'DevIconQt', text = '?' },
  },
  update_debounce = 10,
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = true,

  signs_staged_enable = true,
  signs_staged = {
    add          = { hl = 'DevIconQt', text = '✔' },
    change       = { hl = 'DevIconGuix', text = '✔' },
    delete       = { hl = 'DevIconFreeCADConfig', text = '✔' },
    topdelete    = { hl = 'DevIconFreeCADConfig', text = '✔' },
    changedelete = { hl = 'DevIconFreeCADConfig', text = '✔' },
  },
})

vim.cmd "set statusline+={get(b:,'gitsigns_statusline',')}"
