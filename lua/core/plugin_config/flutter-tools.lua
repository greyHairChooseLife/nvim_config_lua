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

-- 명령어와 대응하는 함수를 테이블에 저장
local commands = {
  { name = 'FTouTline',        cmd = 'FlutterOutlineToggle' },
  { name = 'FTemuLator',       cmd = 'FlutterEmulators' },
  { name = 'FTruN',            cmd = 'FlutterRun' },
  { name = 'FTresTart',        cmd = 'FlutterRestart' },
  { name = 'FTdeVtool',        cmd = 'FlutterOpenDevTools' },
  { name = 'FTvisualDebug',    cmd = 'FlutterVisualDebug' },
  { name = 'FTcopyDevToolUrl', cmd = 'FlutterCopyProfilerUrl' },
  { name = 'FTclearLog',       cmd = 'FlutterLogClear' },
}

-- 각 명령어에 대해 함수를 정의하고 명령어를 등록
for _, ele in ipairs(commands) do
  -- 지역 변수를 사용하여 함수 정의
  local function_name = function() vim.cmd(ele.cmd) end
  vim.api.nvim_create_user_command(ele.name, function_name, {})
end
