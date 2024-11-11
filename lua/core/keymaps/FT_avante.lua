vim.api.nvim_create_autocmd("FileType", {
  pattern = "Avante",
  callback = function()
    -- GUI
    vim.api.nvim_set_hl(0, "AvanteBufferHighlight", { bg = "#242024" })
    vim.api.nvim_set_hl(0, "AvanteBufferEOB", { fg = "#242024" })
    vim.cmd("setlocal winhighlight=Normal:AvanteBufferHighlight,SignColumn:AvanteBufferHighlight,EndOfBuffer:AvanteBufferEOB")
  end
})

vim.api.nvim_create_autocmd("FileType", {
  pattern = "AvanteInpu",
  callback = function()
    -- GUI
    -- vim.api.nvim_set_hl(0, "FugitiveBufferHighlight", { bg = "#242024" })
    -- vim.api.nvim_set_hl(0, "FugitiveBufferEOB", { fg = "#242024" })
    -- vim.cmd("setlocal winhighlight=Normal:FugitiveBufferHighlight,SignColumn:FugitiveBufferHighlight,EndOfBuffer:FugitiveBufferEOB")
  end
})
