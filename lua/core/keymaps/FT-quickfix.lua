vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set('n', 'dd', RemoveQFItem, { buffer = true, silent = true })
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set('n', 'DD', ClearQFList, { buffer = true, silent = true })
  end
})
