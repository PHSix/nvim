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
