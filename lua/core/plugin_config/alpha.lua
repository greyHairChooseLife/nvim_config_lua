local alpha = require("alpha")
local dashboard = require("alpha.themes.dashboard")

-- Set header
dashboard.section.header.val = {
  " ",
  " ",
  "                    재  행  무  상                                                                                                                                                                                                             ",
  "                                                     ",
  "                    재  법  무  아                   ",
  "                                                     ",
  "                    일  체  개  고                   ",
  " ",
  -- "  ███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗ ",
  -- "  ████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║ ",
  -- "  ██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║ ",
  -- "  ██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║ ",
  -- "  ██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║ ",
  -- "  ╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝ ",
}

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
    "1. 미루지 않기                                                                                                                                     ",
    "2. 어려운 쪽을 선택하기",
  }
end

dashboard.section.footer.val = footer()

dashboard.section.header.opts.hl = "AlphaHeaderLabel"
dashboard.section.buttons.opts.hl = "GitSignsChange"
dashboard.section.footer.opts.hl = "ErrorMsg"

-- Send config to alpha
alpha.setup(dashboard.opts)
