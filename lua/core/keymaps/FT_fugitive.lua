vim.api.nvim_create_autocmd("FileType", {
  pattern = "fugitive",
  callback = function()
    vim.keymap.set('n', 'P', ':G push', { buffer = true })
    vim.keymap.set('n', 'gq', function()
      if vim.fn.winnr('$') == 1 then vim.cmd('q!')
      elseif vim.fn.winnr('$') == 2 and require('nvim-tree.api').tree.is_visible() then vim.cmd('q!')
      else vim.cmd('bd!') end
    end, { buffer = true} ) -- close buffer, saving memory
  end
})
