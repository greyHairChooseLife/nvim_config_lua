vim.keymap.set('n', ',R', RunBufferWithSh, { noremap = true, silent = true })
vim.keymap.set('n', ',cR', RunBufferWithShCover, { noremap = true, silent = true })
vim.keymap.set('v', ',R', RunSelectedLinesWithSh, { noremap = true, silent = true })
vim.keymap.set('v', ',cR', RunSelectedLinesWithShCover, { noremap = true, silent = true })
