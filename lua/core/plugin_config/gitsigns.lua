require('gitsigns').setup({
  update_debounce = 10,
  watch_gitdir = {
    follow_files = true
  },
  auto_attach = true,
  attach_to_untracked = true,
  sign_priority = 15,

  signs = {
    add          = { text = '+' },
    change       = { text = '~' },
    delete       = { text = '_' },
    topdelete    = { text = '‾' },
    changedelete = { text = '~' },
    untracked    = { text = '?' },
  },
  signs_staged_enable = true,
  signs_staged = {
    add          = { hl = 'GitSignsAdd', text = '✔' },
    change       = { hl = 'GitSignsChange', text = '✔' },
    delete       = { hl = 'GitSignsChangedelete', text = '✔' },
    topdelete    = { hl = 'GitSignsDelete', text = '✔' },
    changedelete = { hl = 'GitSignsTopdelete', text = '✔' },
    untracked    = { hl = 'GitSignsUntracked', text = '✔' }
  },
  on_attach = function()
    local gs = package.loaded.gitsigns

    -- Git 상태 변경 후 nvim-tree 갱신
    vim.api.nvim_create_autocmd("User", {
      pattern = "GitSignsUpdate",
      callback = function()
        require('nvim-tree.api').tree.reload()
      end,
    })

    vim.keymap.set("n", "]c", function()
      gs.nav_hunk('next', { target = 'all' })
    end, { noremap = true, silent = true })
    vim.keymap.set("n", "[c", function()
      gs.nav_hunk('prev', { target = 'all' })
    end, { noremap = true, silent = true })
  end
})

-- 이게 왜 필요했더라?
-- 하여튼 지금은 lualine disabled 일 때 방해되니까 꺼버린다.
-- vim.cmd "set statusline+={get(b:,'gitsigns_statusline',')}"


-- =========================================================================
-- =========================================================================
--                          Custom Commands
-- =========================================================================
-- =========================================================================
function Visual_stage()
  local first_line = vim.fn.line('v')
  local last_line = vim.fn.getpos('.')[2]
  require('gitsigns').stage_hunk({ first_line, last_line })
  -- Switch back to normal mode, there may be a cleaner way to do this
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 't', false)
end

function Visual_undo_stage()
  local first_line = vim.fn.line('v')
  local last_line = vim.fn.getpos('.')[2]
  require('gitsigns').undo_stage_hunk({ first_line, last_line })
  -- Switch back to normal mode, there may be a cleaner way to do this
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 't', false)
end

function Visual_reset()
  local first_line = vim.fn.line('v')
  local last_line = vim.fn.getpos('.')[2]
  require('gitsigns').reset_hunk({ first_line, last_line })
  -- Switch back to normal mode, there may be a cleaner way to do this
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes('<Esc>', true, false, true), 't', false)
end
