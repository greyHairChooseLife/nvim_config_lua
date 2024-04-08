function ShowCursor()
  if vim.o.cursorline then
    vim.o.cursorline = false
    vim.o.cursorcolumn = false
    vim.o.relativenumber = false
  else
    vim.o.cursorline = true
    vim.o.cursorcolumn = true
    vim.o.relativenumber = true
    vim.cmd([[
        highlight CursorColumn guifg=white guibg=#AB82A5
        highlight CursorLine guifg=white guibg=#AB82A5
      ]])
  end
end

vim.cmd('command! ShowCursor lua ShowCursor()')

function ExpandGlow()
  vim.cmd([[
    Glow
    resize 999
    vertical resize 999'
  ]])
end

vim.cmd('command! GlowFull lua ExpandGlow()')

-- Quickfix 항목 제거 함수 정의
function RemoveQFItem()
  local curqfidx = vim.fn.line('.') - 1
  local qfall = vim.fn.getqflist()
  if #qfall == 1 then
    vim.fn.setqflist({}, 'r')
    vim.api.nvim_command('cclose')
    vim.api.nvim_echo({ { "Good job, Quickfix list cleared!!", "MoreMsg" } }, false, {})
  else
    table.remove(qfall, curqfidx + 1) -- Lua에서 table 인덱스는 1부터 시작함에 주의
    vim.fn.setqflist(qfall, 'r')
    if curqfidx < #qfall then
      vim.api.nvim_command(tostring(curqfidx) .. "cfirst")
    else
      vim.api.nvim_command(tostring(#qfall) .. "cfirst")
    end
    if #qfall == 0 then
      vim.api.nvim_command('cclose')
      vim.api.nvim_echo({ { "Quickfix list cleared", "MoreMsg" } }, false, {})
    else
      vim.api.nvim_command('copen')
    end
  end
end

vim.cmd [[
  autocmd FileType qf nnoremap <buffer> dd :lua RemoveQFItem()<CR>
]]

-- Quickfix list clear all 함수 정의
function ClearQFList()
  vim.fn.setqflist({}, 'r')
  vim.api.nvim_command('cclose')
  vim.api.nvim_echo({ { "Quickfix list cleared", "MoreMsg" } }, false, {})
end

vim.cmd [[
  autocmd FileType qf nnoremap <buffer> DD :lua ClearQFList()<CR>
]]

-- Quickfix list toggle 함수 정의
function ToggleQFList()
  -- Quickfix 창이 열려있는지 확인
  local is_open = false
  for _, win in pairs(vim.fn.getwininfo()) do
    if win.quickfix == 1 then
      is_open = true
      break
    end
  end

  if is_open then
    vim.api.nvim_command('cclose')
  else
    vim.api.nvim_command('copen')
  end
end

vim.api.nvim_set_keymap('n', ',,q', ':lua ToggleQFList()<CR>', { noremap = true, silent = true })

-- Quickfix 리스트 순환 이동
vim.keymap.set('n', '<C-n>', function()
  local qf_list = vim.fn.getqflist()
  if #qf_list == 0 then return end -- Quickfix 리스트가 비어있는 경우 아무 동작도 하지 않음
  local qf_info = vim.fn.getqflist({ idx = 0 })
  local qf_index = qf_info.idx
  if qf_index == #qf_list then
    vim.cmd('cfirst')
  else
    vim.cmd('cnext')
  end
end, { silent = true, noremap = true })

-- Quickfix 리스트 순환 이동
vim.keymap.set('n', '<C-p>', function()
  local qf_list = vim.fn.getqflist()
  if #qf_list == 0 then return end -- Quickfix 리스트가 비어있는 경우 아무 동작도 하지 않음
  local qf_info = vim.fn.getqflist({ idx = 0 })
  local qf_index = qf_info.idx
  if qf_index == 1 then
    vim.cmd('clast')
  else
    vim.cmd('cprev')
  end
end, { silent = true, noremap = true })

-- Quickfix 윈도우 설정
vim.api.nvim_create_autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.api.nvim_command("wincmd L")
    vim.api.nvim_win_set_width(0, 100)
    vim.wo.cursorline = true
  end
})

-- telescope custom commands, visual select search
function vim.getVisualSelection()
  vim.cmd('noau normal! "vy"')
  local text = vim.fn.getreg('v')
  vim.fn.setreg('v', {})

  text = string.gsub(text, "\n", "")
  if #text > 0 then
    return text
  else
    return ''
  end
end

vim.keymap.set('v', ',.c', function()
  local text = vim.getVisualSelection()
  require('telescope.builtin').live_grep({ default_text = text })
end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd("FileType", {
  pattern = "markdown",
  callback = function()
    vim.api.nvim_buf_set_keymap(0, 'n', 'PP', '<cmd>MarkdownPreviewToggle<CR>', { noremap = true, silent = true })

    -- 아래와 같이 시도했으나, 넘 복잡해서인지 잘 안된다. 그냥 antonk52/markdowny.nvim 플러그인을 아래 코드라인처럼 수정했다.

    -- -- surround visual block with '=='
    -- vim.api.nvim_buf_set_keymap(0, 'v', '<C-d>', '<Esc>`>a\\~\\~\'<Esc>`<i\\~\\~\'<Esc>E', {noremap = true, silent = true})

    -- antonk52/markdowny.nvim
    -- function M.mark()
    --   inline_surround('==', '==')
    -- end
    --
    -- function M.tilde()
    --   inline_surround('~~', '~~')
    -- end
    -- vim.keymap.set('v', '<C-d>', ":lua require('markdowny').tilde()<cr>", { buffer = 0, silent = true })
    -- vim.keymap.set('v', '<C-h>', ":lua require('markdowny').mark()<cr>", { buffer = 0, silent = true })
  end,
})

function RunBufferWithSh()
  local temp_file = vim.fn.tempname()
  vim.api.nvim_command('write! ' .. temp_file)
  vim.api.nvim_command('setlocal buftype=nofile')
  vim.api.nvim_command('new | setlocal buftype=nofile | read !sh ' .. temp_file)
  vim.fn.delete(temp_file)
end

function RunSelectedLinesWithSh()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2]
  local end_line = end_pos[2]
  local temp_file = vim.fn.tempname()
  vim.api.nvim_command(start_line .. ',' .. end_line .. 'write! ' .. temp_file)
  vim.api.nvim_command('new | setlocal buftype=nofile | read !sh ' .. temp_file)
  vim.fn.delete(temp_file)
end

vim.api.nvim_set_keymap('n', ',R', ':lua RunBufferWithSh()<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('v', ',R', ':lua RunSelectedLinesWithSh()<CR>', { noremap = true, silent = true })
