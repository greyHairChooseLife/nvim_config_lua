vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = 'NvimTree',
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

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'NvimTree',
  callback = function()
    local api = require('nvim-tree.api')

    vim.keymap.set('n', 'l', function()
        local node = api.tree.get_node_under_cursor()
        vim.cmd('vert rightbelow new')
        vim.cmd('edit ' .. node.absolute_path)
        vim.cmd('NvimTreeFocus')
      end,
      { buffer = true, desc = 'Open in new vertical split' }
    )
  end
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = 'NvimTree',
  callback = function()
    local api = require('nvim-tree.api')

    vim.keymap.set('n', 'L', function()
        local node = api.tree.get_node_under_cursor()
        vim.cmd('vert rightbelow new')
        vim.cmd('edit ' .. node.absolute_path)
      end,
      { buffer = true, desc = 'Open in new vertical split' }
    )
  end
})

-- markdown은 108자로 자동 줄바꿈
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.bo.textwidth = 108
  end
})
