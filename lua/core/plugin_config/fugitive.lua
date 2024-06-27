-- COMMIT_EDITMSG 버퍼를 우측에 열리도록 설정
vim.api.nvim_create_autocmd("FileType", {
  pattern = "gitcommit",
  callback = function()
    vim.cmd('WinShift down')
    vim.cmd('WinShift right')
  end,
})
