vim.api.nvim_create_autocmd({ 'BufEnter' }, {
  pattern = 'NvimTree',
  callback = function()
    local api = require('nvim-tree.api')
    local view = require('nvim-tree.view')

    -- gui
    if not view.is_visible() then
      api.tree.open()
    end
  end,
})

vim.api.nvim_create_autocmd("BufReadPost", {
  pattern = "*",
  callback = function()
    vim.cmd("normal! zR")
    vim.cmd("silent! loadview")

    -- 마지막 커서 위치로 이동
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    if mark[1] > 0 and mark[1] <= vim.fn.line("$") then
      vim.api.nvim_win_set_cursor(0, mark)
    end
  end,
})

-- markdown은 108자로 자동 줄바꿈
vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    -- vim.bo.textwidth = 108 -- 이놈은 실제로 줄바꿈을 해버린다. 파일 내용이 바뀐다!
    -- goyo, zen-mode를 사용하자
  end
})

-- highlight yanked area
vim.api.nvim_create_autocmd('TextYankPost', {
  pattern = '*',
  callback = function()
    vim.highlight.on_yank { higroup = 'Sneak', timeout = 100 }
  end,
})

-- 파일 저장시 공백 제거
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    -- 현재 파일의 파일 타입을 가져옵니다.
    local filetype = vim.bo.filetype

    -- 만약 파일 타입이 markdown이면 공백 제거를 하지 않습니다.
    if filetype == "markdown" then
      return
    end

    -- 제거 로직
    local pos = vim.api.nvim_win_get_cursor(0)
    vim.cmd([[%s/\s\+$//e]])
    vim.api.nvim_win_set_cursor(0, pos)
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

-- -- 명령 입력 시 cmdheight를 1로 설정
-- vim.api.nvim_create_autocmd("CmdlineEnter", {
--   callback = function()
--     vim.opt.cmdheight = 1
--   end,
-- })
--
-- -- 명령 입력 종료 시 cmdheight를 0으로 설정
-- vim.api.nvim_create_autocmd("CmdlineLeave", {
--   callback = function()
--     vim.opt.cmdheight = 0
--   end,
-- })
