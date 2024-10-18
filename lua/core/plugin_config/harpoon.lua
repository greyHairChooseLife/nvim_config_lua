local harpoon = require("harpoon")

-- REQUIRED
harpoon:setup()
-- REQUIRED

vim.keymap.set("n", "<leader><space>a", function()
  harpoon:list():add()
  vim.notify("Added to Harpoon", "info", { title = "Harpoon" })
end)
vim.keymap.set("n", "<leader><space>b", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end)
vim.keymap.set("n", "<leader><space>B", function() toggle_telescope(harpoon:list()) end, { desc = "Open harpoon window" })

vim.keymap.set("n", "<leader><space>1", function() harpoon:list():select(1) end)
vim.keymap.set("n", "<leader><space>2", function() harpoon:list():select(2) end)
vim.keymap.set("n", "<leader><space>3", function() harpoon:list():select(3) end)
vim.keymap.set("n", "<leader><space>4", function() harpoon:list():select(4) end)
vim.keymap.set("n", "<leader><space>5", function() harpoon:list():select(4) end)

vim.keymap.set("n", "<C-[>", function() harpoon:list():prev() end)
vim.keymap.set("n", "<C-]>", function() harpoon:list():next() end)

harpoon:extend({
  UI_CREATE = function(cx)
    vim.keymap.set("n", "<C-v>", function()
      harpoon.ui:select_menu_item({ vsplit = true })
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-x>", function()
      harpoon.ui:select_menu_item({ split = true })
      vim.cmd("WinShift down")
      vim.cmd("WinShift down")
    end, { buffer = cx.bufnr })

    vim.keymap.set("n", "<C-t>", function()
      harpoon.ui:select_menu_item({ tabedit = true })
    end, { buffer = cx.bufnr })
  end,
})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end
