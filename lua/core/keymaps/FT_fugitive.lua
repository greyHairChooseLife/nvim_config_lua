vim.api.nvim_create_autocmd("FileType", {
  pattern = "fugitive",
  callback = function()
    vim.keymap.set('n', 'P', ':G push', { buffer = true })
    vim.keymap.set({ 'n', 'v' }, 'gq', ':q!<CR>', { buffer = true })
  end
})
