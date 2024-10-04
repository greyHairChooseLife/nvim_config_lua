vim.api.nvim_create_autocmd("FileType", {
  pattern = "DiffviewFiles",
  callback = function()
    -- gui
    local tabnr = vim.fn.tabpagenr()
    vim.fn.settabvar(tabnr, 'tabname', ' File')
  end
})


vim.api.nvim_create_autocmd("FileType", {
  pattern = "DiffviewFileHistory",
  callback = function()
    -- gui
    local tabnr = vim.fn.tabpagenr()
    vim.fn.settabvar(tabnr, 'tabname', ' Commit')
  end
})
