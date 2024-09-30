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
    -- vim.bo.textwidth = 108
    -- goyo, zen-mode를 사용하자
  end
})

-- highlight yanked area
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank { higroup = 'Sneak', timeout = 100 }
  end,
  pattern = '*',
})

-- 마지막 커서 위치로 이동
vim.api.nvim_create_autocmd("BufReadPost", {
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.fn.line("$") then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- 파일 저장시 공백 제거
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
  end,
})


-- 파일 열면 loadview
vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.cmd("silent! loadview")
  end,
})


-- WARN:  나는 자동완성으로 nvim-cmp가 아니라 coc을 쓰니까 coc-settings.json에 관련 설정을 추가해야한다.
-- -- sql파일 열면 자동완성에 vim-dadbod-completion 추가
-- local cmp = require "cmp"
-- cmp.setup.filetype({ "sql" }, {
--   sources = {
--     { name = "vim-dadbod-completion" },
--     { name = "buffer" },
--   },
-- })

-- SQL 파일 타입에 대해 vim-dadbod-completion.vim을 소스하는 설정
vim.api.nvim_create_autocmd('FileType', {
  pattern = 'sql',
  callback = function()
    vim.cmd('source ~/.config/nvim/plugged/vim-dadbod-completion/plugin/vim-dadbod-completion.vim')
  end
})

vim.api.nvim_create_augroup('GV', { clear = true })

-- GV에 탭이름 변경
vim.api.nvim_create_autocmd('FileType', {
  group = 'GV',
  pattern = 'GV',
  callback = function()
    local tabnr = vim.fn.tabpagenr()
    vim.fn.settabvar(tabnr, 'tabname', 'GV')
  end,
})
