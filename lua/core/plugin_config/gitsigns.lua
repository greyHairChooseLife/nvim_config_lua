require('gitsigns').setup({
  update_debounce = 10,
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = true,

  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '?' },
  },
  signs_staged_enable = true,
  signs_staged = {
    add          = { hl = 'GitSignsAdd', text = '✔' },
    change       = { hl = 'GitSignsChange', text = '✔' },
    delete       = { hl = 'GitSignsChangedelete', text = '✔' },
    topdelete    = { hl = 'GitSignsDelete', text = '✔' },
    changedelete = { hl = 'GitSignsTopdelete', text = '✔' },
    untracked    = { hl = 'GitSignsUntracked', text = '✔' }
  },
})

vim.cmd "set statusline+={get(b:,'gitsigns_statusline',')}"
