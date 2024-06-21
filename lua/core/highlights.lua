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




vim.cmd("highlight LineNr guifg=#9ece6a ctermfg=red")
vim.cmd("highlight TabLine gui=bold guibg=black")
vim.cmd("highlight TabLineFill guibg=#24283b")
vim.cmd("highlight TabLineSel guibg=#98c379")
vim.cmd("highlight TabLine guifg=lightgrey")
vim.cmd("highlight Search guibg=#9ece6a guifg=#1d202f")
vim.cmd("highlight CurSearch gui=bold guibg=#1d3c9c guifg=white")
vim.cmd("highlight Visual guibg=#283b4d")

vim.cmd([[:highlight CustomSignsAdd guifg=#1abc9c]])
vim.cmd([[:highlight CustomSignsAddBg guibg=#afccc7]])
vim.cmd([[:highlight CustomSignsChange guifg=#ff007c]])
vim.cmd([[:highlight CustomSignsChangeBg guibg=#e0af68]])
vim.cmd([[:highlight CustomSignsDelete guifg=#e06c75]])
vim.cmd([[:highlight CustomSignsDeleteBg guibg=#e06c75]])

vim.cmd("highlight OutlineCurrent guifg=#e5c07b guibg=#3e4452")
vim.cmd("highlight MyOutlineNormal guibg=#2e2e2e")

vim.cmd [[
  highlight fugitiveUntrackedHeading guifg=#7f52ff gui=bold
  highlight fugitiveUnstagedHeading guifg=#f1502f gui=bold
  highlight fugitiveStagedHeading guifg=#50cd5a gui=bold
]]

vim.cmd("highlight OutlineNormal guifg=#a9b1d6 guibg=#1f2335")
vim.cmd("highlight OutlineCurrent guifg=#1d202f guibg=#9ece6a")

vim.cmd [[
  highlight NvimTreeFolderIcon guifg=#569CD6
  highlight NvimTreeFolderName guifg=#569CD6
  highlight NvimTreeOpenedFolderName guifg=#569CD6 gui=bold
  highlight NvimTreeEmptyFolderName guifg=#569CD6
  highlight NvimTreeSymlink guifg=#56B6C2
  highlight NvimTreeRootFolder guifg=#C678DD
  highlight NvimTreeGitDirty guifg=#f1502f
  highlight NvimTreeGitStagedIcon guifg=#50cd5a
  " highlight NvimTreeGitMerge guifg=#E5C07B
  highlight NvimTreeGitRenamed guifg=#61AFEF
  " highlight NvimTreeGitNew guifg=#D19A66
  highlight NvimTreeGitNew guifg=#7f52ff
  highlight NvimTreeGitDeleted guifg=#f1502f
  highlight NvimTreeGitIgnored guifg=#7F848E
  highlight NvimTreeModified guifg=#ffcc00
]]

vim.cmd [[
  " 헤더 색상 설정
  highlight VimwikiHeader1 guifg=#ffffff guibg=#007F7F gui=bold
  highlight VimwikiHeader2 guifg=#5169E1 gui=bold
  highlight VimwikiHeader3 guifg=#7aa2f7 gui=bold
  highlight VimwikiHeader4 guifg=#7aa2f7
  highlight VimwikiHeader5 guifg=#7aa2f7
  " highlight VimwikiHeader6

  " 링크 색상 설정
  highlight VimwikiLink guifg=#FFFF00

  " 리스트 항목 색상 설정
  highlight VimwikiList gui=italic

  " 코드 블록 색상 설정
  highlight VimwikiCode guibg=#333342 guifg=#ffffff gui=italic

  " 강조 텍스트 색상 설정
  highlight VimwikiBold gui=bold,underline
  highlight VimwikiItalic guifg=#DCDCAA gui=italic

  " ToDo 항목 색상 설정
  highlight VimwikiTodo guifg=#000000 guibg=#87CEFA gui=bold
]]

vim.cmd [[
  highlight GitSignsAdd guifg=#40cd52
  highlight GitSignsChange guifg=#ffcc00
  highlight GitSignsChangedelete guifg=#f1502f
  highlight GitSignsDelete guifg=#f1502f
  highlight GitSignsTopdelete guifg=#f1502f
  highlight GitSignsUntracked guifg=#7f52ff
]]
