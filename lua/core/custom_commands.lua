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
vim.cmd('command! ShowCursor lua ShowCursor()')

function ExpandGlow()
  vim.cmd([[
    Glow
    resize 999
    vertical resize 999'
  ]])
end
vim.cmd('command! GlowFull lua ExpandGlow()')


function GGOpenPRs() vim.cmd('GHOpenPR') end
function GGstartReview() vim.cmd('GHStartReview') end
function GGsubmitReview() vim.cmd('GHSubmitReview') end
function GGdeleteReview() vim.cmd('GHDeleteReview') end
function GGcomment() vim.cmd('GHCreateThread') end

vim.cmd('command! GGopenPRs lua GGOpenPRs()')
vim.cmd('command! GGstartReview lua GGstartReview()')
vim.cmd('command! GGsubmitReview lua GGsubmitReview()')
vim.cmd('command! GGdeleteReview lua GGdeleteReview()')
vim.cmd('command! GGcomment lua GGcomment()')
