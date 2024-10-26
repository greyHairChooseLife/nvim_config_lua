vim.api.nvim_create_autocmd("FileType", {
  pattern = "aerial",
  callback = function()
    -- GUI
    vim.api.nvim_set_hl(0, "AerialBufferHighlight", { bg = "#333342" })
    vim.api.nvim_set_hl(0, "AerialBufferEOB", { fg = "#333342" })
    vim.cmd("setlocal winhighlight=Normal:AerialBufferHighlight,SignColumn:AerialBufferHighlight,EndOfBuffer:AerialBufferEOB")
  end
})

