local actions = require("toggleterm-manager").actions

require("toggleterm-manager").setup {
  mappings = { -- key mappings bound inside the telescope window
    i = {
      ["<C-o>"] = { action = actions.toggle_term, exit_on_action = false }, -- toggles terminal open/closed
      ["<CR>"] = { action = actions.open_term, exit_on_action = true }, -- toggles terminal open/closed
      ["<C-n>"] = { action = actions.create_and_name_term, exit_on_action = false }, -- creates a new terminal buffer
      ["<C-d>"] = { action = actions.delete_term, exit_on_action = false }, -- deletes a terminal buffer
      ["<C-r>"] = { action = actions.rename_term, exit_on_action = false }, -- provides a prompt to rename a terminal
    },
    n = {
      ["o"] = { action = actions.toggle_term, exit_on_action = false }, -- toggles terminal open/closed
      ["<CR>"] = { action = actions.open_term, exit_on_action = true }, -- toggles terminal open/closed
      ["N"] = { action = actions.create_and_name_term, exit_on_action = false }, -- creates a new terminal buffer
      ["D"] = { action = actions.delete_term, exit_on_action = false }, -- deletes a terminal buffer
      ["R"] = { action = actions.rename_term, exit_on_action = false }, -- provides a prompt to rename a terminal
    },
  },
  titles = {
    prompt = "Pick Term",
    results = "Terminals",
    preview = "Bash"
  },
  results = {
    fields = { { "state", "Boolean" }, "space", "term_icon", "term_name", },
  }
}
