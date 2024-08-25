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
}


-- 함수를 전역으로 등록
_G.vimwiki_fold_level_custom = function(lnum)
  -- local prev_line = vim.fn.getline(lnum - 1) -- render-markdown에서 header border를 사용하지 않을 경우 -1로 변경
  local prev_line = vim.fn.getline(lnum - 2)
  local line = vim.fn.getline(lnum)
  local next_line = vim.fn.getline(lnum + 1)

  -- 헤더를 찾음
  local pounds = string.match(prev_line, "^##+")

  if pounds then
    return '>' .. #pounds -- 헤더에 따라 폴딩 레벨을 설정
  end

  -- 헤더 바로 전 빈 줄을 폴딩하지 않음
  if string.match(line, "^%s*$") and string.match(next_line, "^##+") then
    return '0' -- 이 라인은 폴딩하지 않음
  end

  -- 기본적으로 현재 폴딩 레벨 유지
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

-- TODO: "Vimwiki Shift+Return, Ctrl+Return not working."
-- https://www.reddit.com/r/vim/comments/7xoe8b/vimwiki_shiftreturn_ctrlreturn_not_working/
-- TODO: 파일 주소의 '공백'을 다른것으로 대체 가능한 것으로 봤다. 즉, 공백이 포함된 링크도 ui적용이 가능하단 소리.
-- TODO: 편의기능 개선
-- <C-k>로 웹링크를 손쉽게 만들 수 있다. 근데 사실 링크로 삼을 텍스트를 선택하고 이후 cmd에 주소를 입력하는것보단, 주소를 복사해와서 buffer에 붙여넣은 뒤, 이것을 visually select해서 <C-k>를 누르는게 더 효율적이다.
-- 이는 visual모드로 실행하는지, normal모드로 실행하는지에 따라 각각 동작하게 하면 될듯.
-- 또한, 이외에도 static file의 주소를 가져온 뒤 손쉽게 하이퍼링크를 만들어주는 것도 해주자. 그림파일인지는 확장자를 통해 판단하면 되니 모든 종류의 스태틱 파일에 동일한 커맨드를 사용가능할듯.

-- NOTE:: ALTERNATIVE LIST
-- ..
-- https://www.reddit.com/r/neovim/comments/10ulqji/note_taking_options/
-- I cant recommend any specific plugin but I can give you a list of available note/wiki/org-plugins:
-- *anki
-- *arachne
-- *dotoo
-- *flashcards
-- *kb-notes
-- *linny
-- *mind
-- *nabla
-- *neorg
-- *neuron.nvim
-- *neuron.vim
-- *obsidian
-- *orgmode.nvim
-- *orgmode
-- *orgwiki
-- *riv
-- *samwise
-- *scribe
-- *todotxt
-- *vimwiki
-- *wiki
-- *YANP
-- *zettelkasten
-- *zk
