require("copilot").setup({
  panel = {
    enabled = true,
    auto_refresh = false,
    keymap = {
      jump_prev = "[[",
      jump_next = "]]",
      accept = "<CR>",
      refresh = "gr",
      open = "<M-CR>"
    },
    layout = {
      position = "right", -- | top | left | right
      ratio = 0.2
    },
  },
  suggestion = {
    enabled = true,
    auto_trigger = false,
    debounce = 75,
    keymap = {
      accept = "<M-CR>",
      accept_word = "<M-k>",
      accept_line = "<M-l>",
      next = "<M-]>",
      prev = "<M-[>",
      dismiss = "<C-]>"
    },
  },
  filetypes = {
    yaml = false,
    markdown = true,
    help = false,
    gitcommit = true,
    gitrebase = false,
    hgcommit = false,
    svn = false,
    cvs = false,
    ["."] = false,
  },
  copilot_node_command = "node", -- Node.js version must be > 18.x
  server_opts_overrides = {},
})
