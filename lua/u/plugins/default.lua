-- vim.cmd([[colorscheme zephyrium]])
-- vim.o.background = "dark"
-- vim.o.termguicolors = true
-- vim.g.everforest_background = "hard"
-- vim.cmd([[colorscheme everforest]])

vim.g.onedark_config = {
	style = "deep",
}
vim.cmd([[colorscheme onedark]])

-- vim.cmd([[colorscheme deus]])

local opts = {}
vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "<F2>", "<Cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "gh", "<Cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("n", "gd", "<Cmd>Lspsaga preview_definition<CR>", opts)

vim.g.vista_default_executive = "nvim_lsp"

-- start lsp at first time
vim.api.nvim_create_autocmd("BufRead", {
	pattern = { "*" },
	desc = "Auto Detect LSP In First Time Enter Buffer.",
	callback = function()
		if #vim.lsp.get_active_clients({ bufnr = 0 }) == 0 then
			vim.defer_fn(function()
				vim.cmd([[LspStart]])
			end, 300)
		end
		-- maybe todo: treesitter highlight
	end,
	once = true,
})

vim.keymap.set("n", "<C-t>", "<Cmd>Lspsaga open_floaterm<CR>", { silent = true })