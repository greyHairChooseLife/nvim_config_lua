vim.api.nvim_create_autocmd("FileType", {
  pattern = "fugitive",
  callback = function()
    vim.keymap.set('n', 'P', ':G push', { buffer = true })
  end
})
