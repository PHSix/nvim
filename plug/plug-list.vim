call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hardcoreplayers/dashboard-nvim'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'Chiel92/vim-autoformat', {'on': 'Autoformat'}
Plug 'liuchengxu/vista.vim'
Plug 'francoiscabrol/ranger.vim', {'on': 'Ranger'}
Plug 'rbgrouleff/bclose.vim'
Plug 'rhysd/accelerated-jk'
Plug 'ryanoasis/vim-devicons'
Plug 'kien/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align', {'on':'<Plug>(EasyAlign)'}
Plug 'sheerun/vim-polyglot'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'turbio/bracey.vim', {'do': 'npm install --prefix server', 'for': ['html']}
Plug 'dart-lang/dart-vim-plugin', {'for': 'dart'}
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'lilydjwg/fcitx.vim'
Plug 'dkarter/bullets.vim', {'for': 'markdown'}
Plug 'dhruvasagar/vim-table-mode', {'for': ['markdown']}
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'simnalamburt/vim-mundo', {'on': 'MundoToggle'}
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown']}
Plug 'rafi/awesome-vim-colorschemes'
Plug 'vimwiki/vimwiki'
Plug 'junegunn/vim-easy-align'
Plug 'voldikss/vim-hello-word'
Plug 'glepnir/galaxyline.nvim'
Plug 'cespare/vim-toml'
Plug 'jwarby/antovim'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'tyrannicaltoucan/vim-deep-space'
Plug 'itchyny/vim-cursorword'
Plug 'dstein64/vim-startuptime'
Plug 'fatih/vim-go'
Plug 'gcmt/wildfire.vim'
Plug 'kdheepak/lazygit.nvim'
Plug 'junegunn/fzf', {'dir': '~/.fzf','do': './install --all'}
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'antoinemadec/coc-fzf'
Plug 'sakshamgupta05/vim-todo-highlight'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'Dimercel/todo-vim'
Plug 'jackguo380/vim-lsp-cxx-highlight'
Plug 'bfrg/vim-cmake-help'
Plug 'bsdelf/bufferhint'
Plug 'Shougo/defx.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'kristijanhusak/defx-icons'
Plug 'bling/vim-bufferline'
call plug#end()
