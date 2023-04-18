function ShowCursor()
  if vim.o.cursorline then
      vim.o.cursorline = false
      vim.o.cursorcolumn = false
      vim.o.relativenumber = false
  else
      vim.o.cursorline = true
      vim.o.cursorcolumn = true
      vim.o.relativenumber = true
      vim.cmd([[
        highlight CursorColumn guifg=white guibg=#AB82A5
        highlight CursorLine guifg=white guibg=#AB82A5
      ]])
  end
end
vim.cmd('command ShowCursor lua ShowCursor()')

function ExpandGlow()
  vim.cmd([[
    Glow
    resize 999
    vertical resize 999'
  ]])
end
vim.cmd('command GlowFull lua ExpandGlow()')
