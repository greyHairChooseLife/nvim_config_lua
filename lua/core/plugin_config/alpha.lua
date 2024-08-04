local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- 재행무상
-- 재법무아
-- 일체개고
-- Set header
local function header()
  local fetch_output = vim.fn.system('git log --oneline HEAD..FETCH_HEAD')
  -- 여러 줄의 출력을 나눔
  local fetch_lines = {}
  for line in fetch_output:gmatch("([^\n]*)\n?") do
    table.insert(fetch_lines, line)
  end
  -- 현재 브랜치와 fetch 출력을 포함한 테이블 반환
  local result = {
  " HEAD..FETCH_HEAD                                                                                                                                 ",
  " ",
  }
  -- fetch 출력 라인을 result 테이블에 추가
  for _, line in ipairs(fetch_lines) do
    table.insert(result, line)
  end

  table.insert(result, "")
  table.insert(result, " origin..HEAD")
  table.insert(result, "")

  local workload_output = vim.fn.system('git log --oneline FETCH_HEAD..HEAD')
  -- 여러 줄의 출력을 나눔
  local workload_lines = {}
  for line in workload_output:gmatch("([^\n]*)\n?") do
    table.insert(workload_lines, line)
  end

  -- log 출력 라인을 result 테이블에 추가
  for _, line in ipairs(workload_lines) do
    table.insert(result, line)
  end

  return result
end

dashboard.section.header.val = header()

-- Set menu
dashboard.section.buttons.val = {
  dashboard.button("S", "Session", require("auto-session.session-lens").search_session),
  dashboard.button("n", "New", ":ene <BAR> startinsert <CR>"),
  dashboard.button("ff", "File", ":Telescope find_files<CR>"),
  dashboard.button("fw", "Word", ":Telescope grep_string<CR>"),
  dashboard.button("r", "Rrecent", ":Telescope oldfiles<CR>"),
  dashboard.button(".", "", ""),
  dashboard.button("D", "                   ---------  doc   ", ":cd ~/Documents | vi .<CR>"),
  dashboard.button("w1", "1: dev", ":cd ~/Documents/dev-wiki | :VimwikiIndex<CR>"),
  dashboard.button("w2", "2: job", ":cd ~/Documents/job-wiki | :2VimwikiIndex<CR>"),
  dashboard.button(".", "", ""),
  dashboard.button("q", "                   ---------  configs   ", ":q<CR>"),
  dashboard.button("up", "󰂖 plugin update", ":PackerSync<CR>"),
  dashboard.button("i3", " i3", ":e ~/.i3/config<CR>"),
  dashboard.button("vi", " vi", ":e ~/.config/nvim<CR>"),
  dashboard.button("ba", " bash", ":e ~/.config/my-bashrc/<CR>"),
}

local function footer()
  return {
    "1. 미루지 않기",
    "2. 어려운 쪽을 선택하기",
  }
end
-- dashboard.section.footer.val = footer()

dashboard.section.header.opts.hl = "AlphaHeaderLabel"
dashboard.section.buttons.opts.hl = "GitSignsChange"
dashboard.section.footer.opts.hl = "ErrorMsg"

-- Send config to alpha
alpha.setup(dashboard.opts)

-- require('lualine').hide()
-- <
--
--
-- To enable it again you can do
--
-- >
--     require('lualine').hide({unhide=true})
