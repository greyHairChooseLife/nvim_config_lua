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
-- outline.nvim을 보다 실용성있게
-- => vista 적용, outline.nvim 대신에 사용할만 한가?
--https://github.com/liuchengxu/vista.vim
--https://www.youtube.com/results?search_query=vista.vim

-- TODO:
-- toggle-term 제대로 사용하기

-- TODO:
-- 15. normal mode ], [ 키를 활용하기. 기본적으로는 파일의 맨 시작과 끝으로 이동하는뜻? 아마도 next change 또는 next fold로 이동할수도?

-- TODO:: aerial.nvim에서
-- 1. treesitter typescript post parse에서 커스텀으로 'type'도 구분하기, 현재는 variable과 동일한 취급
-- 2. function, variable, type의 아이콘을 보다 명확하게 변경하기
