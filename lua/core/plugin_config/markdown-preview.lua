vim.cmd(
  [[
function OpenMarkdownPreview (url)
  execute "silent ! brave --new-window --app=" . a:url
endfunction
]]
)

vim.g.mkdp_browserfunc = 'OpenMarkdownPreview'
