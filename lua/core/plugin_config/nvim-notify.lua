require("notify").setup {
  background_colour = "NotifyBackground",
  fps = 200,
  icons = {
    DEBUG = "",
    ERROR = "",
    INFO = "",
    TRACE = "✎",
    WARN = ""
  },
  level = 2,
  minimum_width = 50,
  render = "default",
  stages = "static",
  time_formats = {
    notification = "%H:%M",
    notification_history = "%FT%T"
  },
  timeout = 2000,
  top_down = true
}

Notify = require('notify')
