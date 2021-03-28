call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'hardcoreplayers/dashboard-nvim'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'Chiel92/vim-autoformat', {'on': 'Autoformat'}
Plug 'liuchengxu/vista.vim'
Plug 'rhysd/accelerated-jk'
Plug 'ryanoasis/vim-devicons'
Plug 'kien/rainbow_parentheses.vim'
Plug 'junegunn/vim-easy-align', {'on':'<Plug>(EasyAlign)'}
Plug 'sheerun/vim-polyglot'
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
Plug 'cespare/vim-toml'
Plug 'kyazdani42/nvim-web-devicons' " for file icons
Plug 'itchyny/vim-cursorword'
Plug 'fatih/vim-go'
Plug 'gcmt/wildfire.vim'
Plug 'kdheepak/lazygit.nvim'
Plug 'junegunn/fzf.vim' " needed for previews
Plug 'antoinemadec/coc-fzf'
Plug 'sakshamgupta05/vim-todo-highlight'
Plug 'skywind3000/asynctasks.vim'
Plug 'skywind3000/asyncrun.vim'
Plug 'bling/vim-bufferline'
call plug#end()
if empty(stdpath("config") .. "/plugged")
  execute(":PlugInstall")
else
  source ~/.config/nvim/core/plugins/setting.vim
endif
