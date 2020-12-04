" set termguicolors
" colorscheme OceanicNext

" colorscheme oceanic_material
" the configuration options should be placed before `colorscheme forest-night`
" highlight clear SignColumn
" highlight Cursorline  ctermfg=NONE  ctermbg=NONE cterm=bold guifg=white guibg=yellow gui=bold
" highlight EndOfBuffer  ctermfg=NONE ctermbg=NONE  guibg=NONE  guifg=NONE cterm=NONE gui=NONE
" highlight Visual ctermfg=NONE ctermbg=39
" highlight PmenuSbar ctermfg=NONE ctermbg=NONE
" highlight VertSplit ctermfg=147 ctermbg=147
" highlight Pmenu  ctermfg=black ctermbg=blue
" highlight PmenuSel ctermfg=7 ctermbg=4
" highlight WarningMsg ctermbg=39 ctermfg=NONE
" highlight SignColumn   ctermfg=NONE ctermbg=NONE  guibg=NONE  guifg=NONE cterm=NONE gui=NONE
" hi! DiffAdd ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
" hi! DiffChange ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
" hi! DiffDelete ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE




" colorscheme material
" let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
" set termguicolors
" Theme
 syntax enable
" for vim 7
 set t_Co=256

" for vim 8
 if (has("termguicolors"))
  set termguicolors
 endif

" colorscheme OceanicNext
colorscheme deus
