

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
" ---  vim-startify  ---
"

let g:startify_lists = [
\ { 'type': 'files',     'header': ['   MRU']            },
\ { 'type': 'sessions',  'header': ['   Sessions']       },
\ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
\ ]

" let g:startify_bookmarks = [ {'c': '~/.vimrc'}, '~/.zshrc' ]
let g:startify_bookmarks = [ "~/.config/nvim/coc-settings.json", '~/.zshrc', "~/.config/awesome/rc.lua", "~/.config/picom.conf", "~/.config/i3/config" ]

let g:startify_custom_header =
\startify#center(
\[
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
\])
" let g:startify_custom_header =
" \startify#center(
" \[
" \'__/\\\\\_____/\\\__/\\\\\\\\\\\\\\\_______/\\\\\_______/\\\________/\\\__/\\\\\\\\\\\__/\\\\____________/\\\\_        ',
" \' _\/\\\\\\___\/\\\_\/\\\///////////______/\\\///\\\____\/\\\_______\/\\\_\/////\\\///__\/\\\\\\________/\\\\\\_       ',
" \'  _\/\\\/\\\__\/\\\_\/\\\_______________/\\\/__\///\\\__\//\\\______/\\\______\/\\\_____\/\\\//\\\____/\\\//\\\_      ',
" \'   _\/\\\//\\\_\/\\\_\/\\\\\\\\\\\______/\\\______\//\\\__\//\\\____/\\\_______\/\\\_____\/\\\\///\\\/\\\/_\/\\\_     ',
" \'    _\/\\\\//\\\\/\\\_\/\\\///////______\/\\\_______\/\\\___\//\\\__/\\\________\/\\\_____\/\\\__\///\\\/___\/\\\_    ',
" \'     _\/\\\_\//\\\/\\\_\/\\\_____________\//\\\______/\\\_____\//\\\/\\\_________\/\\\_____\/\\\____\///_____\/\\\_   ',
" \'      _\/\\\__\//\\\\\\_\/\\\______________\///\\\__/\\\________\//\\\\\__________\/\\\_____\/\\\_____________\/\\\_  ',
" \'       _\/\\\___\//\\\\\_\/\\\\\\\\\\\\\\\____\///\\\\\/__________\//\\\________/\\\\\\\\\\\_\/\\\_____________\/\\\_ ',
" \'        _\///_____\/////__\///////////////_______\/////_____________\///________\///////////__\///______________\///__',
" \])
"
function! StartifyEntryFormat()
return 'WebDevIconsGetFileTypeSymbol(absolute_path) ." ". entry_path'
endfunction



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




" dashboard.nvim
" let g:dashboard_default_executive ='clap'
" let g:dashboard_custom_header = [
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
            " \ ]


" nmap <Leader>bs :<C-u>SessionSave<CR>
" nmap <Leader>pl :<C-u>SessionLoad<CR>
" nmap <Leader>pn :<C-u>DashboardNewFile<CR>
" nnoremap <silent> <Leader>ph :<C-u>Clap history<CR>
" nnoremap <silent> <Leader>pf :<C-u>Clap files ++finder=rg --ignore --hidden --files<cr>
" nnoremap <silent> <Leader>pc :<C-u>Clap colors<CR>
" nnoremap <silent> <Leader>pa :<C-u>Clap grep2<CR>
" nnoremap <silent> <Leader>pb :<C-u>Clap marks<CR>

" let g:dashboard_custom_shortcut={
            " \ 'find_word' : 'SPC p a',
            " \ 'find_file' : 'SPC p f',
            " \ 'last_session' : 'SPC p l',
            " \ 'find_history' : 'SPC p h',
            " \ 'new_file' : 'SPC p n',
            " \ 'change_colorscheme' : 'SPC p c',
            " \ 'book_marks' : 'SPC p b',
            " \ }

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
" let g:vimspector_enable_mappings = 'HUMAN'
" function! s:read_template_into_buffer(template)
    " " has to be a function to avoid the extra space fzf#run insers otherwise
    " execute '0r ~/.config/nvim/vimspector_json/'.a:template
" endfunction
" command! -bang -nargs=* LoadVimSpectorJsonTemplate call fzf#run({
            " \   'source': 'ls -1 ~/.config/nvim/vimspector_json',
            " \   'down': 20,
            " \   'sink': function('<sid>read_template_into_buffer')
            " \ })
" noremap <leader>dt :tabe .vimspector.json<CR>:LoadVimSpectorJsonTemplate<CR>
" noremap <leader>dq :VimspectorReset<CR>
" noremap <leader>dw :VimspectorReset
" noremap <leader>dp <Plug>VimspectorToggleBreakpoint
" noremap <leader>dr <Plug>VimspectorRestart
" noremap <leader>dg <Plug>VimspectorContinue
" let g:vimspector_sidebar_width = 30
" let g:vimspector_bottombar_height = 7



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
" let g:buffet_always_show_tabline = 1
" let g:buffet_powerline_separators = 1
" let g:buffet_left_trunc_icon = "<"
" let g:buffet_right_trunc_icon = ">"
" let g:buffet_tab_icon = " "
" let g:buffet_tab_icon = " "
" let g:buffet_tab_icon = " "
" let g:buffet_tab_icon = " "









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

set termguicolors " this variable must be enabled for colors to be applied properly

highlight LuaTreeFolderIcon guibg=blue

augroup nvim_tree_au

augroup end



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


"
" ---  ale  ---
"
let g:ale_sign_column_always = 1
let g:ale_sign_error = '>>'
let g:ale_sign_column_color = 1
let g:ale_sign_warning = '<<'
let g:ale_echo_msg_error_str = 'E'
let g:ale_echo_msg_warning_str = 'W'
let g:ale_echo_msg_format = '[%linter%] %s [%severity%]'
" let g:ale_linter_aliases = {
      " \'javascriptreact': ['javascript', 'jsx'],
      " \'typescriptreact': ['tsx', 'typescript'],
      " \}
let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'javascript': ['eslint'],
\}
let g:ale_fix_on_save = 1
highlight clear ALEErrorSign
highlight link ALEWarningSign todo
let g:ale_close_preview_on_insert = 1

source ~/.config/nvim/plug/coc/coc_config.vim
