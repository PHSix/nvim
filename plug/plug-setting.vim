"
" ---  vim-autoformat  ---
"
noremap F :Autoformat<CR>


"
" ---  vista  ----
"
let g:vista_icon_indent = ["╰─▸ ", "├─▸ "]



"
" ---  ranger.vim  ---
"
nmap <leader>f :Ranger<CR>




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
" ---  vim-hello-world  ---
"
let g:helloword_vocabulary_path = "~/.config/nvim/plugged/vim-hello-word/test/CET6.json"


"
"  ---  spaceline  ---
"
let g:spaceline_seperate_style= 'arrow'



"
" ---  vim-buffet  ---
"
" nmap <leader>1 <Plug>BuffetSwitch(1)
" nmap <leader>2 <Plug>BuffetSwitch(2)
" nmap <leader>3 <Plug>BuffetSwitch(3)
" nmap <leader>4 <Plug>BuffetSwitch(4)
" nmap <leader>5 <Plug>BuffetSwitch(5)
" nmap <leader>6 <Plug>BuffetSwitch(6)
" nmap <leader>7 <Plug>BuffetSwitch(7)
" nmap <leader>8 <Plug>BuffetSwitch(8)
" nmap <leader>9 <Plug>BuffetSwitch(9)
" nmap <leader>0 <Plug>BuffetSwitch(10)
" let g:buffet_always_show_tabline = 1
" let g:buffet_powerline_separators = 1
" let g:buffet_left_trunc_icon = "<"
" let g:buffet_right_trunc_icon = ">"
" let g:buffet_tab_icon = " "
" let g:buffet_tab_icon = " "
" let g:buffet_tab_icon = " "
" let g:buffet_tab_icon = " "
" let g:buffet_tab_icon = "🪐"
" let g:buffet_tab_icon = "♓"
" let g:buffet_tab_icon = "🚀"
" let g:buffet_tab_icon = "✈️ "
" let g:buffet_tab_icon = "🛰️ "
" let g:buffet_tab_icon = "⚡"
" let g:buffet_tab_icon = "🌈"
" let g:buffet_tab_icon = "🌠"
" let g:buffet_tab_icon = "🌌"
" let g:buffet_tab_icon = "🌀"
" let g:buffet_tab_icon = "=>"
" let g:buffet_tab_icon = "🌵"




"
" --- wildfire ---
"

let g:wildfire_objects = ["i'", 'i"', "i)", "i]", "i}", "ip", "it"]




"
" ---  fzy  ---
"
function! FzyCommand(choice_command, vim_command)
    try
        let output = system(a:choice_command . " | fzy ")
    catch /Vim:Interrupt/
        " Swallow errors from ^C, allow redraw! below
    endtry
    redraw!
    if v:shell_error == 0 && !empty(output)
        exec a:vim_command . ' ' . output
    endif
endfunction

nnoremap <leader>ze :call FzyCommand("find . -type f", ":e")<cr>
nnoremap <leader>zv :call FzyCommand("find . -type f", ":vs")<cr>
nnoremap <leader>zs :call FzyCommand("find . -type f", ":sp")<cr>




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

"
" ---  antovim  ---
"
nnoremap <leader>aa :Antovim<CR>



" nnoremap <Leader>p <cmd>lua require'telescope.builtin'.find_files{}<CR>
nnoremap <Leader>p <cmd>lua require'telescope.builtin'.git_files{}<CR>


"
" ---  galaxyline  ---
"
execute("lua require(\"eviline\")")


"
" ---  defx.nvim  ---
"
call defx#custom#option('_', {
            \'winwidth': 30,
            \'split': 'vertical',
            \'direction': 'topleft',
            \'show_ignored_files': 0,
            \'buffer_name': '',
            \'toggle': 1,
            \'resume': 1
            \})
nnoremap <leader>e :Defx<CR>
autocmd FileType defx call s:defx_mappings()

function! s:defx_mappings() abort
    nnoremap <silent><buffer><expr> o     <SID>defx_toggle_tree()                    " 打开或者关闭文件夹，文件
    nnoremap <silent><buffer><expr> zh     defx#do_action('toggle_ignored_files')     " 显示隐藏文件
    nnoremap <silent><buffer><expr> <C-r>  defx#do_action('redraw')
    nnoremap <silent><buffer><expr> y defx#do_action('copy')
    nnoremap <silent><buffer><expr> x defx#do_action('move')
    nnoremap <silent><buffer><expr> mk defx#do_action('new_file')
    nnoremap <silent><buffer><expr> q defx#do_action('quit')
    nnoremap <silent><buffer><expr> d defx#do_action('remove_trash')
    nnoremap <silent><buffer><expr> v defx#do_action('toggle_select')
    nnoremap <silent><buffer><expr> V defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> u defx#do_action('cd', '..')
endfunction
function! s:defx_toggle_tree() abort
    " Open current file, or toggle directory expand/collapse
    if defx#is_directory()
        return defx#do_action('open_or_close_tree')
    endif
    return defx#do_action('multi', ['drop'])
endfunction
let g:defx_icons_enable_syntax_highlight = 1
let g:defx_icons_column_length = 1
let g:defx_icons_directory_icon = ''
let g:defx_icons_mark_icon = '*'
let g:defx_icons_copy_icon = ''
let g:defx_icons_move_icon = ''
let g:defx_icons_parent_icon = ''
let g:defx_icons_default_icon = ''
let g:defx_icons_directory_symlink_icon = ''
" Options below are applicable only when using "tree" feature
let g:defx_icons_root_opened_tree_icon = ''
let g:defx_icons_nested_opened_tree_icon = ''
let g:defx_icons_nested_closed_tree_icon = ''
hi default link DefxIconsMarkIcon Statement
hi default link DefxIconsCopyIcon WarningMsg
hi default link DefxIconsMoveIcon ErrorMsg
hi default link DefxIconsDirectory Directory
hi default link DefxIconsParentDirectory Directory
hi default link DefxIconsSymlinkDirectory Directory
hi default link DefxIconsOpenedTreeIcon Directory
hi default link DefxIconsNestedTreeIcon Directory
hi default link DefxIconsClosedTreeIcon Directory


nnoremap <leader>1 :call MyBufSwitch(0)<CR>
nnoremap <leader>2 :call MyBufSwitch(1)<CR>
nnoremap <leader>3 :call MyBufSwitch(2)<CR>
nnoremap <leader>4 :call MyBufSwitch(3)<CR>

" fzf
nnoremap <leader>[ :Buffers<CR>

source ~/.config/nvim/plug/coc/coc_config.vim


" asynctasks
let g:asyncrun_open = 9
let g:asynctasks_rtp_config = "asynctasks.ini"
nnoremap R :AsyncTask file-run<CR>
