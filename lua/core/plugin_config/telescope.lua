local actions = require('telescope.actions')
local action_state = require('telescope.actions.state')
local builtin = require('telescope.builtin')
local function switch_to_normal_mode()
  local escape_key = vim.api.nvim_replace_termcodes('<Esc>', true, false, true)
  vim.api.nvim_feedkeys(escape_key, 'n', true)
end

require("telescope").setup {
  extensions = {
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    },
    hop = {
      -- the shown `keys` are the defaults, no need to set `keys` if defaults work for you ;)
      keys = { "a", "s", "d", "f", "g", "h", "j", "k", "l", ";",
        "q", "w", "e", "r", "t", "y", "u", "i", "o", "p",
        "A", "S", "D", "F", "G", "H", "J", "K", "L", ":",
        "Q", "W", "E", "R", "T", "Y", "U", "I", "O", "P",
        "z", "x", "c", "v", "b", "n", "m", ",", ".", "/",
        "Z", "X", "C", "V", "B", "N", "M", "<", ">", "?",
      },
      -- Highlight groups to link to signs and lines; the below configuration refers to demo
      -- sign_hl typically only defines foreground to possibly be combined with line_hl
      sign_hl = { "WarningMsg", "Title" },
      -- optional, typically a table of two highlight groups that are alternated between
      line_hl = { "CursorLine", "Normal" },
      -- options specific to `hop_loop`
      -- true temporarily disables Telescope selection highlighting
      clear_selection_hl = false,
      -- highlight hopped to entry with telescope selection highlight
      -- note: mutually exclusive with `clear_selection_hl`
      trace_entry = true,
      -- jump to entry where hoop loop was started from
      reset_selection = true,
    },
    coc = {
      prefer_locations = true,    -- always use Telescope locations to preview definitions/declarations/implementations etc
      push_cursor_on_edit = true, -- save the cursor position to jump back in the future
      timeout = 3000,             -- timeout for coc commands
    },
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  },
  defaults = {
    mappings = {
      n = {
        ['qq'] = "close",
      },
      i = {
        ['qq'] = "close",
        -- IMPORTANT
        -- either hot-reloaded or `function(prompt_bufnr) telescope.extensions.hop.hop end`
        ['<C-g>'] = require("telescope").extensions.hop.hop,
      },
    },
  },
  pickers = {
    buffers = {
      mappings = {
        n = {
          ['dd'] = "delete_buffer",
        },
        i = {
          ['<C-d>'] = "delete_buffer"
        },
      },
    },
    find_files = {
      mappings = {
        n = {
          ['x'] = function(prompt_bufnr)
            actions.select_horizontal(prompt_bufnr)
            builtin.resume()
            switch_to_normal_mode()
          end,
          ['v'] = function(prompt_bufnr)
            actions.select_vertical(prompt_bufnr)
            builtin.resume()
            switch_to_normal_mode()
          end,
          ['t'] = function(prompt_bufnr)
            actions.select_tab(prompt_bufnr)
            builtin.resume()
            switch_to_normal_mode()
          end,
        },
        i = {
          ['<C-x>'] = function(prompt_bufnr)
            actions.select_horizontal(prompt_bufnr)
            builtin.resume()
          end,
          ['<C-v>'] = function(prompt_bufnr)
            actions.select_vertical(prompt_bufnr)
            builtin.resume()
          end,
          ['<C-t>'] = function(prompt_bufnr)
            actions.select_tab(prompt_bufnr)
            builtin.resume()
          end,
        },
      },
    },
    git_stash = {
      mappings = {
        n = {
          ['dd'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.cmd('Git stash drop ' .. selection.value)
            actions.close(prompt_bufnr)
            builtin.git_stash()
            switch_to_normal_mode()
          end,
          ['ap'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.cmd('Git stash apply ' .. selection.value)
            actions.close(prompt_bufnr)
          end,
          ['pp'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.cmd('Git stash pop ' .. selection.value)
            actions.close(prompt_bufnr)
          end,
        },
        i = {
          ['<C-d>'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.cmd('Git stash drop ' .. selection.value)
            actions.close(prompt_bufnr)
            builtin.git_stash()
            switch_to_normal_mode()
          end,
          ['<C-a>'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.cmd('Git stash apply ' .. selection.value)
            actions.close(prompt_bufnr)
          end,
          ['<C-p>'] = function(prompt_bufnr)
            local selection = action_state.get_selected_entry()
            vim.cmd('Git stash pop ' .. selection.value)
            actions.close(prompt_bufnr)
          end,
        },
      },
    },
  },
}

require("telescope").load_extension("ui-select")
require("telescope").load_extension("hop")
require("telescope").load_extension("coc")
require('telescope').load_extension('fzf')
