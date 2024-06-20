require('gitsigns').setup({
  signs = {
    add          = { hl = 'DevIconQt', text = '+' },
    change       = { hl = 'DevIconGuix', text = '~' },
    -- delete       = { hl = 'DevIconFreeCADConfig', text = '_' },
    -- topdelete    = { hl = 'DevIconFreeCADConfig', text = '‾' },
    -- changedelete = { hl = 'DevIconFreeCADConfig', text = '~' },
    delete       = { hl = 'NvimTreeGitDeleted', text = '_' },
    topdelete    = { hl = 'NvimTreeGitDeleted', text = '‾' },
    changedelete = { hl = 'NvimTreeGitDeleted', text = '~' },
    untracked    = { hl = 'NvimTreeGitNew', text = '?' },
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
    delete       = { hl = 'NvimTreeGitDeleted', text = '✔' },
    topdelete    = { hl = 'NvimTreeGitDeleted', text = '✔' },
    changedelete = { hl = 'NvimTreeGitDeleted', text = '✔' },
  },
})

vim.cmd "set statusline+={get(b:,'gitsigns_statusline',')}"
