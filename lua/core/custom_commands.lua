-- =========================================================================
-- =========================================================================
--                           general
-- =========================================================================
-- =========================================================================
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

function BlinkCursorLine()
  vim.cmd("highlight CursorLine guibg=#2CB67D")
  vim.wo.cursorline = true
  vim.defer_fn(function()
    vim.cmd("highlight CursorLine guibg=#3e4452")
    vim.wo.cursorline = false
  end, 50)
end

function ExpandGlow()
  vim.cmd([[
    Glow
    resize 999
    vertical resize 999'
  ]])
end

vim.cmd('command! GlowFull lua ExpandGlow()')

function Save_current_buffer_path()
  local path = vim.fn.expand('%:p:h') -- 현재 버퍼의 전체 경로 얻기
  vim.fn.setreg('+', path)            -- 클립보드에 경로 복사
  -- Notify('Saved current buffer path', 2, { render = 'minimal' })
end

-- 플로팅 윈도우로 포커스를 이동하는 Lua 함수
function FocusFloatingWindow()
  local wins = vim.api.nvim_list_wins()
  for _, win in ipairs(wins) do
    local config = vim.api.nvim_win_get_config(win)
    if config.focusable and config.relative ~= '' then
      vim.api.nvim_set_current_win(win)
      return
    end
  end
end

-- =========================================================================
-- =========================================================================
--                           Telescope
-- =========================================================================
-- =========================================================================
-- visual block만 서치하기
function TelescopeSearchVisual()
  local function getVisualText()
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

  local text = getVisualText()
  require('telescope.builtin').live_grep({ default_text = text })
end

-- =========================================================================
-- =========================================================================
--                           Shell command insdie Vim Buffer
-- =========================================================================
-- =========================================================================
function RunBufferWithSh()
  local temp_file = vim.fn.tempname()
  vim.api.nvim_command('silent! write! ' .. temp_file)
  vim.api.nvim_command('setlocal buftype=nofile')

  -- 현재 윈도우의 id와 우측 포커싱 후 id 확인
  local current_win = vim.api.nvim_get_current_win()
  vim.api.nvim_command('wincmd l')
  local new_win = vim.api.nvim_get_current_win()

  -- 포커스가 바뀌지 않았다면, 현재 우측 끝임
  if current_win == new_win then
    vim.api.nvim_command('vert belowright new')
  else
    vim.api.nvim_set_current_win(current_win)
    vim.api.nvim_command('wincmd l | new')
  end

  vim.api.nvim_command(
    [[r !date "+\%T" | awk '{line="=========================="; print line "\n===== time: " $1 " =====\n" line}']])
  vim.api.nvim_command('setlocal buftype=nofile | silent! read !sh ' .. temp_file)

  vim.fn.delete(temp_file)
  vim.api.nvim_set_current_win(current_win)
end

function RunBufferWithShCover()
  local temp_file = vim.fn.tempname()
  vim.api.nvim_command('silent! write! ' .. temp_file)
  vim.api.nvim_command('setlocal buftype=nofile')

  -- 현재 윈도우의 id와 우측 포커싱 후 id 확인
  local current_win = vim.api.nvim_get_current_win()
  vim.api.nvim_command('wincmd l')
  local new_win = vim.api.nvim_get_current_win()

  -- 포커스가 바뀌지 않았다면, 현재 우측 끝임
  if current_win == new_win then
    vim.api.nvim_command('vert belowright new')
  else
    vim.api.nvim_set_current_win(current_win)
    vim.api.nvim_command('wincmd l | %delete')
  end

  vim.api.nvim_command(
    [[r !date "+\%T" | awk '{line="=========================="; print line "\n===== time: " $1 " =====\n" line}']])
  vim.api.nvim_command('setlocal buftype=nofile | silent! read !sh ' .. temp_file)

  vim.api.nvim_set_current_win(current_win)
  vim.fn.delete(temp_file)
end

function RunSelectedLinesWithSh()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2]
  local end_line = end_pos[2]
  local temp_file = vim.fn.tempname()
  vim.api.nvim_command('silent! ' .. start_line .. ',' .. end_line .. 'write! ' .. temp_file)

  -- 현재 윈도우의 id와 우측 포커싱 후 id 확인
  local current_win = vim.api.nvim_get_current_win()
  vim.api.nvim_command('wincmd l')
  local new_win = vim.api.nvim_get_current_win()

  -- 포커스가 바뀌지 않았다면, 현재 우측 끝임
  if current_win == new_win then
    vim.api.nvim_command('vert belowright new')
  else
    vim.api.nvim_set_current_win(current_win)
    vim.api.nvim_command('wincmd l | new')
  end

  vim.api.nvim_command(
    [[r !date "+\%T" | awk '{line="=========================="; print line "\n===== time: " $1 " =====\n" line}']])
  vim.api.nvim_command('setlocal buftype=nofile | silent! read !sh ' .. temp_file)

  vim.api.nvim_set_current_win(current_win)
  vim.fn.delete(temp_file)
end

function RunSelectedLinesWithShCover()
  local start_pos = vim.fn.getpos("'<")
  local end_pos = vim.fn.getpos("'>")
  local start_line = start_pos[2]
  local end_line = end_pos[2]
  local temp_file = vim.fn.tempname()
  vim.api.nvim_command('silent! ' .. start_line .. ',' .. end_line .. 'write! ' .. temp_file)

  -- 현재 윈도우의 id와 우측 포커싱 후 id 확인
  local current_win = vim.api.nvim_get_current_win()
  vim.api.nvim_command('wincmd l')
  local new_win = vim.api.nvim_get_current_win()

  -- 포커스가 바뀌지 않았다면, 현재 우측 끝임
  if current_win == new_win then
    vim.api.nvim_command('vert belowright new')
  else
    vim.api.nvim_set_current_win(current_win)
    vim.api.nvim_command('wincmd l | %delete')
  end

  vim.api.nvim_command(
    [[r !date "+\%T" | awk '{line="=========================="; print line "\n===== time: " $1 " =====\n" line}']])
  vim.api.nvim_command('setlocal buftype=nofile | silent! read !sh ' .. temp_file)

  vim.api.nvim_set_current_win(current_win)
  vim.fn.delete(temp_file)
end

-- =========================================================================
-- =========================================================================
--                           Custom Tabline
-- =========================================================================
-- =========================================================================
-- 사용자 정의 tabline 함수   󱐋  
function MyTabLine()
  local s = ''
  -- local sep = '%#TabLineSelBorder#' -- 탭 구분자
  local sep = '%#TabLineSelBorder# ' -- 탭 구분자
  local max_width = 20               -- 탭의 최대 너비

  for i = 1, vim.fn.tabpagenr('$') do
    local tabname = vim.fn.gettabvar(i, 'tabname', 'Tab ' .. i)

    -- 탭 이름이 최대 너비보다 길 경우 잘라냄
    if #tabname > max_width then
      tabname = string.sub(tabname, 1, max_width - 3) .. '...'
    end

    -- 탭 이름을 가운데 정렬
    local padding = math.max(0, (max_width - #tabname) / 2)
    tabname = string.rep(' ', padding) .. tabname .. string.rep(' ', max_width - #tabname - padding)

    if i == vim.fn.tabpagenr() then
      -- active tab
      if tabname:find('GV') then
        s = s ..
            '%' .. i .. 'T' ..
            '%#TabLineGVBg#' ..
            '%#TabLineGVBg#' .. tabname .. '%#TabLineGVBorder#' .. '%#TabLineFill#'
      elseif tabname:find('sp:') or tabname:find('mv:') then
        s = s ..
            '%' .. i .. 'T' ..
            '%#TabLineTempBg#' ..
            '%#TabLineTempBg#' .. tabname .. '%#TabLineTempBorder#' .. '%#TabLineFill#'
      elseif tabname:find('Oil') then
        s = s ..
            '%' .. i .. 'T' ..
            '%#TabLineOilBg#' ..
            '%#TabLineOilBg#' .. tabname .. '%#TabLineOilBorder#' .. '%#TabLineFill#'
      else
        s = s ..
            '%' .. i .. 'T' ..
            '%#TabLineSelBg#' ..
            '%#TabLineSelBg#' .. tabname .. '%#TabLineSelBorder#' .. '%#TabLineFill#'
      end
    else
      -- inactive tab
      s = s .. '%' .. i .. 'T' .. '%#TabLineNotSel#' .. ' ' .. tabname .. ' '
    end

    if i < vim.fn.tabpagenr('$') + 1 then
      s = s .. sep
    end
  end

  s = s .. '%#TabLineFill#' .. '%='

  return s
end

-- tabline 설정
vim.o.tabline = '%!v:lua.MyTabLine()'

function NewTabWithPrompt()
  -- 입력 프롬프트 표시
  local tabname = vim.fn.input('Enter tab name: ')
  if tabname == '' then
    tabname = 'Tab ' .. vim.fn.tabpagenr('$') + 1
  end
  -- 새로운 탭 생성 및 이름 설정
  vim.cmd('tabnew')
  local tabnr = vim.fn.tabpagenr()
  vim.fn.settabvar(tabnr, 'tabname', tabname)
end

function RenameCurrentTab()
  -- 현재 탭 번호를 가져옵니다
  local tabnr = vim.fn.tabpagenr()

  -- 입력 프롬프트를 표시하여 새 탭 이름을 입력받습니다
  local tabname = vim.fn.input('Enter new tab name: ')
  if tabname == '' then
    tabname = 'Tab ' .. tabnr
  end

  -- 현재 탭의 이름을 설정합니다
  vim.fn.settabvar(tabnr, 'tabname', tabname)
  -- 탭라인을 업데이트합니다
  vim.cmd('redrawtabline')
end

function MoveTabLeft()
  local current_tab = vim.fn.tabpagenr()
  if current_tab == 1 then
    vim.cmd('tabmove $')
  elseif
      current_tab > 1 then
    vim.cmd('tabmove ' .. (current_tab - 2))
  end
end

function MoveTabRight()
  local current_tab = vim.fn.tabpagenr()
  local total_tabs = vim.fn.tabpagenr('$')
  if current_tab < total_tabs then
    vim.cmd('tabmove ' .. current_tab + 1)
  else
    vim.cmd('tabmove 0')
  end
end

-- 현재 탭 내에서 현재 버퍼만 남기기
function OnlyThisBufferInCurrentTab()
  local current_buf = vim.fn.bufnr('%')
  for _, buf in ipairs(vim.fn.tabpagebuflist()) do
    if buf ~= current_buf then
      vim.cmd('bdelete! ' .. buf)
    end
  end
end

function _G.close_FT_buffers(FT)
  for _, buf in ipairs(vim.api.nvim_list_bufs()) do
    if vim.api.nvim_buf_is_loaded(buf) then
      local filetype = vim.api.nvim_buf_get_option(buf, 'filetype')
      if filetype == FT then
        vim.api.nvim_buf_delete(buf, { force = true })
      end
    end
  end
end

-- 모든 탭 내에서 현재 버퍼만 남기기
-- :%bdelete|edit#|bdelete#
