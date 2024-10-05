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
-- nvim tree에서 현재 열려있는 버퍼에 해당하는 파일 및 폴더를 표시해주면 좋겠다. 그러면 telescope으로 조회하고 선택하지 않아도 되니, 그런 경우에 도움이 될듯?

-- TODO:
-- https://www.reddit.com/r/neovim/comments/1flo8qw/cmdfixnvim_lowercase_userdefined_commands_at_the/
-- 플러그인: 커맨드 모드에서 사용할 함수를 만들 때, 이름을 반드시 대문자로 시작해야하는 규칙이 있다. 이를 해결해주는 플러그인.

-- TODO:
-- job-wiki의 diary에서 템플릿 옮기는 과정을 자동화 할 수 있겠다. 메인 헤더 달아주는것처럼, :r !cat <rel-path/to/template.md> 를 자동 실행하자
