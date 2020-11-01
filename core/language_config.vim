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
        let g:mkdp_browser = 'surf'
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
        :CocCommand flutter.run
    elseif &filetype == 'vim'
        :source %
    elseif &filetype == 'lua'
        :sp
        :term lua %
    else
        set splitbelow
        :sp
        :term chromium %
    endif
endfunc
