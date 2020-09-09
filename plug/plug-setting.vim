"
" ---  vim-airline  ---
"
let g:airline#extensions#coc#enabled = 0
let g:airline#extensions#tabline#enabled = 0
let g:airline#extensions#ale#enabled = 0
let g:airline_mode_map = {
            \ '__'     : '-',
            \ 'c'      : 'C',
            \ 'i'      : 'I',
            \ 'ic'     : 'I',
            \ 'ix'     : 'I',
            \ 'n'      : 'N',
            \ 'multi'  : 'M',
            \ 'ni'     : 'N',
            \ 'no'     : 'N',
            \ 'R'      : 'R',
            \ 'Rv'     : 'R',
            \ 's'      : 'S',
            \ 'S'      : 'S',
            \ ''     : 'S',
            \ 't'      : 'T',
            \ 'v'      : 'V',
            \ 'V'      : 'V',
            \ ''     : 'V',
            \ }
" let g:airline_theme= "deus"
let g:airline_theme = 'forest_night'
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#bufferline#overwrite_variables = 1
let g:airline_symbols_ascii = 1
if !exists('g:airline_symbols')
    let g:airline_symbols = {}
endif
let g:airline_left_sep = ''
let g:airline_left_alt_sep = ''
let g:airline_right_alt_sep = ''
let g:airline_symbols.branch = ''
let g:airline_symbols.readonly = ''
let g:airline_symbols.linenr = '☰'
let g:airline_symbols.maxlinenr = ''
let g:airline_symbols.dirty='⚡'


"
" ---  vim-autoformat  ---
"
noremap F :Autoformat<CR>




"
" ---  indentLine  ---
"
let g:indentLine_char_list = ['|', '¦', '┆', '┊']
let g:indentLine_enabled = 0
autocmd filetype python let g:indentLine_enabled = 0





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
" ---  vim-startify  ---
"

" let g:startify_lists = [
" \ { 'type': 'files',     'header': ['   MRU']            },
" \ { 'type': 'sessions',  'header': ['   Sessions']       },
" \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
" \ ]

" " let g:startify_bookmarks = [ {'c': '~/.vimrc'}, '~/.zshrc' ]
" let g:startify_bookmarks = [ "~/.config/nvim/coc-settings.json", '~/.zshrc', "~/.config/awesome/rc.lua", "~/.config/picom.conf", "~/.config/i3/config" ]

" let g:startify_custom_header =
" \startify#center(
" \[
" \'         _             _            _      _          _        _         _   _       ',
" \'        /\ \     _    /\ \         /\ \   /\ \    _ / /\      /\ \      /\_\/\_\ _   ',
" \'       /  \ \   /\_\ /  \ \       /  \ \  \ \ \  /_/ / /      \ \ \    / / / / //\_\ ',
" \'      / /\ \ \_/ / // /\ \ \     / /\ \ \  \ \ \ \___\/       /\ \_\  /\ \/ \ \/ / / ',
" \'     / / /\ \___/ // / /\ \_\   / / /\ \ \ / / /  \ \ \      / /\/_/ /  \____\__/ /  ',
" \'    / / /  \/____// /_/_ \/_/  / / /  \ \_\\ \ \   \_\ \    / / /   / /\/________/   ',
" \'   / / /    / / // /____/\    / / /   / / / \ \ \  / / /   / / /   / / /\/_// / /    ',
" \'  / / /    / / // /\____\/   / / /   / / /   \ \ \/ / /   / / /   / / /    / / /     ',
" \' / / /    / / // / /______  / / /___/ / /     \ \ \/ /___/ / /__ / / /    / / /      ',
" \'/ / /    / / // / /_______\/ / /____\/ /       \ \  //\__\/_/___\\/_/    / / /       ',
" \'\/_/     \/_/ \/__________/\/_________/         \_\/ \/_________/        \/_/        ',
" \])
" " let g:startify_custom_header =
" " \startify#center(
" " \[
" " \'__/\\\\\_____/\\\__/\\\\\\\\\\\\\\\_______/\\\\\_______/\\\________/\\\__/\\\\\\\\\\\__/\\\\____________/\\\\_        ',
" " \' _\/\\\\\\___\/\\\_\/\\\///////////______/\\\///\\\____\/\\\_______\/\\\_\/////\\\///__\/\\\\\\________/\\\\\\_       ',
" " \'  _\/\\\/\\\__\/\\\_\/\\\_______________/\\\/__\///\\\__\//\\\______/\\\______\/\\\_____\/\\\//\\\____/\\\//\\\_      ',
" " \'   _\/\\\//\\\_\/\\\_\/\\\\\\\\\\\______/\\\______\//\\\__\//\\\____/\\\_______\/\\\_____\/\\\\///\\\/\\\/_\/\\\_     ',
" " \'    _\/\\\\//\\\\/\\\_\/\\\///////______\/\\\_______\/\\\___\//\\\__/\\\________\/\\\_____\/\\\__\///\\\/___\/\\\_    ',
" " \'     _\/\\\_\//\\\/\\\_\/\\\_____________\//\\\______/\\\_____\//\\\/\\\_________\/\\\_____\/\\\____\///_____\/\\\_   ',
" " \'      _\/\\\__\//\\\\\\_\/\\\______________\///\\\__/\\\________\//\\\\\__________\/\\\_____\/\\\_____________\/\\\_  ',
" " \'       _\/\\\___\//\\\\\_\/\\\\\\\\\\\\\\\____\///\\\\\/__________\//\\\________/\\\\\\\\\\\_\/\\\_____________\/\\\_ ',
" " \'        _\///_____\/////__\///////////////_______\/////_____________\///________\///////////__\///______________\///__',
" " \])
" "
" function! StartifyEntryFormat()
" return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
" endfunction



"
" ---  vim-clap  ---
"
let g:clap_theme = 'solarizd_light'
nnoremap <Leader>es :Clap grep<CR>
nnoremap <Leader>ef :Clap filer<CR>
nnoremap <Leader>eb :Clap buffers<CR>
nnoremap <Leader>eh :Clap hist/<CR>
nnoremap <Leader>ec :Clap hist:<CR>
nnoremap <Leader>el :Clap history<CR>




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
let g:mkdp_browser = 'surf'


source ~/.config/nvim/plug/coc/coc_config.vim


" dashboard.nvim
let g:dashboard_default_executive ='clap'
let g:dashboard_custom_header = [
            \'         _             _            _      _          _        _         _   _       ',
            \'        /\ \     _    /\ \         /\ \   /\ \    _ / /\      /\ \      /\_\/\_\ _   ',
            \'       /  \ \   /\_\ /  \ \       /  \ \  \ \ \  /_/ / /      \ \ \    / / / / //\_\ ',
            \'      / /\ \ \_/ / // /\ \ \     / /\ \ \  \ \ \ \___\/       /\ \_\  /\ \/ \ \/ / / ',
            \'     / / /\ \___/ // / /\ \_\   / / /\ \ \ / / /  \ \ \      / /\/_/ /  \____\__/ /  ',
            \'    / / /  \/____// /_/_ \/_/  / / /  \ \_\\ \ \   \_\ \    / / /   / /\/________/   ',
            \'   / / /    / / // /____/\    / / /   / / / \ \ \  / / /   / / /   / / /\/_// / /    ',
            \'  / / /    / / // /\____\/   / / /   / / /   \ \ \/ / /   / / /   / / /    / / /     ',
            \' / / /    / / // / /______  / / /___/ / /     \ \ \/ /___/ / /__ / / /    / / /      ',
            \'/ / /    / / // / /_______\/ / /____\/ /       \ \  //\__\/_/___\\/_/    / / /       ',
            \'\/_/     \/_/ \/__________/\/_________/         \_\/ \/_________/        \/_/        ',
            \ ]


nmap <Leader>bs :<C-u>SessionSave<CR>
nmap <Leader>bl :<C-u>SessionLoad<CR>
nmap <Leader>cn :<C-u>DashboardNewFile<CR>
nnoremap <silent> <Leader>fh :<C-u>Clap history<CR>
nnoremap <silent> <Leader>ff :<C-u>Clap files ++finder=rg --ignore --hidden --files<cr>
nnoremap <silent> <Leader>cc :<C-u>Clap colors<CR>
nnoremap <silent> <Leader>fa :<C-u>Clap grep2<CR>
nnoremap <silent> <Leader>fb :<C-u>Clap marks<CR>

let g:dashboard_custom_shortcut={
            \ 'find_word' : 'SPC f a',
            \ 'find_file' : 'SPC f f',
            \ 'last_session' : 'SPC s l',
            \ 'find_history' : 'SPC f h',
            \ 'new_file' : 'SPC c n',
            \ 'change_colorscheme' : 'SPC t c',
            \ 'book_marks' : 'SPC f b',
            \ }

"
" ---  vim-easy-aligen
"
" Start interactive EasyAlign in visual mode (e.g. vipga)
xmap ga <Plug>(EasyAlign)

" Start interactive EasyAlign for a motion/text object (e.g. gaip)
nmap ga <Plug>(EasyAlign)



"
" ---  vimspector  ---
"
let g:vimspector_enable_mappings = 'HUMAN'
function! s:read_template_into_buffer(template)
    " has to be a function to avoid the extra space fzf#run insers otherwise
    execute '0r ~/.config/nvim/vimspector_json/'.a:template
endfunction
command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
            \   'source': 'ls -1 ~/.config/nvim/vimspector_json',
            \   'down': 20,
            \   'sink': function('<sid>read_template_into_buffer')
            \ })
noremap <leader>dt :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
noremap <leader>dq :VimspectorReset<CR>
noremap <leader>dw :VimspectorReset
noremap <leader>dp <Plug>VimspectorToggleBreakpoint
noremap <leader>dr <Plug>VimspectorRestart
noremap <leader>dg <Plug>VimspectorContinue
let g:vimspector_sidebar_width = 30
let g:vimspector_bottombar_height = 7



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
" ---  defx.nvim  ---
"
autocmd FileType defx call s:defx_my_settings()
function! s:defx_my_settings() abort
    " Define mappings
    nnoremap <silent><buffer><expr> <CR>
                \ defx#is_directory() ?
                \ defx#do_action('open_tree') :
                \ defx#do_action('multi', ['drop'])
    nnoremap <silent><buffer><expr> yy
                \ defx#do_action('copy')
    nnoremap <silent><buffer><expr> dd
                \ defx#do_action('move')
    nnoremap <silent><buffer><expr> p
                \ defx#do_action('paste')
    nnoremap <silent><buffer><expr> l
                \ defx#is_directory() ?
                \ defx#do_action('open') :
                \ defx#do_action('multi', ['drop'])
    nnoremap <silent><buffer><expr> <Space>l
                \ defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> <Space>k
                \ defx#do_action('open', 'vsplit')
    nnoremap <silent><buffer><expr> P
                \ defx#do_action('preview')
    nnoremap <silent><buffer><expr> o
                \ defx#do_action('open_tree', 'toggle')
    nnoremap <silent><buffer><expr> mk
                \ defx#do_action('new_directory')
    nnoremap <silent><buffer><expr> cn
                \ defx#do_action('new_file')
    nnoremap <silent><buffer><expr> M
                \ defx#do_action('new_multiple_files')
    nnoremap <silent><buffer><expr> C
                \ defx#do_action('toggle_columns',
                \                'mark:indent:icon:filename:type:size:time')
    nnoremap <silent><buffer><expr> S
                \ defx#do_action('toggle_sort', 'time')
    nnoremap <silent><buffer><expr> dr
                \ defx#do_action('remove')
    nnoremap <silent><buffer><expr> rn
                \ defx#do_action('rename')
    nnoremap <silent><buffer><expr> !
                \ defx#do_action('execute_command')
    nnoremap <silent><buffer><expr> x
                \ defx#do_action('execute_system')
    nnoremap <silent><buffer><expr> yp
                \ defx#do_action('yank_path')
    nnoremap <silent><buffer><expr> zh
                \ defx#do_action('toggle_ignored_files')
    nnoremap <silent><buffer><expr> ;
                \ defx#do_action('repeat')
    nnoremap <silent><buffer><expr> h
                \ defx#do_action('cd', ['..'])
    " nnoremap <silent><buffer><expr> cd
    " \ defx#do_action('cd')
    nnoremap <silent><buffer><expr> q
                \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <C-m>
                \ defx#do_action('quit')
    nnoremap <silent><buffer><expr> <Space>
                \ defx#do_action('toggle_select') . 'j'
    nnoremap <silent><buffer><expr> a
                \ defx#do_action('toggle_select_all')
    nnoremap <silent><buffer><expr> j
                \ line('.') == line('$') ? 'gg' : 'j'
    nnoremap <silent><buffer><expr> k
                \ line('.') == 1 ? 'G' : 'k'
    nnoremap <silent><buffer><expr> <C-l>
                \ defx#do_action('redraw')
    nnoremap <silent><buffer><expr> <C-g>
                \ defx#do_action('print')
    nnoremap <silent><buffer><expr> cd
                \ defx#do_action('change_vim_cwd')
endfunction



nnoremap <C-m> :Defx -split=vertical -winwidth=35 -direction=topleft<CR>





"
" ---  defx-icons  ---
"
let g:defx_icons_enable_syntax_highlight = 0
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
let g:defx_icons_term_colors = {
\ 'red': 2
\ }
hi default link DefxIconsMarkIcon Statement
hi default link DefxIconsCopyIcon WarningMsg
hi default link DefxIconsMoveIcon ErrorMsg
hi default link DefxIconsDirectory Directory
hi default link DefxIconsParentDirectory Directory
hi default link DefxIconsSymlinkDirectory Directory
hi default link DefxIconsOpenedTreeIcon Directory
hi default link DefxIconsNestedTreeIcon Directory
hi default link DefxIconsClosedTreeIcon Directory


