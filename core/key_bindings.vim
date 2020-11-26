nmap S :w<CR>
nmap X :q!<CR>
nmap <leader>w :w<CR>
nmap <leader>nl :noh<cr>
noremap <A-j> 5j
noremap <A-k> 5k
noremap <A-h> 5h
noremap <A-l> 5l
noremap <C-j> 5j
noremap <C-k> 5k
noremap <C-h> 5h
noremap <C-l> 5l
nmap <leader>nvim :e ~/.config/nvim/init.vim
nmap ,lg :term lazygit<cr>
map <space> <leader>
nmap <A-n> :bp<cr>
nmap <A-b> :bn<cr>
nmap <C-[> :bp<cr>
nmap <C-]> :bn<cr>
nmap <leader>h <C-w>h
nmap <leader>j <C-w>j
nmap <leader>k <C-w>k
nmap <leader>l <C-w>l
nmap <leader>sl :set splitright<CR>:vsplit<CR>
nmap <leader>sh :set nosplitright<CR>:vsplit<CR>
nmap <leader>sj :set nosplitbelow<CR>:split<CR>
nmap <leader>sk :set splitbelow<CR>:split<CR>
nmap <leader>wl <C-w>t<C-w>L
nmap <leader>wh <C-w>t<C-w>H
nmap <leader>wj <C-w>t<C-w>J
nmap <leader>wk <C-w>t<C-w>K
nnoremap <leader>K :resize +5<CR>
nnoremap <leader>J :resize -5<CR>
nnoremap <leader>L :vertical resize +5<CR>
nnoremap <leader>H :vertical resize -5<CR>
map ff zf  " 创建折叠
map fo zO  " 打开折叠
map fO zo
map fm zm  " 全部折叠
map fn zn  " 全部展开
map fy "+y
nmap <leader>; $a;<ESC>
vmap <leader>; $A;<ESC>
map gl $
map gh ^
nnoremap <leader>bl :bn<cr>
nnoremap <leader>bh :bp<cr>
nmap <ESC> <ESC>
nmap <CR> <CR>


nmap Q :call Buffer_close()<CR>
nmap <leader>q :call Buffer_close()<CR>
function Buffer_close()
    let str = execute(":ls")
    if len(str) > 90
        let name = bufname()
        if name[:4] == "term:"
            execute(":q")
        else
            execute(":bwipeout")
        endif
    else
        execute(":q")
    endif
endfunction
command! -nargs=1 -complete=help H help <args> | silent only
