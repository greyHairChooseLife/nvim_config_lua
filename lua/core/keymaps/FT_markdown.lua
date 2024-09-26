vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- GUI
    -- vim.cmd('IBLEnable')

    -- keymaps
    vim.keymap.set('n', 'PP', '<cmd>MarkdownPreview<CR>', { buffer = true })
    vim.keymap.set('v', 'i', '<ESC>i')
    vim.keymap.set('v', 'a', '<ESC>a')
  end,
})
