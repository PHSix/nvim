
"
" ---  coc.nvim  ---
"
set hidden
set nobackup
set nowritebackup
" set updatetime=100
set shortmess+=c
autocmd CursorHold * silent call CocActionAsync('highlight')
augroup mygroup
    autocmd!
    autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
    autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end
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
let g:coc_snippet_next = '<C-n>'
let g:coc_snippet_prev=  '<C-p>'
inoremap <silent><expr> <c-l> coc#refresh()
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>y :<C-u>CocList -A --normal yank<cr>
nmap <Leader>w <Plug>(coc-translator-p)
vmap <Leader>w <Plug>(coc-translator-pv)
nmap <Leader>r <Plug>(coc-translator-r)
vmap <Leader>r <Plug>(coc-translator-rv)
nmap <Leader>sw :CocList grep<CR>
autocmd FileType markdown let b:coc_suggest_disable = 1
autocmd FileType txt let b:coc_suggest_disable = 1
autocmd FileType vimwiki let b:coc_suggest_disable = 1
autocmd FileType gomod let b:coc_suggest_disable = 1
let g:markdown_fenced_languages = [
            \ 'vim',
            \ 'help'
            \]
function! s:cocActionsOpenFromSelected(type) abort
  execute 'CocCommand actions.open ' . a:type
endfunction
xmap <silent> <leader>x :<C-u>execute 'CocCommand actions.open ' . visualmode()<CR>
nmap <silent> <leader>x :<C-u>set operatorfunc=<SID>cocActionsOpenFromSelected<CR>g@
autocmd CursorHold * silent call CocActionAsync('highlight')
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
let g:coc_global_extensions = [
            \"coc-pairs",
            \"coc-css",
            \"coc-highlight",
            \"coc-html",
            \"coc-json",
            \"coc-snippets",
            \"coc-vimlsp",
            \"coc-python",
            \"coc-lists",
            \"coc-tsserver",
            \"coc-translator",
            \"coc-rust-analyzer",
            \"coc-rls",
            \"coc-git",
            \"coc-java",
            \"coc-vimtex",
            \"coc-emmet",
            \"coc-diagnostic",
            \"coc-sql",
            \"coc-sh",
            \"coc-clangd",
            \"coc-yaml",
            \"coc-xml",
            \"coc-flutter-tools",
            \"coc-yank",
            \"coc-actions",
            \"coc-cmake",
            \"coc-todolist",
            \"coc-template",
            \"coc-html",
            \]
