vim.g.startify_bookmarks = {
  { ['b'] = '~/.bashrc' },
  { ['v'] = '~/.config/nvim/init.lua' },
  { ['w'] = '~/wiki/index.md' },
  { ['x'] = '~/.xprofile' },
  { ['t'] = '~/.Xresources' },
}

vim.g.startify_lists = {
  --{ type = "commands", header = { "    Commands" } }, -- Commands from above
  { type = "bookmarks", header = {"   Bookmarks"} },
  --{ type = "dir", header = { "    MRU " .. vim.fn.getcwd() } }, -- MRU files from CWD
  { type = "files", header = { "    MRU "} },
  --{ type = "sessions",  header = {"   Sessions"} },
}

-- ASCII ART
vim.g.startify_custom_header = {}
