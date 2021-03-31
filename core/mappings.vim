nmap S :w<CR>
nmap X :q!<CR>
nmap <leader>nl :noh<cr>
noremap <nowait> <A-j> 5j
noremap <nowait> <A-k> 5k
noremap <nowait> <A-h> 5h
noremap <nowait> <A-l> 5l
noremap <nowait> <C-j> 5j
noremap <nowait> <C-k> 5k
noremap <nowait> <C-h> 5h
noremap <nowait> <C-l> 5l
nmap <silent> <leader>nvim :e ~/.config/nvim/init.vim
map <space> <leader>
nmap <nowait><leader>h <C-w>h
nmap <nowait><leader>j <C-w>j
nmap <nowait><leader>k <C-w>k
nmap <nowait><leader>l <C-w>l
nmap <nowait><silent> <leader>sl :set splitright<CR>:vsplit<CR>
nmap <nowait><silent> <leader>sh :set nosplitright<CR>:vsplit<CR>
nmap <nowait><silent> <leader>sj :set nosplitbelow<CR>:split<CR>
nmap <nowait><silent> <leader>sk :set splitbelow<CR>:split<CR>
nmap <nowait><leader>wl <C-w>t<C-w>L
nmap <nowait><leader>wh <C-w>t<C-w>H
nmap <nowait><leader>wj <C-w>t<C-w>J
nmap <nowait><leader>wk <C-w>t<C-w>K
nnoremap <silent> <leader>K :resize +5<CR>
nnoremap <silent> <leader>J :resize -5<CR>
nnoremap <silent> <leader>L :vertical resize +5<CR>
nnoremap <silent> <leader>H :vertical resize -5<CR>
map ff zf  " 创建折叠
map fo zO  " 打开折叠
map fO zo
map fm zm  " 全部折叠
map fn zn  " 全部展开
map fy "+y
nmap <leader>; $a;<ESC>
vmap <leader>; $A;<ESC>
map gl $h
map gh ^
nmap <ESC> <ESC>
nmap <CR> <CR>


nmap <silent> Q :call QuitOrClose()<CR>
function! g:QuitOrClose()
  let l:buflist = split(execute("ls"), "\n")
  if len(l:buflist) == 1 && &filetype != "help"
    :q
  elseif &filetype == "dashboard"
    :q
  else
    :bw
  endif
endfunction


nmap X :bwipeout<CR>


