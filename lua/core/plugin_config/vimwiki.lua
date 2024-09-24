-- 문제 해결: vimwiki 설정이 markdown 설정을 침투하지 않게 하기
vim.g.vimwiki_global_ext = 0

vim.g.vimwiki_list = {
  {
    path = "~/Documents/dev-wiki/notes/",
    -- path_html = "~/Documents/vimwiki/",
    syntax = "markdown",
    ext = ".md",
    links_space_char = "_", -- link에 띄어쓰기를 알아서 '_'로 바꿔줌
  },
  {
    path = "~/Documents/job-wiki/notes/",
    syntax = "markdown",
    ext = ".md",
    links_space_char = "_",
  }
}

vim.g.vimwiki_key_mappings = {
  global = 0,
  lists = 0,
  links = 0,
}

vim.g.vimwiki_create_link = 0


-- 함수를 전역으로 등록
_G.vimwiki_fold_level_custom = function(lnum)
  local prev_line = vim.fn.getline(lnum - 1)  -- 헤더라인은 살려야지
  local curr_line = vim.fn.getline(lnum)
  local next_line = vim.fn.getline(lnum + 1)
  local last_line = vim.fn.line('$')

  local is_lv2_header = string.match(prev_line, "^##%s")
  local is_lv3_header = string.match(prev_line, "^###%s")

  if is_lv2_header then return '1' end
  if is_lv3_header then return '2' end
  if string.match(curr_line, "^%s*$") and string.match(next_line, "^###%s") then return '1' end
  if curr_line == last_line or string.match(curr_line, "^%s*$") and string.match(next_line, "^##%s") then return '0' end

  -- 무엇에도 해당하지 않는 경우 prev_line의 foldlevel을 그대로 사용
  return '='
end

-- Vimwiki의 폴딩 방식을 'custom'으로 설정
vim.g.vimwiki_folding = 'custom'

-- autocmd를 Lua 방식으로 설정
vim.api.nvim_create_augroup("VimwikiFoldingGroup", { clear = true })

vim.api.nvim_create_autocmd("FileType", {
  group = "VimwikiFoldingGroup",
  pattern = "vimwiki",
  callback = function()
    vim.opt_local.foldmethod = 'expr'
    vim.opt_local.foldenable = true
    vim.opt_local.foldexpr = 'v:lua.vimwiki_fold_level_custom(v:lnum)'
    vim.opt_local.foldtext = 'v:lua.custom_fold_text()'
  end,
})

-- custom_fold_text 함수 정의
function custom_fold_text()
  local line_count = vim.v.foldend - vim.v.foldstart + 1
  local fold_text = " 󱞪 " .. line_count .. " "

  -- 현재 윈도우의 너비를 가져와 남은 공간을 공백으로 채움
  local win_width = vim.fn.winwidth(0)
  local padding = string.rep(" ", win_width - #fold_text)

  return fold_text .. padding
end

-- TODO: 편의기능 개선
-- 또한, 이외에도 static file의 주소를 가져온 뒤 손쉽게 하이퍼링크를 만들어주는 것도 해주자. 그림파일인지는 확장자를 통해 판단하면 되니 모든 종류의 스태틱 파일에 동일한 커맨드를 사용가능할듯.
