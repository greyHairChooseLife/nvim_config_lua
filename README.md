## 비고
- gh.nvim plugin이 루아 아니면 설치 및 설정이 너무 어려웠다. 그래서 옮김

## 구성
```
.
├── init.lua
├── lua
│   └── core
│       ├── globals.lua
│       ├── keymaps.lua
│       ├── plugin_config
│       │   ├── calendar.lua
│       │   ├── coc.lua
│       │   ├── dracula.lua
│       │   ├── gh.lua
│       │   ├── init.lua
│       │   ├── nvim-tree.lua
│       │   ├── startify.lua
│       │   ├── telescope.lua
│       │   ├── treesitter.lua
│       │   └── vimwiki.lua
│       └── plugins.lua           // plugins 설치 관리
└── plugin                        // 자동 생성
    └── packer_compiled.lua

5 directories, 15 files
```

## Ref

- [public doc](!https://www.lua.org/manual/5.3/)
- [neovim doc for lua api](!https://neovim.io/doc/user/options.html)

