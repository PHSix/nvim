set number
set relativenumber " 开启相应行号显示
set nocompatible "使vim与vi不兼容，减少vi带来的问题
syntax on    " 开启高亮
set showmode   " 显示当前vim的默认状态
set showcmd    " 显示输入的命令
set mouse=a    " 允许光标操作
set encoding=utf-8 fileencodings=utf-8   " 使用utf-8编码
set autoindent    " 开启自动缩进
set expandtab     " 使用tab缩进
set tabstop=4     " 一个tab的长度
set softtabstop=4
set shiftwidth=4
set cursorline    " 所在行出现一条直线
set wrap          " 自动折行
set showmatch     "
set hlsearch     " 高亮搜索
set ignorecase    "
set smartcase     "
set nobackup
set noswapfile    " 关闭生成swap文件
set undofile      " 记录vim的历史操作
set undodir=~/.config/nvim/undodir " 指定一个文件来保存vim的历史操作
set autowrite
set fdm=manual    " 代码折叠的模式
set list          " 使你的vim的空格显示更加好看
set listchars=tab:\|\ ,trail:▫  " 同上
set scrolloff=5
set encoding=UTF-8
set history=400
set autochdir  " 自动切换到文件当前目录
autocmd BufReadPost *
            \ if line("'\"")>0&&line("'\"")<=line("$") |
            \       exe "normal g'\"" |
            \ endif"
autocmd WinLeave * setlocal nocursorline
