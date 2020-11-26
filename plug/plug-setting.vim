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
" let g:buffet_tab_icon = " "
" let g:buffet_tab_icon = " "
" let g:buffet_tab_icon = "🪐"
" let g:buffet_tab_icon = "♓"
" let g:buffet_tab_icon = "🚀"
" let g:buffet_tab_icon = "✈️ "
" let g:buffet_tab_icon = "🛰️ "
" let g:buffet_tab_icon = "⚡"
let g:buffet_tab_icon = "🌈"
" let g:buffet_tab_icon = "🌠"
" let g:buffet_tab_icon = "🌌"
" let g:buffet_tab_icon = "🌀"
" let g:buffet_tab_icon = "<->"
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
nmap <CR> <CR>



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

source ~/.config/nvim/plug/coc/coc_config.vim



