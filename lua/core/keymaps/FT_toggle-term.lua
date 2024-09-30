vim.api.nvim_create_autocmd("FileType", {
  pattern = "toggleterm",
  callback = function()
    -- gui

    -- keymap
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]])
    -- NEW WINDOW & TAB
    vim.keymap.set('t', '<A-n>x', '<Cmd>rightbelow new<CR>')
    vim.keymap.set('t', '<A-n>v', '<Cmd>vert rightbelow new<CR>')
    vim.keymap.set('t', '<A-n>t', NewTabWithPrompt)
    vim.keymap.set('t', '<A-r>', RenameCurrentTab)
    vim.keymap.set('t', '<A-m>l', MoveTabRight)
    vim.keymap.set('t', '<A-m>h', MoveTabLeft)
    -- FOCUS TABS
    vim.keymap.set('t', '<A-p>', [[<C-\><C-n>gt]], { noremap = true, silent = true })
    vim.keymap.set('t', '<A-o>', [[<C-\><C-n>gT]], { noremap = true, silent = true })
    for i = 1, 9 do
      -- 숫자에 따른 탭 이동 (1gt, 2gt, ..., 9gt)
      vim.keymap.set('t', '<A-' .. i .. '>', [[<C-\><C-n>]] .. i .. [[gt]], { noremap = true, silent = true })
    end
    -- FOCUS WINDOW
    vim.keymap.set('t', '<A-h>', '<Cmd>wincmd h<CR>')
    vim.keymap.set('t', '<A-j>', '<Cmd>wincmd j<CR>')
    vim.keymap.set('t', '<A-k>', '<Cmd>wincmd k<CR>')
    vim.keymap.set('t', '<A-l>', '<Cmd>wincmd l<CR>')
    -- MOVE WINDOW PtSITION
    vim.keymap.set('t', '<A-H>', '<Cmd>WinShift left<CR>')
    vim.keymap.set('t', '<A-J>', '<Cmd>WinShift down<CR>')
    vim.keymap.set('t', '<A-K>', '<Cmd>WinShift up<CR>')
    vim.keymap.set('t', '<A-L>', '<Cmd>WinShift right<CR>')
    vim.keymap.set('t', ',mt', '<C-w>T')        -- move window to tab
    vim.keymap.set('t', ',st', '<Cmd>sp<CR><C-w>T') -- copy window to tab
    -- WINDOW RESIZEt
    vim.keymap.set("t", "<A-Left>", "<Cmd>vertical resize -2<CR>", {})
    vim.keymap.set("t", "<A-Right>", "<Cmd>vertical resize +2<CR>", {})
    vim.keymap.set("t", "<A-Down>", "<Cmd>horizontal resize -2<CR>", {})
    vim.keymap.set("t", "<A-Up>", "<Cmd>horizontal resize +2<CR>", {})
    -- WINDOW RESIZEtHARD
    vim.keymap.set("t", "<A-S-Left>", "<Cmd>vertical resize -8<CR>", {})
    vim.keymap.set("t", "<A-S-Right>", "<Cmd>vertical resize +8<CR>", {})
    vim.keymap.set("t", "<A-S-Down>", "<Cmd>horizontal resize -8<CR>", {})
    vim.keymap.set("t", "<A-S-Up>", "<Cmd>horizontal resize +8<CR>", {})

  end
})
