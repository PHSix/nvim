vim.api.nvim_set_keymap("i", "<C-Space>", "coc#refresh()", { silent = true, expr = true })
vim.api.nvim_set_keymap(
	"i",
	"<TAB>",
	"pumvisible() ? '<C-n>' : '<TAB>'",
	{ noremap = true, silent = true, expr = true }
)
vim.api.nvim_set_keymap("i", "<S-TAB>", "pumvisible() ? '<C-p>' : '<C-h>'", { noremap = true, expr = true })
vim.api.nvim_set_keymap("n", "K", ":call CocActionAsync('doHover')<CR>", { silent = true, noremap = true })
vim.api.nvim_set_keymap("n", "<F2>", "<Plug>(coc-rename)", {})

vim.cmd([[
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
		\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
]])

vim.g.coc_global_extensions = {
	"coc-sumneko-lua",
	"coc-json",
	"coc-tsserver",
	"coc-pairs",
	"coc-marketplace",
	"coc-eslint",
	"coc-prettier",
	"coc-snippets",
	"coc-explorer",
	"coc-pairs",
}

vim.api.nvim_set_keymap("n", "<C-n>", "<CMD>CocCommand explorer<CR>", { silent = true })

vim.cmd([[
	command! -nargs=0 CocFormat :call CocActionAsync('format')
	command! -nargs=0 CocMarketplace :CocList marketplace<CR>
]])
