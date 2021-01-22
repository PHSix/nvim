local vim = vim
vim.cmd("autocmd filetype help execute('on')")

vim.cmd("augroup cursorline_display")
vim.cmd("autocmd!")
vim.cmd("autocmd WinLeave * setlocal nocursorline")
vim.cmd("augroup END")



vim.cmd("augroup markdown_snippets")
vim.cmd("autocmd!")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,, <++>")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,e <esc>/<++><cr>:nohlsearch<cr>c4l")
vim.cmd("autocmd Filetype markdown inoremap <buffer> <silent> ,f <Esc>/<++><CR>:nohlsearch<CR>c4l")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,s <esc>/ <++><cr>:nohlsearch<cr>c5l")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,- ---<enter><enter>")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,b **** <++><esc>F*hi")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,x ~~~~ <++><esc>F~hi")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,q `` <++><esc>F`i")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,c ```<enter><++><enter>```<enter><enter><++><esc>4ka")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,w - [ ] <enter><++><esc>kA")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,u <u></u><++><esc>F/hi")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,p ![](<++>) <enter><++><esc>kF[a")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,l [](<++>) <++><esc>F[a")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,1 #<space><enter><++><esc>kA")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,2 ##<space><enter><++><esc>kA")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,3 ###<space><enter><++><esc>kA")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,4 ####<space><enter><++><esc>kA")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,t <c-r>=strftime('%y-%m-%d %h:%m:%s')<cr>")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,g {% web  <++> %} <++><esc>fb2li")
vim.cmd("autocmd filetype markdown inoremap <buffer> <silent> ,d {% download  <++> %} <++><esc>fd2li")
vim.cmd("augroup END")


vim.cmd("augroup todo_comments")
vim.cmd('autocmd filetype vim inoremap <buffer> <silent>  <C-t> " TODO:')
vim.cmd("autocmd filetype go inoremap <buffer> <silent>  <C-t> // TODO:")
vim.cmd("autocmd filetype python inoremap <buffer> <silent>  <C-t> # TODO:")
vim.cmd("autocmd filetype c inoremap <buffer> <silent>  <C-t> // TODO:")
vim.cmd("autocmd filetype cpp inoremap <buffer> <silent>  <C-t> // TODO:")
vim.cmd("autocmd filetype lua inoremap <buffer> <silent>  <C-t> -- TODO:")
vim.cmd("augroup END")


vim.cmd("augroup WinOpen")
vim.cmd("autocmd filetype help execute('on')")
vim.cmd("augroup END")

--vim.cmd("au BufReadPre * execute('`.')")

