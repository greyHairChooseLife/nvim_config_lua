vim.cmd(
  [[
function OpenMarkdownPreview (url)
  execute "silent ! google-chrome --new-window --app=" . a:url
endfunction
]]
)

vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
