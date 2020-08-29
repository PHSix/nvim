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
