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
  vim.fn.system("brave " .. search_url)

-- TODO::
-- 1. 한글은 인코딩해서 넣어야할듯?
-- 2. 띄어쓰기 포함되면 첫번째 부분만 검색된다.
end

-- Visual mode에서 사용할 키맵 설정
vim.api.nvim_set_keymap('v', '<leader>s', [[:lua SearchInChrome()<CR>]], { noremap = true, silent = true })


-- 최상위 git 디렉토리에서 live_grep 실행, 현재 vim session의 cwd가 git root dir이 아닌 경우도 있다. 이럴 때 유용함
-- ref:https://www.reddit.com/r/neovim/comments/106oz66/telescopenvim_live_grep_with_similar_behaviour_as/
--
-- function live_grep_git_dir()
--   local git_dir = vim.fn.system(string.format("git -C %s rev-parse --show-toplevel", vim.fn.expand("%:p:h")))
--   git_dir = string.gsub(git_dir, "\n", "") -- remove newline character from git_dir
--   local opts = {
--     cwd = git_dir,
--   }
--   require('telescope.builtin').live_grep(opts)
-- end
--
-- lvim.keys.normal_mode["<leader>gG"] = ":lua live_grep_git_dir()<CR>"
