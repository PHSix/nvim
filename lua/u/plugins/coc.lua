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

vim.api.nvim_create_augroup('vimrc_autocmd', { clear = true })

vim.api.nvim_create_autocmd({ "ModeChanged" }, {
	group = "vimrc_autocmd",
	pattern = "*",
	callback = function()
		if vim.fn.mode() == "s" then
			local key = vim.api.nvim_replace_termcodes("<C-r>_", true, false, true)
			vim.api.nvim_feedkeys(key, "s", false)
		end
	end,
	once = false,
})

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

local function toggle_tree() 
	if vim.bo.filetype == 'dashboard' then
		return "<Cmd>CocCommand explorer --position floating<CR>"
	end

	return "<CMD>CocCommand explorer<CR>"
end

vim.keymap.set("n", "<C-n>", toggle_tree, { silent = true, expr=true })

vim.cmd([[
	command! -nargs=0 CocFormat :call CocActionAsync('format')
	command! -nargs=0 CocMarketplace :CocList marketplace<CR>
]])
