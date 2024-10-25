vim.api.nvim_create_autocmd("FileType", {
  pattern = "oil",
  callback = function()
    -- gui

   -- OilBufferHighlight 그룹 정의 (배경색을 바꾸고 싶을 때)
    vim.api.nvim_set_hl(0, "OilBufferHighlight", { bg = "#1A1601" })  -- 원하는 색상으로 변경
    -- OilBufferHighlight를 전체 배경에 적용
    vim.cmd("setlocal winhighlight=Normal:OilBufferHighlight")
  end
})

