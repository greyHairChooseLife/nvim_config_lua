local M = {}

local virtual_text_enabled = true

function ToggleVirtualText()
	virtual_text_enabled = not virtual_text_enabled
	vim.diagnostic.config({
		virtual_text = virtual_text_enabled,
		underline = true,
		signs = false, -- sign column에 아이콘 표시
		update_in_insert = false, -- 입력 모드 중 업데이트 비활성화
		severity_sort = true, -- 심각도에 따라 정렬
	})
end

M.virtual_text_enabled = virtual_text_enabled
M.ToggleVirtualText = ToggleVirtualText

return M
