## todo list

### 관심있는 플러그인

- `folke/trouble.nvim`
  coc.nvim과 함게는 쓰기 어렵고, 내장 lsp 매니저(?)로 전환할 때 활용하자

- http client inside neovim

  - https://github.com/rest-nvim/rest.nvim
  - https://www.reddit.com/r/neovim/comments/1eh0yr6/restnvim_is_back/
  - https://github.com/mistweaverco/kulala.nvim

- indent or chunk marker(visualizer)

  - https://github.com/shellRaining/hlchunk.nvim

- chat with copilot

  - https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file

- crawling web pages, rendering them to Markdown or JSON, and inserting the content into new buffers. It also supports asynchronous search functionality.

  - https://github.com/twilwa/crawler.nvim

- 선택한 코드라인의 github url을 생성

  - https://www.reddit.com/r/neovim/comments/1gzid9o/browshernvim_create_commit_pinned_githubgitlab/
  - https://github.com/claydugo/browsher.nvim

- smooth scroll without neovide or kitty + smear cursor
    - from reddit

- jremmen/vim-ripgrep	
```
"jremmen/vim-ripgrep",
		cmd = "Rg",
		init = function()
			vim.keymap.set("n", "<C-h>", ":Rg<space>")
			vim.keymap.set("n", "<C-*>", "<cmd>Rg<space><CR>")
			vim.keymap.set("n", "<C-g>", "<cmd> lua require('utils').replace_grep()<CR>")
		end,
```

### config 훔치기 [-]

- 전반적으로
  https://patrick-f.tistory.com/36

- nvim-cmp
    https://github.com/gennaro-tedesco/dotfiles/blob/bc9acae08a4104ff5f1adbe8eef3ee58e11e1020/nvim/lua/plugins/cmp.lua#L95

### 개선서항

#### 간단

- `<leader>cc`로 commitmsg 버퍼를 켜면 최종 버퍼의 포키싱 윈도우 범위가 바뀐다.(살짝 올라감)
- auto-session 복구시 탭 이름도 복구 되도록
- keymap: telescope 에서 <C-q>로 선택한 파일을 qf에 추가한다. 근데 이거 곧바로 qflist 버퍼를 띄우기보단 그냥 log만 남겨주는게 좋을듯
- keymap: cmdwindow에서 normal mode <Esc> -> cmdline으로 이동하되, 현재 input내용 그대로 살려서
- 문자 없이 빈 칸에서 `'`키 입력시 message 지우기

- `Tab, S-Tab, g-Tab`으로 버퍼 순회할 때 현재 탭의 윈도우에 active인 것은 제외해도 되겠다. 그리고 이것이 시각적으 로표현되도록 하면 좋겠다.
    [ref](https://www.youtube.com/watch?v=ST_DZ6yIiXY)

- auto-session에서도 telescope로 ui-select

- winbar의 활용

- `/`에서 뭐 찾다가 그냥 `Esc`해보면 마지막에 찾은 문자열을 찾아간다. 매우 귀찮다.

#### 복잡

- nvim-tree에서 지금 주황색으로 보여주고 표시하는건 loaded buffer인데, 현재탭의 active window만 보는것도 좋을것같다.    
  정리해보면 not-loaded(기본 트리)/ loaded/ active(cucrent tab) / left(== inactive in current tab)을 한눈에 볼 파악할 수 있는 tree가 있다면 유용하겠다.(ex: avante.nvim selected file에 active 파일들을 모두 추가)

- aerial.nvim에서,

  - treesitter typescript post parse에서 커스텀으로 'type'도 구분하기, 현재는 variable과 동일한 취급
  - function, variable, type의 아이콘을 보다 명확하게 변경하기

- (avante 개선) Predefined Propmts [예시자료](https://github.com/yetone/avante.nvim/wiki/Recipe-and-Tricks)

### 버그

- 가끔 색깔이 오락가락 한다. 특히 C-q에 맵핑한 플러그인이 실행될 때 증상이 거의 매번 나타난다. 희안하게도 nvim-tree를 껏다 켜거나, i3로 전체화면 전환해보면 괜찮아진다.
- nvim-tree 외 단 1개의 버퍼만 있을 때 `:bd`로 닫으면, 버퍼가 종료되지 않고 빈 버퍼가 남아버린다.
  현재는 이를 위한 대응을 버퍼 관리 기능들에 덕지덕지 붙여놨다. 이거 좀 개선할 필요가 있겠다.
- 어떤 단위의 첫번째 라인 바로 아래에 코드를 붙여넣으면 refold 되어버린다. [이 사람도 같은 불편을 호소](https://www.reddit.com/r/neovim/comments/1e7tfw2/pasting_line_by_p_makes_refold/)
- harpoon으로 열린 버퍼는 BufReadPost로 실행하고있는 :loadview가 제대로 안된다. cursor_position등 정보를 harpoon이 별도로 저장하고 사용해서 그런듯.

- `<leader>gg`로 fugitive 진입 후 윈도우 종료하면 커서 위치가 이상해진다. 마지막 윈도우 커서 위치로 가는게 아니라 가장 왼쪽 윈도우로 이동한다.

### Deprecated

My "aha!" moment came when watching Josean Martinez' video "How to set up linting and formatting"
