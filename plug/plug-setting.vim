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
nnoremap <Leader>ss :Clap grep<CR>
nnoremap <Leader>sf :Clap filer<CR>
nnoremap <Leader>sb :Clap buffers<CR>
nnoremap <Leader>sh :Clap hist/<CR>
nnoremap <Leader>sc :Clap hist:<CR>
nnoremap <Leader>sl :Clap history<CR>




"
" ---  vim-visual-multi  ---
"
let g:VM_maps = {}
let g:VM_maps['Find Under']         = '<C-d>'           " replace C-n
let g:VM_maps['Find Subword Under'] = '<C-d>'           " replace visual C-n




"
" ---  markdown-preview.nvim  ---
"
let g:mkdp_browser = 'chrome'


source ~/.config/nvim/plug/coc/coc_config.vim


" dashboard.nvim
let g:dashboard_default_executive ='clap'
let g:dashboard_custom_shortcut={
            \ 'last_session'       : 'SPC s l',
            \ 'find_history'       : 'SPC f h',
            \ 'find_file'          : 'SPC f f',
            \ 'new_file'           : 'SPC c n',
            \ 'change_colorscheme' : 'SPC t c',
            \ 'find_word'          : 'SPC f a',
            \ 'book_marks'         : 'SPC f b',
            \ }
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
noremap <leader>vs :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
