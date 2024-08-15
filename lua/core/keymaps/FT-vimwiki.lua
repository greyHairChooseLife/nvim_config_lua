vim.api.nvim_create_autocmd("FileType", {
  pattern = "vimwiki",
  callback = function()
    -- SNIPPET
    vim.keymap.set('i', ',,H', function()
      vim.api.nvim_feedkeys("# 󰏢 ", "i", true)

      -- 아래 방식으로는 더 복잡한 작업도 가능
      -- local msg = "# 󰏢 "
      -- vim.api.nvim_put({ msg }, 'c', true, true)
    end)
    vim.keymap.set('i', ',,h1', function()
      vim.api.nvim_feedkeys("## ", "i", true)
    end)
    vim.keymap.set('i', ',,h2', function()
      vim.api.nvim_feedkeys("### ", "i", true)
    end)
    vim.keymap.set('i', ',,h3', function()
      vim.api.nvim_feedkeys("#### ", "i", true)
    end)
  end
})
