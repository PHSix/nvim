"
" ---  vim-airline  ---
"
" let g:airline#extensions#coc#enabled = 0
" let g:airline#extensions#tabline#enabled = 0
" let g:airline#extensions#ale#enabled = 0
" let g:airline_mode_map = {
            " \ '__'     : '-',
            " \ 'c'      : 'C',
            " \ 'i'      : 'I',
            " \ 'ic'     : 'I',
            " \ 'ix'     : 'I',
            " \ 'n'      : 'N',
            " \ 'multi'  : 'M',
            " \ 'ni'     : 'N',
            " \ 'no'     : 'N',
            " \ 'R'      : 'R',
            " \ 'Rv'     : 'R',
            " \ 's'      : 'S',
            " \ 'S'      : 'S',
            " \ ''     : 'S',
            " \ 't'      : 'T',
            " \ 'v'      : 'V',
            " \ 'V'      : 'V',
            " \ ''     : 'V',
            " \ }
" " let g:airline_theme= "deus"
" let g:airline_theme = 'forest_night'
" let g:airline#extensions#bufferline#enabled = 1
" let g:airline#extensions#bufferline#overwrite_variables = 1
" let g:airline_symbols_ascii = 1
" if !exists('g:airline_symbols')
    " let g:airline_symbols = {}
" endif
" let g:airline_left_sep = ''
" let g:airline_left_alt_sep = ''
" let g:airline_right_alt_sep = ''
" let g:airline_symbols.branch = ''
" let g:airline_symbols.readonly = ''
" let g:airline_symbols.linenr = '☰'
" let g:airline_symbols.maxlinenr = ''
" let g:airline_symbols.dirty='⚡'


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
nmap <Leader>pl :<C-u>SessionLoad<CR>
nmap <Leader>pn :<C-u>DashboardNewFile<CR>
nnoremap <silent> <Leader>ph :<C-u>Clap history<CR>
nnoremap <silent> <Leader>pf :<C-u>Clap files ++finder=rg --ignore --hidden --files<cr>
nnoremap <silent> <Leader>pc :<C-u>Clap colors<CR>
nnoremap <silent> <Leader>pa :<C-u>Clap grep2<CR>
nnoremap <silent> <Leader>pb :<C-u>Clap marks<CR>

let g:dashboard_custom_shortcut={
            \ 'find_word' : 'SPC p a',
            \ 'find_file' : 'SPC p f',
            \ 'last_session' : 'SPC p l',
            \ 'find_history' : 'SPC p h',
            \ 'new_file' : 'SPC p n',
            \ 'change_colorscheme' : 'SPC p c',
            \ 'book_marks' : 'SPC p b',
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
"  ---  spaceline  ---
"
let g:spaceline_seperate_style= 'arrow'



"
" ---  vim-buffet  ---
"
nmap <leader>1 <Plug>BuffetSwitch(1)
nmap <leader>2 <Plug>BuffetSwitch(2)
nmap <leader>3 <Plug>BuffetSwitch(3)
nmap <leader>4 <Plug>BuffetSwitch(4)
nmap <leader>5 <Plug>BuffetSwitch(5)
nmap <leader>6 <Plug>BuffetSwitch(6)
nmap <leader>7 <Plug>BuffetSwitch(7)
nmap <leader>8 <Plug>BuffetSwitch(8)
nmap <leader>9 <Plug>BuffetSwitch(9)
nmap <leader>0 <Plug>BuffetSwitch(10)
let g:buffet_always_show_tabline = 1
let g:buffet_powerline_separators = 1
let g:buffet_left_trunc_icon = "<"
let g:buffet_right_trunc_icon = ">"
" let g:buffet_tab_icon = " "
" let g:buffet_tab_icon = " "
" let g:buffet_tab_icon = " "
let g:buffet_tab_icon = " "




autocmd BufEnter * lua require'completion'.on_attach()
let g:completion_enable_auto_popup = 1
inoremap <silent><expr> <c-p> completion#trigger_completion() "map <c-p> to manually trigger completion
function! s:check_back_space() abort
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <TAB>
  \ pumvisible() ? "\<C-n>" :
  \ <SID>check_back_space() ? "\<TAB>" :
  \ completion#trigger_completion()


"
" ---  chadtree  ---
"
" nnoremap <silent> <C-m> <cmd>CHADopen<CR>



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
" ---  nvim.tree.lua  ---
"
let g:lua_tree_side = 'left' "left by default
let g:lua_tree_width = 30 "30 by default
let g:lua_tree_ignore = [ '.git', 'node_modules', '.cache' ] "empty by default
let g:lua_tree_auto_open = 0 "0 by default, opens the tree when typing `vim $DIR` or `vim`
let g:lua_tree_auto_close = 1 "0 by default, closes the tree when it's the last window
let g:lua_tree_follow = 1 "0 by default, this option allows the cursor to be updated when entering a buffer
let g:lua_tree_indent_markers = 1 "0 by default, this option shows indent markers when folders are open
let g:lua_tree_hide_dotfiles = 1 "0 by default, this option hides files and folders starting with a dot `.`
let g:lua_tree_git_hl = 1 "0 by default, will enable file highlight for git attributes (can be used without the icons).
let g:lua_tree_root_folder_modifier = ':~' "This is the default. See :help filename-modifiers for more options
let g:lua_tree_tab_open = 1 "0 by default, will open the tree when entering a new tab and the tree was previously open
let g:lua_tree_show_icons = {
    \ 'git': 1,
    \ 'folders': 0,
    \ 'files': 0,
    \}
"If 0, do not show the icons for one of 'git' 'folder' and 'files'
"1 by default, notice that if 'files' is 1, it will only display
"if nvim-web-devicons is installed and on your runtimepath

" You can edit keybindings be defining this variable
" You don't have to define all keys.
" NOTE: the 'edit' key will wrap/unwrap a folder and open a file
let g:lua_tree_bindings = {
    \ 'edit':            ['<CR>', 'o'],
    \ 'edit_vsplit':     '<C-v>',
    \ 'edit_split':      '<C-x>',
    \ 'edit_tab':        '<C-t>',
    \ 'toggle_ignored':  'I',
    \ 'toggle_dotfiles': 'H',
    \ 'refresh':         'R',
    \ 'preview':         '<Tab>',
    \ 'cd':              '<C-]>',
    \ 'create':          'a',
    \ 'remove':          'd',
    \ 'rename':          'r',
    \ 'cut':             'x',
    \ 'copy':            'c',
    \ 'paste':           'p',
    \ 'prev_git_item':   '[c',
    \ 'next_git_item':   ']c',
    \}

" Disable default mappings by plugin
" Bindings are enable by default, disabled on any non-zero value
" let lua_tree_disable_keybindings=1

" default will show icon by default if no icon is provided
" default shows no icon by default
let g:lua_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "★"
    \   },
    \ 'folder': {
    \   'default': "",
    \   'open': ""
    \   }
    \ }

nnoremap <C-m> :LuaTreeToggle<CR>
" nnoremap <leader>r :LuaTreeRefresh<CR>
" nnoremap <leader>n :LuaTreeFindFile<CR>
" LuaTreeOpen and LuaTreeClose are also available if you need them

set termguicolors " this variable must be enabled for colors to be applied properly

" a list of groups can be found at `:help lua_tree_highlight`
highlight LuaTreeFolderIcon guibg=blue




