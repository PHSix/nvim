vim.cmd [[augroup dashboard_group]]
vim.cmd [[autocmd FileType dashboard set cursorline]]
vim.cmd [[augroup END]]

vim.cmd [[augroup help_doc]]
vim.cmd [[autocmd FileType help lua vim.api.nvim_buf_set_keymap(0,'n', 'q', ':q<CR>', {silent=true})]]
vim.cmd [[augroup END]]

