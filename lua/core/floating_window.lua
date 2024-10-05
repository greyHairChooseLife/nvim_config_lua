-- Autocommand 그룹 생성 (중복 방지)
local float_win_group = vim.api.nvim_create_augroup("FloatWinSettings", { clear = true })

-- WinEnter 이벤트에 대한 Autocommand 생성
vim.api.nvim_create_autocmd("WinEnter", {
  group = float_win_group,
  callback = function()
    local win = vim.api.nvim_get_current_win()
    local config = vim.api.nvim_win_get_config(win)

    -- 플로팅 윈도우는 'relative' 필드가 비어있지 않음
    if config.relative ~= "" then
      -- 플로팅 윈도우에만 적용할 키맵 설정
      vim.keymap.set({ 'n', 'v' }, 'gq', '<cmd>quit<CR>', { buffer = true, silent = true })

      -- 추가 옵션 설정 (예: 텍스트 너비 조정)
      -- vim.bo.textwidth = 80

    else
      -- 플로팅 윈도우가 아닐 경우, 필요하다면 키맵을 제거하거나 기본 설정으로 복원
      --
      -- 예: 특정 키맵을 해제
      -- vim.keymap.del('n', 'PP', { buffer = true })
      -- vim.keymap.del('v', 'i', { buffer = true })
      -- vim.keymap.del('v', 'a', { buffer = true })

      -- 추가 옵션 복원
      -- vim.bo.textwidth = 0
    end
  end,
})
