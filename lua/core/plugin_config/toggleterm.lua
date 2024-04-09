require("toggleterm").setup {
  size = 100,
  open_mapping = [[<c-\>]],
  hide_numbers = true, -- hide the number column in toggleterm buffers
  shade_filetypes = {},
  start_in_insert = true,
  insert_mappings = true, -- whether or not the open mapping applies in insert mode
  persist_size = false,
  direction = 'vertical',
  close_on_exit = true, -- close the terminal window when the process exits
  shell = vim.o.shell,  -- change the default shell
  float_opts = {
    border = 'single',
    width = 200,
    height = 50,
    winblend = 3,
    highlights = {
      border = "Normal",
      background = "Normal",
    }
  },
  --  This field is only relevant if direction is set to 'float'
  --  highlights = {
  --    Normal = {
  --      guibg = "TabLine",
  --    }
  --  }
}
