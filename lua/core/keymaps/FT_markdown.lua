vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- GUI
    vim.cmd('IBLToggle')

    -- keymaps
    vim.keymap.set('n', 'PP', '<cmd>MarkdownPreview<CR>', { buffer = true })
  end,
})
