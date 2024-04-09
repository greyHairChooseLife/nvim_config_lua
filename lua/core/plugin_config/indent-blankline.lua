require("ibl").setup {
  enabled = false,
  indent = {
    char = "▏",
    smart_indent_cap = true,
    repeat_linebreak = false,

  },
  -- whitespace = { highlight = { "Whitespace", "NonText" } },
  scope = {
    enabled = true,
    char = "▍",
    highlight = { "DevIconKotlin" },
    show_start = true,
    show_end = true,
    injected_languages = false,
    priority = 500,
    exclude = { language = { "lua" } },
  },
}
