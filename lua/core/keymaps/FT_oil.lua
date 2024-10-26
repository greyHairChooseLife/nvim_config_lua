vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    -- GUI
    vim.api.nvim_set_hl(0, "OilBufferHighlight", { bg = "#1A1601" })
    vim.api.nvim_set_hl(0, "OilBufferEOB", { fg = "#1A1601" })
    vim.cmd("setlocal winhighlight=Normal:OilBufferHighlight,EndOfBuffer:OilBufferEOB")
  end
})

