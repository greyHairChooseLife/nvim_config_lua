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

-- NOTE: markdown.nvim의 gui가 좋아서 딱히 필요 없을 듯
-- -- Set tabstop to 4 for vimwiki files
-- vim.cmd([[
--   augroup VimwikiSettings
--     autocmd!
--     autocmd FileType vimwiki setlocal tabstop=4 shiftwidth=4 expandtab
--     autocmd BufRead,BufNewFile ~/Documents/dev-wiki/notes/*.md setlocal tabstop=4 shiftwidth=4 expandtab
--     autocmd BufRead,BufNewFile ~/Documents/job-wiki/notes/*.md setlocal tabstop=4 shiftwidth=4 expandtab
--   augroup END
-- ]])
