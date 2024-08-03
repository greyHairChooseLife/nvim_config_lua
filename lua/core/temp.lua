-- Visual mode에서 선택한 텍스트를 구글 크롬으로 검색하는 함수
function SearchInChrome()
  local function getVisualText()
    -- Visual mode에서 선택한 텍스트의 시작과 끝 위치 가져오기
    local vstart = vim.fn.getpos("'<")
    local vend = vim.fn.getpos("'>")

    local line_start = vstart[2]
    local line_end = vend[2]
    local col_start = vstart[3]
    local col_end = vend[3]

    -- 라인 범위 가져오기
    local lines = vim.fn.getline(line_start, line_end)

    -- 첫 줄과 마지막 줄의 부분 선택 영역만 가져오기
    if #lines == 1 then
      lines[1] = string.sub(lines[1], col_start, col_end)
    else
      lines[1] = string.sub(lines[1], col_start)
      lines[#lines] = string.sub(lines[#lines], 1, col_end)
    end

    -- 라인들을 합쳐서 하나의 문자열로 만들기
    local text = table.concat(lines, "\n")
    return text
  end

  local text = getVisualText()

  if text == '' then
    print("No text selected!")
    return
  end

  -- 구글 검색 URL 생성
  local search_url = "--app=https://www.google.com/search?q=" .. text

  -- 검색 URL 출력 (디버깅용)
  print('Search URL: ', search_url)

  -- 구글 크롬으로 검색
  vim.fn.system("google-chrome " .. search_url)
end

-- Visual mode에서 사용할 키맵 설정
vim.api.nvim_set_keymap('v', '<leader>s', [[:lua SearchInChrome()<CR>]], { noremap = true, silent = true })
