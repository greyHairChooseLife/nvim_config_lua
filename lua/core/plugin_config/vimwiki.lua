-- vim.g.vimwiki_list = {
--   {
--     path = "~/wiki/",
--     syntax = "markdown",
--     ext = ".md"
--   }
-- }
--
-- vim.g.vimwiki_conceallevel = 0

-- 문제 해결: vimwiki 설정이 markdown 설정을 침투하지 않게 하기
vim.g.vimwiki_global_ext = 0


vim.g.vimwiki_list = {
  {
    path = "~/Documents/dev-wiki/notes/",
    -- path_html = "~/Documents/vimwiki/",
    syntax = "markdown",
    ext = ".md",
  },
  {
    path = "~/Documents/job-wiki/notes/",
    syntax = "markdown",
    ext = ".md",
  }
}

vim.cmd [[
  " 헤더 색상 설정
  highlight VimwikiHeader1 guifg=#ffffff guibg=#007F7F gui=bold
  highlight VimwikiHeader2 guifg=#5169E1 gui=bold,underline
  highlight VimwikiHeader3 guifg=#7aa2f7 gui=bold,underline
  highlight VimwikiHeader4 guifg=#7aa2f7 gui=underline
  highlight VimwikiHeader5 guifg=#7aa2f7 gui=underline
  highlight VimwikiHeader6 gui=underline

  " 링크 색상 설정
  highlight VimwikiLink guifg=#FFFF00

  " 리스트 항목 색상 설정
  highlight VimwikiList gui=italic

  " 코드 블록 색상 설정
  highlight VimwikiCode guibg=#5F5F5F guifg=#ffffff

  " 강조 텍스트 색상 설정
  highlight VimwikiBold guifg=#DCDCAA gui=bold
  highlight VimwikiItalic guifg=#DCDCAA gui=italic

  " ToDo 항목 색상 설정
  highlight VimwikiTodo guifg=#000000 guibg=#87CEFA gui=bold
]]

-- #2CB67D   #98C379   #A1C98A
--
-- #37D060   #2F8132   #1E5631
--
-- #569CD6   #D16969   #2E2E2E
--
-- #DCDCAA   #6A9955   #FF4500
--
-- #FF8C00   #32CD32   #FEAEAE
--
-- #1E5631   #2F8132   #37D060   #98C379   #2CB67D   #A1C98A
--
-- #004F4F   #007F7F   #00FFFF   #8FBC8F   #5F9EA0   #A0D9D9
--
-- #2F2F2F   #5F5F5F   #9F9F9F   #D3D3D3   #FFFFFF   #E0E0E0
--
-- #800000   #FF0000   #FFA500   #FFFF00   #808000   #BDB76B
--
-- #000080   #0000FF   #4169E1   #87CEFA   #ADD8E6   #B0C4DE
