require("gitsigns").setup({
	keymaps = {
		noremap = false,
		buffer = false,
	},
	current_line_blame = true,
})
vim.keymap.set("n", "gj", "<CMD>:Gitsigns next_hunk<CR>", { silent = true })
vim.keymap.set("n", "gk", "<CMD>:Gitsigns prev_hunk<CR>", { silent = true })
