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
-- https://github.com/yetone/cosmos-nvim  config 참고


-- TODO:: aerial.nvim에서
-- 1. treesitter typescript post parse에서 커스텀으로 'type'도 구분하기, 현재는 variable과 동일한 취급
-- 2. function, variable, type의 아이콘을 보다 명확하게 변경하기


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
--

-- TODO:
-- paste makes refold, 최상단에 붙여넣을 때만
-- https://www.reddit.com/r/neovim/comments/1e7tfw2/pasting_line_by_p_makes_refold/


-- TODO:: avante input에 wrap이 풀렸는데? 왜지?
-- i키에다가 맵핑: input으로 넘어가서 insertmode 시작


-- TODO:: oli.nvim 에서 <C-v>가 뭔가에 맵핑되어있다. 자꾸 저장하려고 한다. 나는 visual blocking 하려는건데


-- TODO:: telescope find_file가  visual 모드에서도 동작하게 하기. selected words가 default_words가 되도록
--
--
--
--
--
  -- TODO:: avante 개선, predefined propmts
-- https://github.com/yetone/avante.nvim/wiki/Recipe-and-Tricks
