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

-- 함수를 전역으로 등록
-- _G.vimwiki_fold_level_custom = function(lnum)
--   local line = vim.fn.getline(lnum)
--   local next_line = vim.fn.getline(lnum + 1)
--
--   -- 헤더를 찾음
--   local pounds = string.match(line, "^#+")
--
--   if pounds then
--     return '>' .. #pounds -- 헤더에 따라 폴딩 레벨을 설정
--   end
--
--   -- 헤더 바로 전 빈 줄을 폴딩하지 않음
--   if string.match(line, "^%s*$") and string.match(next_line, "^#+") then
--     return '-1' -- 이 라인은 폴딩하지 않음
--   end
--
--   -- 기본적으로 현재 폴딩 레벨 유지
--   return '='
-- end


_G.vimwiki_fold_level_custom = function(lnum)
  local line = vim.fn.getline(lnum)
  local prev_line = vim.fn.getline(lnum - 1)
  local next_line = vim.fn.getline(lnum + 1)

  -- 헤더를 찾음
  local pounds = string.match(line, "^#+")

  -- 헤더 바로 다음 라인부터 폴드 레벨 시작
  if pounds and not string.match(prev_line, "^#+") then
    return '=' -- 현재 라인은 폴드하지 않음
  end

  if string.match(prev_line, "^#+") then
    return '>' .. #string.match(prev_line, "^#+") -- 이전 헤더에 따라 폴드 레벨 설정
  end

  if string.match(line, "^%s*$") and string.match(next_line, "^#+") then
    return '-1' -- 이 라인은 폴딩하지 않음
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
  end,
})

-- TODO:
-- "Vimwiki Shift+Return, Ctrl+Return not working."
-- https://www.reddit.com/r/vim/comments/7xoe8b/vimwiki_shiftreturn_ctrlreturn_not_working/

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
