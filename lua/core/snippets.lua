-- 날짜 찍기
vim.keymap.set('i', ',d', function() -- 2024-06-11
  local result = vim.fn.system('date | sed "s/. /-/3" | cut -d"-" -f1 | sed "s/. /-/g"')
  result = result:gsub("\n$", "")
  vim.api.nvim_put({ result }, 'c', false, true)
end, { noremap = true, silent = true })
vim.keymap.set('i', ',D', function() -- 2024. 06. 11. (화) 17:52:17 KST
  local result = vim.fn.system('date')
  result = result:gsub("\n$", "")
  vim.api.nvim_put({ result }, 'c', false, true)
end, { noremap = true, silent = true })


-- SNIPPET 주석: [ TODO / NOTE / WARN / BUG ]
vim.keymap.set('i', ',,T', function()
  vim.api.nvim_feedkeys("TODO:", "n", true)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
  vim.defer_fn(function()
    vim.cmd("lua require('Comment.api').toggle.linewise.current()")
    vim.api.nvim_feedkeys("o", "n", true)
  end, 1) -- 최소한의 딜레이
end)
vim.keymap.set('i', ',,N', function()
  vim.api.nvim_feedkeys("NOTE:", "n", true)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
  vim.defer_fn(function()
    vim.cmd("lua require('Comment.api').toggle.linewise.current()")
    vim.api.nvim_feedkeys("o", "n", true)
  end, 1) -- 최소한의 딜레이
end)
vim.keymap.set('i', ',,W', function()
  vim.api.nvim_feedkeys("WARN:", "n", true)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
  vim.defer_fn(function()
    vim.cmd("lua require('Comment.api').toggle.linewise.current()")
    vim.api.nvim_feedkeys("o", "n", true)
  end, 1) -- 최소한의 딜레이
end)
vim.keymap.set('i', ',,B', function()
  vim.api.nvim_feedkeys("BUG:", "n", true)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
  vim.defer_fn(function()
    vim.cmd("lua require('Comment.api').toggle.linewise.current()")
    vim.api.nvim_feedkeys("o", "n", true)
  end, 1) -- 최소한의 딜레이
end)
