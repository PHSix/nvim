call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
" Plug 'mhinz/vim-startify'
Plug 'hardcoreplayers/dashboard-nvim'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
" Plug 'vim-airline/vim-airline'
" Plug 'vim-airline/vim-airline-themes'
Plug 'Chiel92/vim-autoformat', {'on': 'Autoformat'}
Plug 'Yggdroot/indentLine'
Plug 'liuchengxu/vista.vim'
Plug 'francoiscabrol/ranger.vim', {'on': 'Ranger'}
Plug 'rhysd/accelerated-jk'
Plug 'ryanoasis/vim-devicons'
Plug 'lilydjwg/colorizer'
Plug 'kien/rainbow_parentheses.vim'
Plug 'liuchengxu/vim-clap', {'do': 'cargo build --release'}
Plug 'junegunn/vim-easy-align', {'on':'<Plug>(EasyAlign)'}
Plug 'sheerun/vim-polyglot'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'turbio/bracey.vim', {'for': 'html'}
Plug 'dart-lang/dart-vim-plugin', {'for': 'dart'}
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'lilydjwg/fcitx.vim'
Plug 'dkarter/bullets.vim', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', {'for': ['markdown']}
Plug 'bling/vim-bufferline'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown']}
Plug 'sainnhe/forest-night'
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vimwiki/vimwiki'
Plug 'puremourning/vimspector', {'do': './install_gadget.py --enable-python --enable-go --enable-bash --enable-c'}
Plug 'junegunn/vim-easy-align'
Plug 'voldikss/vim-hello-word'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'glepnir/spaceline.vim'
Plug 'PHSix/vim-buffet'
call plug#end()
