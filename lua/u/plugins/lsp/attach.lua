local attach = function(_, bufnr)
	local packer = require("packer")
	if not packer_plugins["which-key.nvim"].loaded then
		packer.loader("which-key.nvim")
	end
	local wk = require("which-key")

	local bufopts = { noremap = true, silent = true, buffer = bufnr }
	vim.keymap.set("n", "gD", vim.lsp.buf.declaration, bufopts)
	vim.keymap.set("n", "gd", vim.lsp.buf.definition, bufopts)
	-- vim.keymap.set("n", "K", vim.lsp.buf.hover, bufopts)
	vim.keymap.set("n", "gi", vim.lsp.buf.implementation, bufopts)
	vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, bufopts)
	vim.keymap.set("n", "K", "<Cmd>Lspsaga hover_doc<CR>", bufopts)
	vim.keymap.set("n", "<F2>", "<Cmd>Lspsaga rename<CR>", bufopts)

	-- vim.keymap.set("n", "<space>D", vim.lsp.buf.type_definition, bufopts)
	-- vim.keymap.set("n", "<space>rn", vim.lsp.buf.rename, bufopts)
	-- vim.keymap.set("n", "<space>ca", vim.lsp.buf.code_action, bufopts)
	vim.keymap.set("n", "gr", vim.lsp.buf.references, bufopts)

	-- wk.register({
	-- 	f = {
	-- 		l = { "<Cmd>Lspsaga lsp_finder<CR>", "LSP Finder" },
	-- 	},
	-- 	c = {
	-- 		a = { "<Cmd>Lspsaga code_action<CR>", "LSP Code Action" },
	-- 	},
	-- }, {
	-- 	prefix = "<leader>",
	-- 	buffer = bufnr,
	-- })
end

return attach
