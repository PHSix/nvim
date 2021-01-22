lua require("myluamodule")
autocmd BufReadPost *
     \ if line("'\"") > 0 && line("'\"") <= line("$") |
     \   exe "normal! g`\"" |
     \ endif

let g:BufL = []


augroup cursorline_display
  autocmd!
  autocmd WinLeave * setlocal nocursorline
augroup END
augroup todo_comments
  autocmd filetype vim inoremap <buffer> <silent>  <C-t> " TODO:
  autocmd filetype go inoremap <buffer> <silent>  <C-t> // TODO:
  autocmd filetype python inoremap <buffer> <silent>  <C-t> # TODO:
  autocmd filetype c inoremap <buffer> <silent>  <C-t> // TODO:
  autocmd filetype cpp inoremap <buffer> <silent>  <C-t> // TODO:
  autocmd filetype lua inoremap <buffer> <silent>  <C-t> -- TODO:
augroup END

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

augroup WinOpen
  autocmd filetype help execute('on')
augroup END
let g:dashboard_custom_shortcut={
            \ 'last_session'       : '<Ctrl-f>l',
            \ 'find_history'       : '<Ctrl-f>h',
            \ 'find_file'          : '<Ctrl-f>f',
            \ 'new_file'           : '<Ctrl-f>n',
            \ 'change_colorscheme' : '<Ctrl-f>c',
            \ 'find_word'          : '<Ctrl-f>w',
            \ 'book_marks'         : '<Ctrl-f>b',
            \ }


augroup markdown_snippets
  autocmd!
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
augroup END

if !empty(glob("~/.local/share/nvim/site/pack/packer/start/coc.nvim"))
  autocmd CursorHold * silent call CocActionAsync('highlight')
  augroup mygroup
      autocmd!
      autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
      autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
  augroup end
endif
if has("patch-8.1.1564")
    set signcolumn=number
else
    set signcolumn=yes
endif
inoremap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "<CR>"
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction

