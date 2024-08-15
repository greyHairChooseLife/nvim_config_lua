vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.keymap.set('n', 'dd', QF_RemoveItem, { buffer = true, silent = true })
    vim.keymap.set('n', 'DF', QF_ClearList, { buffer = true, silent = true })
    vim.keymap.set('n', '<C-n>', QF_MoveNext, { buffer = true })
    vim.keymap.set('n', '<C-p>', QF_MovePrev, { buffer = true })
  end
})
