function Add_fenhao() abort
  :Autoformat
  let b:line_count = line("$")
  let flag_hao = 0
  for i in range(b:line_count)
    let llb = getline(i)
    let llbend = llb[len(llb) - 1]
    if llb != ""  && llbend != "[" && llbend != ";" && llbend != ","
      call setline(i, llb . ';')
    endif
  endfor
endfunction
function Delete_space(line) abort
  for i in range(len(line))
    if line[i] == " "
    endif
  endfor
endfunction;


function! OpenFloatingWin()
  let height = &lines - 3
  let width = float2nr(&columns - (&columns * 2 / 10))
  let col = float2nr((&columns - width) / 2)

  "Set the position, size, etc. of the floating window.
  "The size configuration here may not be so flexible, and there's room for further improvement.
  let opts = {
        \ 'relative': 'editor',
        \ 'row': height * 0.3,
        \ 'col': col + 30,
        \ 'width': width * 2 / 3,
        \ 'height': height / 2
        \ }

  let buf = nvim_create_buf(v:false, v:true)
  let win = nvim_open_win(buf, v:true, opts)

  "Set Floating Window Highlighting
  call setwinvar(win, '&winhl', 'Normal:Pmenu')

  setlocal
        \ buftype=nofile
        \ nobuflisted
        \ bufhidden=hide
        \ nonumber
        \ norelativenumber
        \ signcolumn=no
endfunction

