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
-- toggleTerm 플러그인으로 vim 버퍼 안에서 '다수의 고유한 터미널(id 부여)'을 열 수 있다. [관련 영상](https://www.youtube.com/watch?v=lbZkCPaFom0)

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
-- https://github.com/folke/twilight.nvim
--
-- indent-blankline의 current_scope_only 옵션이 부재한 것을 보완히기 위해 사용할수도 있을듯. <Space>에 추가 맵핑하자.
-- indent-blankline의 경우 lv.1 line은 무시하는 것도 좋겠다. -> https://github.com/lukas-reineke/indent-blankline.nvim/issues/824
-- 별개로 다른 indent-line 플러그인도 고려해보자. mini같ㅇ너거

-- TODO:
-- nvim-tree와 버퍼 관리 키맵, 특히 'gq'에 맵핑된 것이 제대로 동작을 안하는 부분이 있다. 문제되는 부분이 명확히 정리되지도 않았다.
-- 이와 관련하여 nvim-tree의 wiki에 내용이 있다. nvim-tree 버퍼 외 1개 버퍼만 있을 시 bq로 윈도우가 완전히 닫히지 않는 문제다.
-- (더불어 해당 wiki에 좋은 내용이 많으니 다시 한번 훑어보며 가져올만한게 없나 살피자.)

-- TODO:
-- fugitive 'I'에 맵핑한 git add -p 의 기능이 뭔가 이상하다. esc로 빠져나가는 부분이 정상이 아닌듯. 버퍼 안에 버퍼를 띄우는데, 혹시 flatten.nvim과 관련 있는 내용이지 싶다.

-- TODO:
-- 전반적으로 더 읽기쉽게 개선해볼 수 있을듯..

-- TODO:
-- lualine 반응이 매우 느려졌다. 왜? 개선이 필요하다.
