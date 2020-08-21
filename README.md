# 这是我的neovim的配置



## 安装前的依赖
**Acrhlinux**
- nodejs
- gopls
- xsel
- pynvim
- yarn
- npm
- ccls
- go
- rust
- rust-analyzer
- jdtls
- ranger
```bash
pacman -S nodejs gopls nodejs gopls xsel yarn npm rust rust-analyzer ccls ranger
python3 -m pip install --user --upgrade pynvim
yay -S jdtls
```

## 使用到的插件
- coc.nvim
- vim-startify
- nerdcommenter
- vim-surround
- vim-airline
- vim-airline-theme
- vim-autoformat
- indentLine
- vista.vim
- ranger.vim
- accelerate-jk
- vim-devicons
- colorizer
- vim-clap
- rainbow_parentheses.vim
- vim-polyglot
- ale
- semshi
- bracey.vim
- dart-vim-plugin
- vim0visual-multi
- fcitx.vim
- bullets.vim
## 按键的映射(map)
| map        | command                            | decription         | mode |
|------------|------------------------------------|--------------------|------|
| j          | (Plug)(accelerated_jk_gj_position) | move down faster   | N    |
| k          | (Plug)(accelerated_jk_gj_position) | move up faster     | N    |
| S          | :w                                 | save file          | N    |
| Q          | :q!                                | quit file          | N    |
| X          | :x                                 | save file and quit | N    |
| space      | leader                             | map leader key     | I, N |
| A-j        | 5j                                 | 5j                 | I, N |
| A-k        | 5k                                 | 5k                 | I, N |
| A-l        | 5l                                 | 5l                 | I, N |
| A-h        | 5h                                 | 5h                 | I, N |
| space-nvim | :e ~/.config/nvim/init.vim         | editor nvim config | N    |
| ,lg        | :term lazygit                      | open lazygit       | N    |
| J          | :resize -5                         |                    | N    |
| K          | :resize +5                         |                    | N    |
| L          | :vertical resize +5                |                    | N    |
| H          | :vertical resize -5                |                    | N    |
|            | <++>                               | <++>               | <++> |

## 一些插件的说明




