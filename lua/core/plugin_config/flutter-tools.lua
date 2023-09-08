require("flutter-tools").setup {
  widget_guides = {
    enabled = true,
  },
  closing_tags = {
    highlight = "ErrorMsg",
    prefix = "▾ ",
    enabled = false,
  },
  dev_log = {
    enabled = false,
    notify_errors = false,
    open_cmd = "tabedit",
  },
} -- use defaults
