vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = 'NvimTree*',
  callback = function()
    local api = require('nvim-tree.api')
    local view = require('nvim-tree.view')

    if not view.is_visible() then
      api.tree.open()
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.cmd("normal! zR")
  end,
})
