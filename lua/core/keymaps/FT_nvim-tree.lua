vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    -- load resource
    local api = require('nvim-tree.api')

    -- gui

    -- keymap
    vim.keymap.set({ 'n', 'v' }, 'gq', function()
      api.tree.close_in_this_tab()
    end , { buffer = true })
  end
})

-- TODO: 이 파일(lua/core/auto_commands.lua)에 관련 auto_commands가 모여있다. 이것을 여기로 합치자.
