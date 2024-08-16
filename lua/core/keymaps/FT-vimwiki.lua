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

    -- callouts
    vim.keymap.set('i', ',,qt', function()
      vim.api.nvim_put({ "> [!qt] ", ">   󱞪 " }, 'c', false, true)

      -- 커서를 [!qt]의 q 뒤로 이동
      local row = unpack(vim.api.nvim_win_get_cursor(0))
      vim.api.nvim_win_set_cursor(0, { row - 1, 10 })
    end)
    vim.keymap.set('i', ',,td', function()
      local date = vim.fn.system('date | sed "s/. /-/3" | cut -d"-" -f1 | sed "s/. /-/g"')
      date = date:gsub("\n$", "")
      vim.api.nvim_put({ "> [!td]", "> " .. date, "> - ", ">  󱞪 " }, 'c', false, true)

      -- 커서를 [!qt]의 q 뒤로 이동
      local row = unpack(vim.api.nvim_win_get_cursor(0))
      vim.api.nvim_win_set_cursor(0, { row - 1, 10 })
    end)
    vim.keymap.set('i', ',,rf', function()
      vim.api.nvim_put({ "> [!rf]" }, 'l', false, true)
      vim.api.nvim_put({ "> " }, 'c', false, true)
    end)
    vim.keymap.set('i', ',,co', function()
      vim.api.nvim_put({ "> [!" }, 'c', false, true)
    end)

    -- SPECIAL UI
    vim.cmd('NvimTreeResize 100') -- require('nvim-tree.api').nvim-tree-api.tree.resize(100) 뭐야 외완되
  end
})

-- TODO: keymap:
-- 1. tab 및 S-tab 대신 <C-j> 및 <C-k>로 이동
-- 2. tab 및 S-tab은 기존 <C-CR> 및 <S-CR> 등 노트를 옆으로 펼치는 키로 활용하자.
