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

### 개선서항

#### 간단

- vimwiki가 아닌 경우엔 마크다운인데도 자꾸 2개 이상의 라인 또는 EOL에 따라오는 공백을 지워버린다.
- `<leader>cc`로 commitmsg 버퍼를 켜면 최종 버퍼의 포키싱 윈도우 범위가 바뀐다.(살짝 올라감)
- `<leader>gg`로 fugitive 진입 후 윈도우 종료하면 커서 위치가 이상해진다. 마지막 윈도우 커서 위치로 가는게 아니라 가장 왼쪽 윈도우로 이동한다.
- auto-session 복구시 탭 이름도 복구 되도록
- gq, ge 따위로 버퍼를 제거를 시도하더라도, 만약 다른 탭에 해당 버퍼가 있다면 그냥 window만 닫아야 한다.

#### 복잡

- aerial.nvim에서,

  - treesitter typescript post parse에서 커스텀으로 'type'도 구분하기, 현재는 variable과 동일한 취급
  - function, variable, type의 아이콘을 보다 명확하게 변경하기

- (avante 개선) Predefined Propmts [예시자료](https://github.com/yetone/avante.nvim/wiki/Recipe-and-Tricks)

- coc -> native lsp로 전환

### 버그

- 가끔 색깔이 오락가락 한다. 특히 C-q에 맵핑한 플러그인이 실행될 때 증상이 거의 매번 나타난다. 희안하게도 nvim-tree를 껏다 켜거나, i3로 전체화면 전환해보면 괜찮아진다.
- nvim-tree 외 단 1개의 버퍼만 있을 때 `:bd`로 닫으면, 버퍼가 종료되지 않고 빈 버퍼가 남아버린다.
  현재는 이를 위한 대응을 버퍼 관리 기능들에 덕지덕지 붙여놨다. 이거 좀 개선할 필요가 있겠다.
- 어떤 단위의 첫번째 라인 바로 아래에 코드를 붙여넣으면 refold 되어버린다. [이 사람도 같은 불편을 호소](https://www.reddit.com/r/neovim/comments/1e7tfw2/pasting_line_by_p_makes_refold/)
- harpoon으로 열린 버퍼는 BufReadPost로 실행하고있는 :loadview가 제대로 안된다. cursor_position등 정보를 harpoon이 별도로 저장하고 사용해서 그런듯.

### Deprecated
