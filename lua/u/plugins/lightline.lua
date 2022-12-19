vim.g.lightline = {
	colorscheme = 'one',
	tabline = {
		left = { { 'buffers' } },
		right = { { 'close' } }
	},
	component_expand = {
		buffers = 'lightline#bufferline#buffers'
	},
	active = {
		left = { { 'mode', 'paste' }, { 'readonly', 'filename', 'modified' },
			{ 'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' },
			{ 'coc_status' },
		}
	},
	component_type = {
		buffers = 'tabsel'
	}
}
vim.call('lightline#coc#register')
vim.g['lightline#bufferline#show_number'] = 2

-- vim.cmd([[
-- " let g:lightline = {
-- "       \ 'colorscheme': 'one',
-- "       \ 'tabline': {
-- "       \   'left': [ ['buffers'] ],
-- "       \   'right': [ ['close'] ]
-- "       \ },
-- "       \ 'component_expand': {
-- "       \   'buffers': 'lightline#bufferline#buffers'
-- "       \ },
-- " 	  \ 'active': {
-- " 	  \   'left': [ [ 'mode', 'paste' ],
-- "       \             [ 'readonly', 'filename', 'modified' ], [  'coc_info', 'coc_hints', 'coc_errors', 'coc_warnings', 'coc_ok' ], [ 'coc_status'  ] ]
-- " 	  \ },
-- "       \ 'component_type': {
-- "       \   'buffers': 'tabsel'
-- "       \ }
-- "       \ }
-- call lightline#coc#register()
-- let g:lightline#bufferline#show_number = 2
--
-- nmap <Leader>1 <Plug>lightline#bufferline#go(1)
-- nmap <Leader>2 <Plug>lightline#bufferline#go(2)
-- nmap <Leader>3 <Plug>lightline#bufferline#go(3)
-- nmap <Leader>4 <Plug>lightline#bufferline#go(4)
-- nmap <Leader>5 <Plug>lightline#bufferline#go(5)
-- nmap <Leader>6 <Plug>lightline#bufferline#go(6)
-- nmap <Leader>7 <Plug>lightline#bufferline#go(7)
-- nmap <Leader>8 <Plug>lightline#bufferline#go(8)
-- nmap <Leader>9 <Plug>lightline#bufferline#go(9)
-- nmap <Leader>0 <Plug>lightline#bufferline#go(10)
-- ]])
