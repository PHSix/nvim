set showtabline=0

function s:afterLeaveBuffer() abort
	let ft = &filetype
	if ft == 'startify'
		set showtabline=2
	endif
endfunction


autocmd BufLeave * ++once call s:afterLeaveBuffer()
