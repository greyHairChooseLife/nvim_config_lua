-- #24283b   #333342 이건 nvim-tree의 배경색
--
-- #2CB67D   #98C379   #A1C98A
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
-- #2F2F2F   #5F5F5F   #9F9F9F   #D3D3D3   #FFFFFF   #E0E0E0   #a6b0a1
--
-- #800000   #FF0000   #FF3000   #FFA500   #FFFF00   #808000   #BDB76B
--
-- #000080   #0000FF   #3a0ff9   #4169E1   #87CEFA   #ADD8E6   #B0C4DE

-- #1c2d5f   #404000   #242024  #60603a

-- #a43838  #3a1f1f  #6A6709  #4E733F  #0d0d0d
-- #db4b4b  #442424  #605D08  #435F36  #111111
-- #e05f5f  #4d2929  #565306  #374C2D  #121212
-- #e57373  #573030  #4C4A05  #2C3924  #141414
-- #ea8686  #603636  #424104  #21261B  #1a1a1a
-- #efa0a0  #6a3d3d  #393704  #311b1b  #101010
-- #f3b3b3  #744444  #312E03  #2b1717  #0f0f0f
-- #f6c4c4  #7d4a4a  #292502  #251313  #151515
-- #f8d2d2  #875151  #211D02  #201010  #181818
-- #f9dddd  #925858  #1A1601  #1b0d0d  #0c0c0c
-- #fbe8e8
-- #fdf2f2


vim.cmd("highlight LineNr guifg=#9ece6a ctermfg=red")
vim.cmd("highlight TabLine guifg=lightgrey gui=bold guibg=black")
vim.cmd("highlight TabLineFill guibg=#24283b")
vim.cmd("highlight TabLineNotSel guibg=#4e4451")
vim.cmd("highlight TabLineSelBg guibg=#98c379 guifg=#24283b")
vim.cmd("highlight TabLineSelBorder guifg=#98c379 guifg=#24283b")
vim.cmd("highlight TabLineGVBg guibg=#FF8C00 guifg=#24283b")
vim.cmd("highlight TabLineGVBorder guifg=#FF8C00 guifg=#24283b")
vim.cmd("highlight TabLineOilBg guibg=#BDB80B guifg=#24283b")
vim.cmd("highlight TabLineOilBorder guifg=#BDB80B guifg=#24283b")
vim.cmd("highlight TabLineTempBg guibg=#FFFFFF guifg=#24283b")
vim.cmd("highlight TabLineTempBorder guifg=#FFFFFF guifg=#24283b")
vim.cmd("highlight Search guibg=#FFFF00 guifg=#1d202f")
vim.cmd("highlight CurSearch gui=bold guibg=#0000FF guifg=white")
vim.cmd("highlight Visual guibg=#4d6652 guifg=NONE")
vim.cmd("highlight CursorLine guibg=#4d6652 guifg=NONE")
vim.cmd("highlight Folded guibg=#24283b guifg=#4d6652 gui=italic")
vim.cmd("highlight StatusLine guibg=#24283b")
vim.cmd("highlight StatusLineNC guibg=#24283b")


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
  highlight NvimTreeNormal guibg=#333342 guifg=NONE
  highlight NvimTreeNormalNC guibg=#333342 guifg=NONE
  highlight NvimTreeFolderIcon guifg=#ffcc00
  highlight NvimTreeFolderArrowOpen guifg=#ffcc00
  highlight NvimTreeFolderName guifg=#569CD6 gui=bold
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
  highlight VimwikiHeader1 guifg=#AF4500 guibg=#007F7F gui=bold
  highlight VimwikiHeader2 guifg=#ffffff gui=bold
  highlight VimwikiHeader3 guifg=#ffffff gui=bold
  highlight VimwikiHeader4 guifg=#ffffff
  highlight VimwikiHeader5 guifg=#ffffff
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
  highlight GitSignsAddLn guibg=#1a472a guifg=NONE
  highlight GitSignsChangeLn guibg=#867300 guifg=NONE
  highlight GitSignsChangedelete guifg=#f1502f
  highlight GitSignsDelete guifg=#f1502f
  highlight GitSignsTopdelete guifg=#f1502f
  highlight GitSignsUntracked guifg=#7f52ff

  " 제대로 작동을 안하는거같어...
  highlight GitSignsAddInline guibg=#32CD32 guifg=NONE
  highlight GitSignsChangeInline guibg=#FFFF00 guifg=NONE
  highlight GitSignsDeleteInline guibg=#800000 guifg=NONE
  highlight GitSignsAddLnInline guibg=#32CD32 guifg=NONE
  highlight GitSignsChangeLnInline guibg=#FFFF00 guifg=NONE
  highlight GitSignsDeleteLnInline guibg=#800000 guifg=NONE
]]

-- Gvdiff, diffview
vim.cmd [[
  highlight DiffAdd guibg=#1a472a guifg=NONE
  highlight DiffChange guibg=#867300 guifg=NONE
]]

vim.cmd [[
  highlight RenderMarkdownCode guibg=#2c2832 guifg=NONE
  highlight RenderMarkdownCodeInline guibg=#2c2832 guifg=NONE
  highlight RenderMarkdownDash guifg=#000000
  highlight RenderMarkdownQuote guifg=#5F5F5F
  highlight RenderMarkdownBullet guifg=#007F7F gui=bold
  highlight RenderMarkdownUnchecked guifg=#CA4500
  highlight RenderMarkdownChecked guifg=#32CD32


  highlight RenderMarkdownMyTodo guifg=#CA4500 gui=bold,italic
  highlight RenderMarkdownMyTodoFin guifg=#1e6e40 gui=bold,italic
  highlight RenderMarkdownMySimpleTodo guifg=#ffffff guibg=#CA4500 gui=bold,italic
  highlight RenderMarkdownMySimpleDone guifg=#ffffff guibg=#004F4F gui=bold,italic
  highlight RenderMarkdownMySimpleCancel guifg=#ffffff guibg=#000000 gui=italic
  highlight RenderMarkdownResult guifg=#ffffff guibg=#3a0ff9 gui=bold,italic
  highlight RenderMarkdownMyQuestion guifg=#e0af68 gui=bold,italic
  highlight RenderMarkdownMyTest guifg=#B0C4DE gui=bold,italic
  highlight RenderMarkdownMyReference guifg=#C678DD gui=bold,italic
  highlight RenderMarkdownMyLog guifg=#000000 guibg=#B0C4DE gui=bold,italic

  highlight RenderMarkdownRed  guifg=#FF3000 gui=bold
  highlight RenderMarkdownBlue   guifg=#4169E1 gui=bold
  highlight RenderMarkdownGreen  guifg=#32CD32 gui=bold
  highlight RenderMarkdownYellow guifg=#FFBF00 gui=bold

  highlight RenderMarkdownH1Bg guibg=#DCDCAA gui=bold,italic
  highlight RenderMarkdownH2Bg guibg=#1c2d5f gui=bold
  highlight RenderMarkdownH3Bg guibg=#404000 gui=bold
  highlight RenderMarkdownH4Bg guibg=NONE guifg=#4169E1 gui=bold,italic
  " highlight RenderMarkdownH5Bg guibg=#AF4500
  " highlight RenderMarkdownH6Bg guibg=#4e4451

  highlight RenderMarkdownH1 guifg=#FFFFFF
  highlight RenderMarkdownH2 guifg=#4169E1
  highlight RenderMarkdownH3 guifg=#867300
  highlight RenderMarkdownH4 guifg=#4169E1
  " highlight RenderMarkdownH5 guifg=#FFFFFF gui=bold
  " highlight RenderMarkdownH6 guifg=#FFFFFF gui=bold

  highlight RenderMarkdownDocLink guifg=#FFBF00 gui=bold
  highlight RenderMarkdownWebLink guifg=#4169E1 gui=bold
  highlight RenderMarkdownFileLink guifg=#FFBF00 gui=bold
  highlight RenderMarkdownYoutubeLink guifg=#FF3000 gui=bold
  highlight RenderMarkdownDiaryLink guifg=#DCDCAA gui=bold

  " markup highlight for TreeSitter
  highlight @markup.link guifg=#4169E1
  highlight @markup.link.label guifg=#DCDCAA "FFF500
  highlight @markup.strong guibg=#007F7F gui=italic
  highlight @markup.italic guifg=#DCDCAA gui=italic
  highlight @markup guifg=#FFFFFF
  highlight @markup.heading.1.markdown guifg=#AF4500
  highlight @markup.heading.2.markdown guifg=#FFFFFF
  highlight @markup.heading.3.markdown guifg=#FFFFFF
  highlight @markup.heading.4.markdown guifg=#FFFFFF
  highlight @markup.heading.5.markdown guifg=#FFFFFF
  highlight @markup.heading.6.markdown guifg=#FFFFFF

" @markup.raw.markdown_inline
" @markup.heading.6.markdown
" @markup.heading.5.markdown
" @markup.heading.4.markdown
" @markup.heading.3.markdown
" @markup.heading.2.markdown
" @markup.heading.1.markdown
" @markup.link.label.symbol
" @markup.environment.name
" @markup.list.unchecked
" @markup.strikethrough
" @markup.list.markdown
" @markup.list.checked
" @markup.environment
" @markup.link.label
" @markup.underline
" @markup.link.url
" @markup.emphasis
" @markup.heading
" @markup.strong
" @markup.italic
" @markup.math
" @markup.list
" @markup.link
" @markup.raw
" @markup
]]


-- quickfix
vim.cmd [[
  highlight Delimiter guifg=#9ece6a
]]

-- oil
vim.cmd [[
  highlight OilDirIcon guifg=#ffcc00
]]

-- telescope
vim.cmd [[
  highlight TelescopeSelectionCaret guifg=#FF4500 guibg=#000080
  highlight TelescopeSelection guibg=#000080
  highlight TelescopeMultiSelection guibg=#000060  "bookmark한 것들
  highlight TelescopeMatching guifg=#FF4500

  " highlight TelescopePreviewMessageFillchar guibg=#FF4500 "preview에서 빈칸 채우기, 솔직히 뭔 용도인지 모르곘다.

  highlight TelescopePreviewLine guibg=#000080
  " highlight TelescopePreviewBorder guifg=#000080 guibg=#000000
  highlight TelescopePreviewNormal guifg=#E0E0E0 guibg=#000000
  highlight TelescopeResultsBorder guifg=#000000 guibg=#000000
  highlight TelescopeResultsTitle guifg=#000000 guibg=#000000
  highlight TelescopeResultsNormal guifg=#E0E0E0 guibg=#000000

  highlight TelescopeResultsComment guifg=#FF4500 "버퍼의 a, h, # 등 부가 정보
]]

-- nvim-tree
vim.cmd [[
  highlight NvimTreeOpenedHL guifg=#FF8C00 gui=italic,underline
]]
