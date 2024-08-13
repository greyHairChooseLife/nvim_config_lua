local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- 재행무상
-- 재법무아
-- 일체개고
-- Set header
local function header()
  local cwd = vim.fn.getcwd()
  -- Git 디렉토리인지 확인
  local git_dir_check = vim.fn.system('git rev-parse --is-inside-work-tree 2>/dev/null')
  if git_dir_check:match('true') == nil then
    return {
      "                                                                              " .. cwd,
      "Not git dir                                                                                                               " }
  end

  local fetch_output = vim.fn.system('git log --oneline HEAD..FETCH_HEAD')
  local fetch_lines = {}
  for line in fetch_output:gmatch("([^\n]*)\n?") do
    table.insert(fetch_lines, line)
  end

  local result = {
    "                                                                                   " .. cwd,
    " HEAD..FETCH_HEAD                                                                                                                                 ",
    " ",
  }

  for _, line in ipairs(fetch_lines) do
    table.insert(result, "  " .. line)
  end

  table.insert(result, " origin/HEAD..HEAD")
  table.insert(result, "")

  local workload_output = vim.fn.system('git log --oneline origin/HEAD..HEAD')
  local workload_lines = {}
  for line in workload_output:gmatch("([^\n]*)\n?") do
    table.insert(workload_lines, line)
  end

  for _, line in ipairs(workload_lines) do
    table.insert(result, "  " .. line)
  end

  return result
end

dashboard.section.header.val = header()

-- Set menu
dashboard.section.buttons.val = {
  dashboard.button("fe", "                           -  fetch   ", function()
    vim.cmd('Git fetch')
    alpha.redraw()
  end),
  -- dashboard.button("n", "New", ":ene <BAR> startinsert <CR>"),
  dashboard.button("n", "New", ":ene<CR>"),
  dashboard.button("ff", "File", ":Telescope find_files<CR>"),
  dashboard.button("fw", "Word", ":Telescope live_grep<CR>"),
  dashboard.button("r", "Rrecent", ":Telescope oldfiles<CR>"),
  dashboard.button(".", "", ""),
  dashboard.button("D", "                   ---------  doc   ", ":cd ~/Documents | vi .<CR>"),
  dashboard.button("dfe", "                           -  fetch   ",
    ":cd ~/Documents/dev-wiki | :Git fetch | :cd ~/Documents/job-wiki | :Git fetch | :cd ~/Documents | vi .<CR>"),
  dashboard.button("w1", "1: dev", ":cd ~/Documents/dev-wiki | :VimwikiIndex<CR>"),
  dashboard.button("w2", "2: job", ":cd ~/Documents/job-wiki | :2VimwikiIndex<CR>"),
  dashboard.button(".", "", ""),
  dashboard.button("q", "                   ---------  configs   ", ":q<CR>"),
  dashboard.button("up", "󰂖 plugin update", ":PackerSync<CR>"),
  dashboard.button("i3", " i3", ":e ~/.i3/config<CR>"),
  dashboard.button("vi", " vi", ":e ~/.config/nvim<CR>"),
  dashboard.button("ba", " bash", ":e ~/.config/my-bashrc/<CR>"),
  dashboard.button(".", "", ""),
  dashboard.button("-", "                   ---------  sessions   ", ""),
  dashboard.button("S", "Session", require("auto-session.session-lens").search_session),
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

-- TODO: 
-- 아래 두 줄을 통해 redrawing 기능을 활성화하는 것인가?
-- dashboard.section.header.opts.redraw = true
-- dashboard.section.buttons.opts.redraw = true

-- Send config to alpha
alpha.setup(dashboard.opts)
