require("flutter-tools").setup {
  widget_guides = {
    enabled = true,
  },
-- it restricts a size of the outline like shit
--  outline = {
--    auto_open = false, 
--  },
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

function toggleFlutterToolsOutline() vim.cmd('FlutterOutlineToggle') end
vim.cmd('command! FTouTline lua toggleFlutterToolsOutline()')

function openFlutterEmulator() vim.cmd('FlutterEmulators') end
vim.cmd('command! FTemuLator lua openFlutterEmulator()')

function runFlutter() vim.cmd('FlutterRun') end
vim.cmd('command! FTruN lua runFlutter()')

function restartFlutter() vim.cmd('FlutterRestart') end
vim.cmd('command! FTresTart lua restartFlutter()')

function openFlutterDevTools() vim.cmd('FlutterOpenDevTools') end
vim.cmd('command! FTdeVtool lua openFlutterDevTools()')

function openVisualDebug() vim.cmd('FlutterVisualDebug') end
vim.cmd('command! FTvisualDebug lua openVisualDebug()')
