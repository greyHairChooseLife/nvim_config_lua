vim.api.nvim_set_hl(0, "MyBG", { fg = "#24283b" })

require("ibl").setup {
  enabled = false,
  indent = {
    char = "▏",
    smart_indent_cap = true,
    repeat_linebreak = false,
    highlight = { "MyBG" },
  },
  -- whitespace = { highlight = { "Whitespace", "NonText" } },
  scope = {
    enabled = true,
    -- char = "▍",
    char = "▏",
    highlight = { "NvimTreeIndentMarker" },
    show_start = false,
    show_end = false,
    injected_languages = false,
    priority = 500,
    -- exclude = { language = { "lua" } },
  },
}
