vim.api.nvim_create_autocmd("FileType", {
  pattern = "vimwiki",
  callback = function()
    -- UI
    vim.cmd('NvimTreeResize 100') -- require('nvim-tree.api').nvim-tree-api.tree.resize(100) 뭐야 외완되
    -- set number! signcolumn=no
    vim.opt.signcolumn = "no"
    vim.opt.relativenumber = false
    -- LineNr: 일반 줄 번호의 색상 설정
    vim.api.nvim_set_hl(0, "LineNr", { fg = "#24283B" })
    -- relNumber
    -- vim.api.nvim_set_hl(0, "CursorLineNr", { bg = "#24283B" })

    -- SNIPPET
    vim.keymap.set('i', ',,H', function()
      vim.api.nvim_feedkeys("# 󰏢 ", "i", true)

      -- TODO:: 이거 현재 파일의 이름을 가져와서 '_'(under-bar)모두 ' '(공백)으로 바꾸고, 끝에 '.md'를 제거하는것도 추가해주자.

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

    -- Log callout
    vim.keymap.set('i', ',,lg', function()
      local date = vim.fn.system('date | sed "s/. /-/3" | cut -d"-" -f1 | sed "s/. /-/g"')
      date = date:gsub("\n$", "")
      vim.api.nvim_put({ "> [!lg] Log " .. date, "> - " }, 'c', false, true)

      -- 커서를 [!qt]의 q 뒤로 이동
      -- local row = unpack(vim.api.nvim_win_get_cursor(0))
      -- vim.api.nvim_win_set_cursor(0, { row - 1, 10 })
    end)

    -- callout: 개념정리
    vim.keymap.set('i', ',,cn', function()
      vim.api.nvim_put({ "> [!cn] 개념정리", "> ", "> " }, 'c', false, true)
    end)

    vim.keymap.set('n', '<leader>w', function()
      vim.cmd('wa')
      vim.notify('Saved all buffers', 3, { render = 'minimal' })
    end)

    vim.keymap.set('n', '<leader><leader>w', '<cmd>VimwikiIndex<CR>')
    vim.keymap.set('n', '<leader><leader>d', '<cmd>VimwikiDiaryIndex<CR>')

    -- 현재 라인의 끝에 '[-]'를 추가하거나 제거하는 함수
    local function Toggle_bracket()
        local cursor_pos = vim.api.nvim_win_get_cursor(0)
        local line_num = cursor_pos[1]
        local col_num = cursor_pos[2]

        local line = vim.api.nvim_get_current_line()

        if string.match(line, " %[%-%]$") then
            line = string.gsub(line, " %[%-%]$", "")
        else
            line = line .. " [-]"
        end

        vim.api.nvim_set_current_line(line)

        vim.api.nvim_win_set_cursor(0, {line_num, col_num})
    end

    vim.keymap.set('n', '<Space><Space>', Toggle_bracket)

  end
})

-- TODO: keymap:
-- 1. tab 및 S-tab 대신 <C-j> 및 <C-k>로 이동
-- 2. tab 및 S-tab은 기존 <C-CR> 및 <S-CR> 등 노트를 옆으로 펼치는 키로 활용하자.
-- 3. vimwiki에는 lualine 굳이 필요없다.
