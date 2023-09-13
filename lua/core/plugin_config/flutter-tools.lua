require("flutter-tools").setup {
  widget_guides = {
    enabled = true,
  },
  outline = {
    auto_open = true,
  },
  closing_tags = {
    highlight = "ErrorMsg",
    prefix = "▾ ",
    enabled = false,
  },
  dev_log = {
    enabled = true,
    notify_errors = false,
    open_cmd = "tabedit",
  },
} -- use defaults
