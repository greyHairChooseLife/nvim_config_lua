-- COMMIT_EDITMSG 버퍼를 우측에 열리도록 설정
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    -- GUI
    vim.api.nvim_set_hl(0, "FugitiveBufferHighlight", { bg = "#242024" })
    vim.api.nvim_set_hl(0, "FugitiveBufferEOB", { fg = "#242024" })
    vim.cmd("setlocal winhighlight=Normal:FugitiveBufferHighlight,SignColumn:FugitiveBufferHighlight,EndOfBuffer:FugitiveBufferEOB")

    vim.cmd('wincmd p')
    local save_view = vim.fn.winsaveview()
    vim.cmd('WinShift up')
    vim.cmd("wincmd p")
    vim.cmd('WinShift right')
    vim.cmd("wincmd p")
    vim.fn.winrestview(save_view)
    vim.cmd("wincmd p")
    vim.cmd("normal gg")
  end,
})
