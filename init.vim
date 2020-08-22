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
nmap S :w<CR>
nmap Q :q!<CR>
nmap X :x<CR>
nmap <leader>nl :noh<cr>
noremap <A-j> 5j
noremap <A-k> 5k
noremap <A-h> 5h
noremap <A-l> 5l
nmap <leader>nvim :e ~/.config/nvim/init.vim
nmap ,lg :term lazygit<cr>
map <space> <leader>
nmap <A-n> :bp<cr>
nmap <A-b> :bn<cr>
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l
nmap <leader>sl :set splitright<CR>:vsplit<CR>
nmap <leader>sh :set nosplitright<CR>:vsplit<CR>
nmap <leader>sj :set nosplitbelow<CR>:split<CR>
nmap <leader>sk :set splitbelow<CR>:split<CR>
nmap <leader>wl <C-w>t<C-w>L<CR>
nmap <leader>wh <C-w>t<C-w>H<CR>
nmap <leader>wj <C-w>t<C-w>J<CR>
nmap <leader>wk <C-w>t<C-w>K<CR>
nnoremap K :resize +5<CR>
nnoremap J :resize -5<CR>
nnoremap L :vertical resize +5<CR>
nnoremap H :vertical resize -5<CR>
map ff zf  " 创建折叠
map fo zO  " 打开折叠
map fO zo
map fm zm  " 全部折叠
map fn zn  " 全部展开
map fy "+y
autocmd BufReadPost *
            \ if line("'\"")>0&&line("'\"")<=line("$") |
            \       exe "normal g'\"" |
            \ endif"
autocmd BufNewFile,BufRead *.md set nofoldenable
autocmd BufNewFile,BufRead *.js set nofoldenable
autocmd BufNewFile,BufRead *.conf set nofoldenable
au BufWritePost *.less silent !lessc -x %:t > %:r.css
autocmd BufNewFile,BufRead *.html set tabstop=2
autocmd BufNewFile,BufRead *.html set softtabstop=2
autocmd BufNewFile,BufRead *.html set shiftwidth=2
autocmd BufNewFile,BufRead *.js set tabstop=2
autocmd BufNewFile,BufRead *.js set softtabstop=2
autocmd BufNewFile,BufRead *.js set shiftwidth=2
autocmd BufNewFile,BufRead *.css set tabstop=2
autocmd BufNewFile,BufRead *.css set softtabstop=2
autocmd BufNewFile,BufRead *.css set shiftwidth=2
autocmd BufNewFile,BufRead *.dart set tabstop=2
autocmd BufNewFile,BufRead *.dart set softtabstop=2
autocmd BufNewFile,BufRead *.dart set shiftwidth=2
autocmd filetype markdown inoremap <buffer> <silent> ,, <++>
autocmd filetype markdown inoremap <buffer> <silent> ,e <esc>/<++><cr>:nohlsearch<cr>c4l
autocmd Filetype markdown inoremap <buffer> <silent> ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
autocmd filetype markdown inoremap <buffer> <silent> ,s <esc>/ <++><cr>:nohlsearch<cr>c5l
autocmd filetype markdown inoremap <buffer> <silent> ,- ---<enter><enter>
autocmd filetype markdown inoremap <buffer> <silent> ,b **** <++><esc>F*hi
autocmd filetype markdown inoremap <buffer> <silent> ,x ~~~~ <++><esc>F~hi
autocmd filetype markdown inoremap <buffer> <silent> ,q `` <++><esc>F`i
autocmd filetype markdown inoremap <buffer> <silent> ,c ```<enter><++><enter>```<enter><enter><++><esc>4ka
autocmd filetype markdown inoremap <buffer> <silent> ,w - [ ] <enter><++><esc>kA
autocmd filetype markdown inoremap <buffer> <silent> ,u <u></u><++><esc>F/hi
autocmd filetype markdown inoremap <buffer> <silent> ,p ![](<++>) <enter><++><esc>kF[a
autocmd filetype markdown inoremap <buffer> <silent> ,l [](<++>) <++><esc>F[a
autocmd filetype markdown inoremap <buffer> <silent> ,1 #<space><enter><++><esc>kA
autocmd filetype markdown inoremap <buffer> <silent> ,2 ##<space><enter><++><esc>kA
autocmd filetype markdown inoremap <buffer> <silent> ,3 ###<space><enter><++><esc>kA
autocmd filetype markdown inoremap <buffer> <silent> ,4 ####<space><enter><++><esc>kA
autocmd filetype markdown inoremap <buffer> <silent> ,t <c-r>=strftime("%y-%m-%d %h:%m:%s")<cr>
autocmd filetype markdown inoremap <buffer> <silent> ,g {% web  <++> %} <++><esc>fb2li
autocmd filetype markdown inoremap <buffer> <silent> ,d {% download  <++> %} <++><esc>fd2li
highlight clear SignColumn
highlight Cursorline  ctermfg=Green  ctermbg=NONE cterm=bold guifg=white guibg=yellow gui=bold
highlight EndOfBuffer  ctermfg=NONE ctermbg=NONE  guibg=NONE  guifg=NONE cterm=NONE gui=NONE
highlight Visual ctermfg=NONE ctermbg=39
highlight PmenuSbar ctermfg=NONE ctermbg=NONE
highlight VertSplit ctermfg=147 ctermbg=147
highlight Pmenu  ctermfg=black ctermbg=blue
highlight PmenuSel ctermfg=7 ctermbg=4
highlight WarningMsg ctermbg=39 ctermfg=NONE
highlight SignColumn   ctermfg=NONE ctermbg=NONE  guibg=NONE  guifg=NONE cterm=NONE gui=NONE
hi! DiffAdd ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
hi! DiffChange ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
hi! DiffDelete ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE



map R :call CompileRunGcc()<CR>
func! CompileRunGcc()
    exec "w"
    if &filetype == 'c'
        set splitbelow
        exec "!g++ % -o %<"
        :sp
        :res -15
        :term ./%<
    elseif &filetype == 'cpp'
        set splitbelow
        exec "!g++ -std=c++11 % -Wall -o %<"
        :sp
        :res -15
        :term ./%<
    elseif &filetype == 'java'
        exec "!javac %"
        exec "!time java %<"
    elseif &filetype == 'sh'
        :!time bash %
    elseif &filetype == 'python'
        set splitbelow
        :sp
        :term python3 %
    elseif &filetype == 'markdown'
        let g:mkdp_browser = 'chromium'
        exec "MarkdownPreview"
    elseif &filetype == 'tex'
        silent! exec "VimtexStop"
        silent! exec "VimtexCompile"
    elseif &filetype == 'javascript'
        set splitbelow
        :sp
        :term node --trace-warnings %
        " :term export DEBUG="INFO,ERROR,WARNING"; node --trace-warnings .
    elseif &filetype == 'typescript'
        set splitbelow
        :sp
        :term ts-node %
    elseif &filetype == 'go'
        set splitbelow
        :sp
        :term go run .
    elseif &filetype == 'html'
        :Bracey
    elseif &filetype == 'rust'
        set splitbelow
        :sp
        :term cargo run
    elseif &filetype == 'dart'
        :FlutterRun
    else
        set splitbelow
        :sp
        :term chromium %
    endif
endfunc
call plug#begin()
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'mhinz/vim-startify'
Plug 'preservim/nerdcommenter'
Plug 'tpope/vim-surround'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'Chiel92/vim-autoformat'
Plug 'Yggdroot/indentLine'
Plug 'liuchengxu/vista.vim'
Plug 'francoiscabrol/ranger.vim'
Plug 'rhysd/accelerated-jk'
Plug 'ryanoasis/vim-devicons'
Plug 'lilydjwg/colorizer'
Plug 'kien/rainbow_parentheses.vim'
Plug 'liuchengxu/vim-clap', {'do': 'cargo build --release'}
Plug 'sheerun/vim-polyglot'
Plug 'numirias/semshi', {'do': ':UpdateRemotePlugins'}
Plug 'turbio/bracey.vim'
Plug 'dart-lang/dart-vim-plugin'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'lilydjwg/fcitx.vim'
Plug 'dkarter/bullets.vim'
Plug 'dhruvasagar/vim-table-mode'
Plug 'bling/vim-bufferline'
call plug#end()
"
" ---  coc.nvim  ---
"
if has("patch-8.1.1564")
    " Recently vim can merge signcolumn and number column into one
    set signcolumn=number
else
    set signcolumn=yes
endif
function! s:show_documentation()
    if (index(['vim','help'], &filetype) >= 0)
        execute 'h '.expand('<cword>')
    else
        call CocAction('doHover')
    endif
endfunction
autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
    autocmd!
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
set hidden
set nobackup
set nowritebackup
set cmdheight=2
set updatetime=300
set shortmess+=c
if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif
inoremap <silent><expr> <A-n>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><A-N> pumvisible() ? "\<C-p>" : "\<C-h>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
inoremap <silent><expr> <TAB>
            \ pumvisible() ? coc#_select_confirm() :
            \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<tab>'
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>y :<C-u>CocList -A --normal yank<cr>
let g:coc_global_extensions = ["coc-pairs", "coc-css","coc-highlight", "coc-html", "coc-json", "coc-snippets", "coc-vimlsp", "coc-python", "coc-lists", "coc-tsserver","coc-translator", "coc-rust-analyzer", "coc-rls", "coc-git", "coc-java", "coc-vimtex", "coc-go", "coc-emmet","coc-diagnostic", "coc-sql", "coc-sh", "coc-clangd",  "coc-yaml", "coc-xml", "coc-explorer", "coc-flutter-tools", "coc-yank"]
nmap <Leader>w <Plug>(coc-translator-p)
vmap <Leader>w <Plug>(coc-translator-pv)
nmap <Leader>r <Plug>(coc-translator-r)
vmap <Leader>r <Plug>(coc-translator-rv)
nmap <Leader>e :CocCommand explorer<CR>
nmap <Leader>sw :CocList grep<CR>
autocmd FileType markdown let b:coc_suggest_disable = 1
autocmd FileType txt let b:coc_suggest_disable = 1
let g:markdown_fenced_languages = [
            \ 'vim',
            \ 'help'
            \]

"
" ---  vim-airline  ---
"
let g:airline#extensions#coc#enabled = 1
" let g:airline#extensions#tabline#enabled = 0
" let g:airline#extensions#tabline#left_sep = ' '
" let g:airline#extensions#tabline#left_alt_sep = '|'
let g:airline_mode_map = {
            \ '__'     : '-',
            \ 'c'      : 'C',
            \ 'i'      : 'I',
            \ 'ic'     : 'I',
            \ 'ix'     : 'I',
            \ 'n'      : 'N',
            \ 'multi'  : 'M',
            \ 'ni'     : 'N',
            \ 'no'     : 'N',
            \ 'R'      : 'R',
            \ 'Rv'     : 'R',
            \ 's'      : 'S',
            \ 'S'      : 'S',
            \ ''     : 'S',
            \ 't'      : 'T',
            \ 'v'      : 'V',
            \ 'V'      : 'V',
            \ ''     : 'V',
            \ }
let g:airline_theme= "deus"
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#overwrite_variables = 1
let g:airline_symbols_ascii = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'


"
" ---  vim-autoformat  ---
"
noremap F :Autoformat<CR>




"
" ---  indentLine  ---
"
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_enabled = 0
autocmd filetype python let g:indentLine_enabled = 0





"
" ---  vista  ----
"
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]



"
" ---  ranger.vim  ---
"
nmap <leader>f :Ranger<CR>




"
" ---  accelerated  ---
"

nmap j <Plug>(accelerated_jk_gj_position)
nmap k <Plug>(accelerated_jk_gk_position)



"
" ---  nerdcommenter  ---
"
let g:NERDSpaceDelims = 1
map ,cc <leader>cc
map ,cu <leader>cu




"
" ---  rainbow_parentheses  ---
"
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['black',       'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0


"
" ---  vim-startify  ---
"

let g:startify_lists = [
            \ { 'type': 'files',     'header': ['   MRU']            },
            \ { 'type': 'sessions',  'header': ['   Sessions']       },
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
            \ ]

" let g:startify_bookmarks = [ {'c': '~/.vimrc'}, '~/.zshrc' ]
let g:startify_bookmarks = [ "~/.config/nvim/coc-settings.json", '~/.zshrc', "~/.config/awesome/rc.lua", "~/.config/picom.conf", "~/.config/i3/config" ]

let g:startify_custom_header =
            \startify#center(
            \[
            \'         _             _            _      _          _        _         _   _       ',
            \'        /\ \     _    /\ \         /\ \   /\ \    _ / /\      /\ \      /\_\/\_\ _   ',
            \'       /  \ \   /\_\ /  \ \       /  \ \  \ \ \  /_/ / /      \ \ \    / / / / //\_\ ',
            \'      / /\ \ \_/ / // /\ \ \     / /\ \ \  \ \ \ \___\/       /\ \_\  /\ \/ \ \/ / / ',
            \'     / / /\ \___/ // / /\ \_\   / / /\ \ \ / / /  \ \ \      / /\/_/ /  \____\__/ /  ',
            \'    / / /  \/____// /_/_ \/_/  / / /  \ \_\\ \ \   \_\ \    / / /   / /\/________/   ',
            \'   / / /    / / // /____/\    / / /   / / / \ \ \  / / /   / / /   / / /\/_// / /    ',
            \'  / / /    / / // /\____\/   / / /   / / /   \ \ \/ / /   / / /   / / /    / / /     ',
            \' / / /    / / // / /______  / / /___/ / /     \ \ \/ /___/ / /__ / / /    / / /      ',
            \'/ / /    / / // / /_______\/ / /____\/ /       \ \  //\__\/_/___\\/_/    / / /       ',
            \'\/_/     \/_/ \/__________/\/_________/         \_\/ \/_________/        \/_/        ',
            \])
" let g:startify_custom_header =
" \startify#center(
" \[
" \'__/\\\\\_____/\\\__/\\\\\\\\\\\\\\\_______/\\\\\_______/\\\________/\\\__/\\\\\\\\\\\__/\\\\____________/\\\\_        ',
" \' _\/\\\\\\___\/\\\_\/\\\///////////______/\\\///\\\____\/\\\_______\/\\\_\/////\\\///__\/\\\\\\________/\\\\\\_       ',
" \'  _\/\\\/\\\__\/\\\_\/\\\_______________/\\\/__\///\\\__\//\\\______/\\\______\/\\\_____\/\\\//\\\____/\\\//\\\_      ',
" \'   _\/\\\//\\\_\/\\\_\/\\\\\\\\\\\______/\\\______\//\\\__\//\\\____/\\\_______\/\\\_____\/\\\\///\\\/\\\/_\/\\\_     ',
" \'    _\/\\\\//\\\\/\\\_\/\\\///////______\/\\\_______\/\\\___\//\\\__/\\\________\/\\\_____\/\\\__\///\\\/___\/\\\_    ',
" \'     _\/\\\_\//\\\/\\\_\/\\\_____________\//\\\______/\\\_____\//\\\/\\\_________\/\\\_____\/\\\____\///_____\/\\\_   ',
" \'      _\/\\\__\//\\\\\\_\/\\\______________\///\\\__/\\\________\//\\\\\__________\/\\\_____\/\\\_____________\/\\\_  ',
" \'       _\/\\\___\//\\\\\_\/\\\\\\\\\\\\\\\____\///\\\\\/__________\//\\\________/\\\\\\\\\\\_\/\\\_____________\/\\\_ ',
" \'        _\///_____\/////__\///////////////_______\/////_____________\///________\///////////__\///______________\///__',
" \])
"
function! StartifyEntryFormat()
    return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction



"
" ---  vim-clap  ---
"
let g:clap_theme = 'solarizd_light'
nnoremap <Leader>ss :Clap grep<CR>
nnoremap <Leader>sf :Clap filer<CR>
nnoremap <Leader>sb :Clap buffers<CR>
nnoremap <Leader>sh :Clap hist/<CR>
nnoremap <Leader>sc :Clap hist:<CR>
nnoremap <Leader>sl :Clap history<CR>




"
" ---  vim-visual-multi  ---
"
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n




