vim.api.nvim_create_autocmd("FileType", {
  pattern = "fugitive",
  callback = function()
    -- GUI
    vim.api.nvim_set_hl(0, "FugitiveBufferHighlight", { bg = "#242024" })
    vim.api.nvim_set_hl(0, "FugitiveBufferEOB", { fg = "#242024" })
    vim.cmd("setlocal winhighlight=Normal:FugitiveBufferHighlight,SignColumn:FugitiveBufferHighlight,EndOfBuffer:FugitiveBufferEOB")


    vim.keymap.set('n', 'P', ':G push', { buffer = true })
    vim.keymap.set('n', 'gq', function()
      if vim.fn.winnr('$') == 1 then vim.cmd('q')
      elseif vim.fn.winnr('$') == 2 and require('nvim-tree.api').tree.is_visible() then vim.cmd('q')
      else vim.cmd('bd!') end
    end, { buffer = true} ) -- close buffer, saving memory
    vim.keymap.set('n', 'i', function()
      vim.cmd('normal =')
    end, { buffer = true }) -- do nothing
  end
})
