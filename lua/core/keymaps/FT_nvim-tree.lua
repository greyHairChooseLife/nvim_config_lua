vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    -- load resource
    local api = require('nvim-tree.api')

    -- gui

    -- keymap
    vim.keymap.set({ 'n', 'v' }, 'gq', function()
      api.tree.close_in_this_tab()
    end , { buffer = true })
  end
})
