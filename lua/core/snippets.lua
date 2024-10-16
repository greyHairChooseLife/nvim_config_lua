-- TODO: 스니펫은 아무래도 ,,로 시작해서 2개 캐릭터 정도로 좁히는게 적절할듯? 통일하자.

-- 날짜 찍기
vim.keymap.set('i', ',d', function()
  local result = vim.fn.system('date "+%Y-%m-%d"')
  result = result:gsub("\n$", "")
  vim.api.nvim_put({ result }, 'c', false, true)
end, { noremap = true, silent = true })
vim.keymap.set('i', ',D', function() -- 2024. 06. 11. (화) 17:52:17 KST
  local result = vim.fn.system('date')
  result = result:gsub("\n$", "")
  vim.api.nvim_put({ result }, 'c', false, true)
end, { noremap = true, silent = true })


-- SNIPPET 주석: [ TODO / NOTE / WARN / BUG ]
--     
vim.keymap.set('i', ',,T', function()
  vim.api.nvim_feedkeys("TODO:", "n", true)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
  vim.defer_fn(function()
    vim.cmd("lua require('Comment.api').toggle.linewise.current()")
    vim.api.nvim_feedkeys("A", "n", true)
  end, 1) -- 최소한의 딜레이
end)
vim.keymap.set('i', ',,P', function()
  vim.api.nvim_feedkeys("PSEUDO_CODE:: ", "n", true)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
  vim.defer_fn(function()
    vim.cmd("lua require('Comment.api').toggle.linewise.current()")
    vim.api.nvim_feedkeys("A", "n", true)
  end, 1) -- 최소한의 딜레이
end)
vim.keymap.set('i', ',,N', function()
  vim.api.nvim_feedkeys("NOTE:", "n", true)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
  vim.defer_fn(function()
    vim.cmd("lua require('Comment.api').toggle.linewise.current()")
    vim.api.nvim_feedkeys("A", "n", true)
  end, 1) -- 최소한의 딜레이
end)
vim.keymap.set('i', ',,W', function()
  vim.api.nvim_feedkeys("WARN:", "n", true)
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
  vim.defer_fn(function()
    vim.cmd("lua require('Comment.api').toggle.linewise.current()")
    vim.api.nvim_feedkeys("A", "n", true)
  end, 1) -- 최소한의 딜레이
end)
-- vim.keymap.set('i', ',,D', function()
--   vim.api.nvim_feedkeys("DEBUG:", "n", true)
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
--   vim.defer_fn(function()
--     vim.cmd("lua require('Comment.api').toggle.linewise.current()")
--     vim.api.nvim_feedkeys("A", "n", true)
--   end, 1) -- 최소한의 딜레이
-- end)
-- vim.keymap.set('i', ',,D', function()
--   -- 첫 번째 DEBUG: 삽입
--   vim.api.nvim_feedkeys(" Start  DEBUG:", "n", true)
--
--   -- ESC를 눌러 insert 모드에서 나옴
--   vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
--
--   -- 첫 번째 줄을 주석 처리
--   vim.defer_fn(function()
--     vim.cmd("lua require('Comment.api').toggle.linewise.current()")
--   end, 1) -- 첫 번째 줄 주석 처리 후 딜레이
-- end)


vim.keymap.set('i', ',,D', function()
  -- 두 줄의 DEBUG: 삽입
  vim.api.nvim_feedkeys("START_debug:\nEND___debug:", "n", true)

  -- ESC를 눌러 insert 모드에서 나옴
  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)

  -- 두 줄을 모두 주석 처리
  vim.defer_fn(function()
    -- 현재 커서 위치에서 두 줄을 주석 처리
    vim.cmd("normal! k")                                           -- 한 줄 위로 이동
    vim.cmd("lua require('Comment.api').toggle.linewise.count(2)") -- 두 줄 주석 처리

    -- 커서를 insert 모드로 복귀시키고 커서 위치 설정
    vim.api.nvim_feedkeys("o", "n", true)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, true, true), "n", true)
    vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("cc", true, true, true), "n", true)
  end, 10) -- 두 줄 삽입 후 딜레이
end)


-- console.log
function Insert_console_log()
  local file_path = vim.fn.expand('%:~:.') -- 상대경로
  local line_number = vim.fn.line('.')
  -- local log_message = string.format("console.log('File: %s, Line: %d \\n', );", file_path, line_number)
  local log_message = string.format("console.log();", file_path, line_number)

  -- 현재 커서 위치 가져오기
  local current_pos = vim.api.nvim_win_get_cursor(0)

  -- 메시지 삽입
  vim.api.nvim_put({ log_message }, 'c', true, true)

  -- 커서 위치를 ',' 뒤의 다음 줄로 이동
  vim.api.nvim_win_set_cursor(0, { current_pos[1], current_pos[2] + #log_message - 2 })
end

-- NOTE: 이건 글로벌 함수로 만들어서 다양한 커스텀 함수에서 활용할 수 있을듯?

-- 비주얼 모드에서 선택한 텍스트 가져오기
local function get_visual_selection()
  local _, csrow, cscol, _ = unpack(vim.fn.getpos("'<"))
  local _, cerow, cecol, _ = unpack(vim.fn.getpos("'>"))
  if csrow == cerow then
    return string.sub(vim.fn.getline(csrow), cscol, cecol)
  else
    local lines = vim.fn.getline(csrow, cerow)
    lines[1] = string.sub(lines[1], cscol, -1)
    lines[#lines] = string.sub(lines[#lines], 1, cecol)
    return table.concat(lines, '\n')
  end
end

-- console.log visual
function Insert_console_log_Visual()
  local file_path = vim.fn.expand('%:~:.') -- 상대경로
  local line_number = vim.fn.line('.')

  -- 비주얼 모드에서 선택된 텍스트 가져오기
  local visual_selection = get_visual_selection()

  -- `console.log` 메시지 생성
  local log_message = string.format("console.log('File: %s, Line: %d \\n', '%s: ', %s);", file_path, line_number,
    visual_selection, visual_selection)

  -- 현재 커서 위치 가져오기
  local current_pos = vim.api.nvim_win_get_cursor(0)

  -- 비주얼 모드 종료
  vim.api.nvim_input('<Esc>')

  -- 비주얼 모드에서 선택한 텍스트 뒤에 메시지 삽입
  vim.api.nvim_put({ log_message }, 'l', true, true)

  -- 커서 위치를 선택한 텍스트 뒤의 ',' 뒤로 이동하고 인서트 모드로 전환
  local new_row = current_pos[1] + 1
  local new_col = #log_message - 2 -- ); 앞의 위치로 이동
  vim.api.nvim_win_set_cursor(0, { new_row, new_col })
  vim.api.nvim_input('i')
end
