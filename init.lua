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

-- TODO:
-- toggle-term 제대로 사용하기

-- TODO:
-- 15. normal mode ], [ 키를 활용하기. 기본적으로는 파일의 맨 시작과 끝으로 이동하는뜻? 아마도 next change 또는 next fold로 이동할수도?

-- TODO:: misc
--
-- 13. to-fix: alpha 또는 nvim-tree에서 root를 바꾸는 방식으로 디렉토리를 이동하면 터미널 자체에서 cd 한 것과는 다른 취급인가보다. harpoon을 찾을 수 없다.
-- 14. vista 적용, outline.nvim 대신에 사용할만 한가?
--https://github.com/liuchengxu/vista.vim
--https://www.youtube.com/results?search_query=vista.vim
