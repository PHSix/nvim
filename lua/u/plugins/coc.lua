vim.api.nvim_set_keymap("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<TAB>", "pumvisible() ? '<C-n>' : '<TAB>'", { noremap = true, silent = true, expr = true })
vim.api.nvim_set_keymap("i", "<S-TAB>", "pumvisible() ? '<C-p>' : '<C-h>'", { noremap = true, expr = true })
vim.api.nvim_set_keymap("i", "<CR>", "pumvisible() ? coc#_select_confirm() : '<C-G>u<CR><C-R>=coc#on_enter()<CR>'",
	{ silent = true, expr = true, noremap = true })
vim.api.nvim_set_keymap("n", "K", ":call CocActionAsync('doHover')<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<F2>", "<Plug>(coc-rename)", {})


vim.g.coc_global_extensions = {
	'coc-lua',
	"coc-json",
	"coc-tsserver",
	"coc-pairs",
	"coc-marketplace",
	"coc-eslint",
	"coc-prettier",
	"coc-snippets",
}

vim.cmd [[
	command! -nargs=0 CocFormat :call CocActionAsync('format')
	command! -nargs=0 CocMarketplace :CocList marketplace<CR>
]]
