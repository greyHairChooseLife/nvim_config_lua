require("core.plugins");
require("core.plugin_config");
require("core.globals");
require("core.custom_commands");
require("core.auto_commands");
require("core.snippets");
require("core.keymaps");
require("core.highlights");
require("core.custom_tabline");
require("core.temp");
require("core.floating_window");

-- https://www.lua.org/manual/5.3/
-- https://neovim.io/doc/user/options.html

-- TODO:
-- toggle-term 제대로 사용하기

-- TODO:
-- 15. normal mode ], [ 키를 활용하기. 기본적으로는 파일의 맨 시작과 끝으로 이동하는뜻? 아마도 next change 또는 next fold로 이동할수도?

-- TODO:: aerial.nvim에서
-- 1. treesitter typescript post parse에서 커스텀으로 'type'도 구분하기, 현재는 variable과 동일한 취급
-- 2. function, variable, type의 아이콘을 보다 명확하게 변경하기


-- TODO: chatGPT에 이미 물어보긴했다.
-- telescope를 통해서 특정 버퍼나 파일을 찾기 쉽잖아? 근데 이때 이 버퍼나 파일을 열면 만약 다른 탭이나 윈도우에 이미 활성화된 버퍼가 있더라도 현재 윈도우나 지정한 윈도우에 중복으로 열려버리잖아?  이렇게 하지 말고 만약 활성화된 버퍼가 있따면 그냥 그 윈도우로 focus하려면 어떻게해?
--
-- 구현할 것:  있으면 그쪽으로 포커스, 없으면 기본 동작, <CR>로 동작
--
-- local actions = require('telescope.actions')
-- local action_state = require('telescope.actions.state')
--
-- require('telescope').setup{
--   defaults = {
--     mappings = {
--       i = {
--         ["<CR>"] = function(prompt_bufnr)
--           local entry = action_state.get_selected_entry()
--           local filepath = entry.path or entry.filename
--
--           if filepath then
--             -- 버퍼가 이미 열려 있는지 확인
--             for _, win in ipairs(vim.api.nvim_list_wins()) do
--               local buf = vim.api.nvim_win_get_buf(win)
--               if vim.api.nvim_buf_get_name(buf) == filepath then
--                 -- 이미 열려 있는 버퍼를 찾으면 해당 윈도우로 포커스
--                 vim.api.nvim_set_current_win(win)
--                 actions.close(prompt_bufnr)
--                 return
--               end
--             end
--           end
--
--           -- 그렇지 않으면 기본 동작 수행
--           actions.select_default(prompt_bufnr)
--         end
--       }
--     }
--   }
-- }

-- TODO:
-- telescope git_stash에서도 delta를 사용하도록 설정하기
