" Theme
 syntax enable
" for vim 7
 set t_Co=256

" for vim 8
 if (has("termguicolors"))
  set termguicolors
 endif

" colorscheme OceanicNext
colorscheme ayu

hi! DiffDelete guifg=#ff7675 guibg=#14191F
hi! EndOfBuffer  guifg=#0f1419
