call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hardcoreplayers/dashboard-nvim'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'Chiel92/vim-autoformat', {'on': 'Autoformat'}
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
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server', 'for': ['html']}
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
Plug 'glepnir/spaceline.vim'
Plug 'PHSix/vim-buffet'
Plug 'cespare/vim-toml'
Plug 'nvim-lua/completion-nvim'
" Plug 'ms-jpq/chadtree', {'branch': 'chad', 'do': ':UpdateRemotePlugins'}
Plug 'jwarby/antovim'
Plug 'rafcamlet/coc-nvim-lua'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'dunstontc/vim-vscode-theme'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'skreek/skeletor.vim'
Plug 'kyazdani42/nvim-tree.lua'
Plug 'itchyny/vim-cursorword'
Plug 'dstein64/vim-startuptime'
call plug#end()


