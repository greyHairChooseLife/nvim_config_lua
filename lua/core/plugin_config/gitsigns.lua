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
    add          = { text = '✔' },
    change       = { text = '✔' },
    delete       = { text = '✔' },
    topdelete    = { text = '✔' },
    changedelete = { text = '✔' },
  },
})

vim.cmd "set statusline+={get(b:,'gitsigns_statusline',')}"
