"
" ---  vim-autoformat  ---
"
noremap F :Autoformat<CR>


"
" ---  vista  ----
"
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]



"
" ---  accelerated  ---
"

nmap j <Plug>(accelerated_jk_gj_position)
nmap k <Plug>(accelerated_jk_gk_position)



"
" ---  nerdcommenter  ---
"
let g:NERDSpaceDelims = 1
map ,cc <leader>cc
map ,cu <leader>cu




"
" ---  rainbow_parentheses  ---
"
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces
let g:rbpt_colorpairs = [
            \ ['brown',       'RoyalBlue3'],
            \ ['Darkblue',    'SeaGreen3'],
            \ ['darkgray',    'DarkOrchid3'],
            \ ['darkgreen',   'firebrick3'],
            \ ['darkcyan',    'RoyalBlue3'],
            \ ['darkred',     'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['brown',       'firebrick3'],
            \ ['gray',        'RoyalBlue3'],
            \ ['black',       'SeaGreen3'],
            \ ['darkmagenta', 'DarkOrchid3'],
            \ ['Darkblue',    'firebrick3'],
            \ ['darkgreen',   'RoyalBlue3'],
            \ ['darkcyan',    'SeaGreen3'],
            \ ['darkred',     'DarkOrchid3'],
            \ ['red',         'firebrick3'],
            \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0


"
" ---  vim-visual-multi  ---
"
let g:VM_maps                       = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n
let g:VM_maps["Add Cursor Down"]    = '<C-Down>'
let g:VM_maps["Add Cursor Up"]      = '<C-Up>'




"
" ---  markdown-preview.nvim  ---
"
let g:mkdp_browser = 'chromium'




" dashboard.nvim
let g:dashboard_default_executive ='fzf'
nnoremap <silent> <c-f>s :<C-u>SessionSave<CR>
nnoremap <silent> <c-f>l :<C-u>SessionLoad<CR>
nnoremap <silent> <c-f>h :DashboardFindHistory<CR>
nnoremap <silent> <c-f>f :DashboardFindFile<CR>
nnoremap <silent> <c-f>c :DashboardChangeColorscheme<CR>
nnoremap <silent> <c-f>w :DashboardFindWord<CR>
nnoremap <silent> <c-f>b :DashboardJumpMark<CR>
nnoremap <silent> <c-f>n :DashboardNewFile<CR>

let g:dashboard_custom_shortcut={
            \ 'last_session'       : '<Ctrl-f>l',
            \ 'find_history'       : '<Ctrl-f>h',
            \ 'find_file'          : '<Ctrl-f>f',
            \ 'new_file'           : '<Ctrl-f>n',
            \ 'change_colorscheme' : '<Ctrl-f>c',
            \ 'find_word'          : '<Ctrl-f>w',
            \ 'book_marks'         : '<Ctrl-f>b',
            \ }

"
" ---  vim-easy-aligen
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)




"
" ---  vim-mundo  ---
"
nnoremap <leader>uu :MundoToggle<CR>
nnoremap <leader>uh :MundoHide<CR>
nnoremap <leader>us :MundoShow<CR>


"
"  ---  spaceline  ---
"
let g:spaceline_seperate_style= 'arrow'


"
" --- wildfire ---
"

let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "ip", "it"]





"
" ---  vim-go  ---
"
let g:go_version_warning = 0
let g:go_echo_go_info = 0
let g:go_fmt_autosave = 0
let g:go_doc_popup_window = 1
let g:go_def_mapping_enabled = 0
let g:go_template_autocreate = 0
let g:go_textobj_enabled = 0
let g:go_auto_type_info = 1
let g:go_def_mapping_enabled = 0
let g:go_doc_keywordprg_enabled = 0
let g:go_statusline_duration = 0


"
" ---  vimwiki  ---
"
nnoremap <leader>t :VimwikiToggleListItem<CR>
let wiki = {}
let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp', "go": "go"}
let g:vimwiki_folding = ''



" asynctasks
let g:asyncrun_open = 9
let g:asynctasks_rtp_config = "asynctasks.ini"
nnoremap <silent> R :AsyncTask file-run<CR>




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
set signcolumn=yes
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
nnoremap <silent> K :call <SID>show_documentation()<CR>
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~# '\s'
endfunction
let g:coc_snippet_next = '<C-n>'
let g:coc_snippet_prev=  '<C-p>'
inoremap <silent><expr> <c-l> coc#refresh()
nmap <silent> gk <Plug>(coc-diagnostic-prev)
nmap <silent> gj <Plug>(coc-diagnostic-next)
nnoremap <silent> <leader>y :<C-u>CocList -A --normal yank<cr>
nmap <Leader>wo <Plug>(coc-translator-p)
vmap <Leader>wo <Plug>(coc-translator-p)
vmap <Leader>wv <Plug>(coc-translator-pv)
nmap <Leader>r <Plug>(coc-translator-r)
vmap <Leader>r <Plug>(coc-translator-rv)
nmap <Leader>sw :CocList grep<CR>
autocmd FileType markdown let b:coc_suggest_disable = 1
" autocmd FileType txt let b:coc_suggest_disable = 1
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
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)
nmap <leader>rn <Plug>(coc-rename)
nmap <leader>ca  <Plug>(coc-codeaction)
let g:coc_global_extensions = [
            \"coc-pairs",
            \"coc-css",
            \"coc-html",
            \"coc-json",
            \"coc-snippets",
            \"coc-vimlsp",
            \"coc-lists",
            \"coc-tsserver",
            \"coc-translator",
            \"coc-rls",
            \"coc-git",
            \"coc-emmet",
            \"coc-diagnostic",
            \"coc-sh",
            \"coc-flutter-tools",
            \"coc-yank",
            \"coc-actions",
            \"coc-html",
            \"coc-cmake",
            \"coc-clangd",
            \"coc-vetur",
            \"coc-marketplace",
            \"coc-explorer"
            \]

nmap <leader>o <Plug>(coc-refactor)
let g:coc_fzf_preview_toggle_key = '?'
let g:coc_fzf_preview = ''
let g:coc_fzf_opts = []
let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
call coc_fzf#common#add_list_source('fzf-buffers', 'display open buffers', 'Buffers')


