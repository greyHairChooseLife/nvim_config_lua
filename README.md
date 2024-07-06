# neovim lua 설정

gh.nvim plugin이 루아 아니면 설치 및 설정이 너무 어려웠다. 그래서 옮김

## TOC

<!--toc:start-->

- [neovim lua 설정](#neovim-lua-설정)
  - [TOC](#toc)
  - [구성](#구성)
  - [Ref](#ref)
  <!--toc:end-->

## 구성

```bash
.
├── coc-settings.json
├── init.lua
├── lua
│   └── core
│       ├── custom_commands.lua
│       ├── globals.lua
│       ├── keymaps.lua
│       ├── plugin_config
│       │   ├── calendar.lua
│       │   ├── coc.lua
│       │   ├── colorizer.lua
│       │   ├── gh.lua
│       │   ├── init.lua
│       │   ├── nvim-tree.lua
│       │   ├── spectre.lua
│       │   ├── startify.lua
│       │   ├── telescope.lua
│       │   ├── tokyonight.lua
│       │   ├── treesitter.lua
│       │   └── vimwiki.lua
│       └── plugins.lua
├── plugin
│   └── packer_compiled.lua
└── README.md

5 directories, 20 files
```

## Ref

- [public doc](!https://www.lua.org/manual/5.3/)
- [neovim doc for lua api](!https://neovim.io/doc/user/options.html)
- [nerd font](https://www.nerdfonts.com/cheat-sheet)
