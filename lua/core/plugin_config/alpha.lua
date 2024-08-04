local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- 재행무상
-- 재법무아
-- 일체개고
-- Set header
local function header()
  -- Git 디렉토리인지 확인
  local git_dir_check = vim.fn.system('git rev-parse --is-inside-work-tree 2>/dev/null')
  if git_dir_check:match('true') == nil then
    return {
      "not in a git dir                                                                                                                                 " }
  end

  local fetch_output = vim.fn.system('git log --oneline HEAD..FETCH_HEAD')
  local fetch_lines = {}
  for line in fetch_output:gmatch("([^\n]*)\n?") do
    table.insert(fetch_lines, line)
  end

  local result = {
    " HEAD..FETCH_HEAD                                                                                                                                 ",
    " ",
  }

  for _, line in ipairs(fetch_lines) do
    table.insert(result, line)
  end

  table.insert(result, " origin..HEAD")
  table.insert(result, "")

  local workload_output = vim.fn.system('git log --oneline FETCH_HEAD..HEAD')
  local workload_lines = {}
  for line in workload_output:gmatch("([^\n]*)\n?") do
    table.insert(workload_lines, line)
  end

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
