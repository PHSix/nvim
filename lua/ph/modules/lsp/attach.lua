local api = vim.api
-- local util = vim.lsp.util
-- local t = { tsserver = true, sumneko_lua = true }

local t
t = {
	collections = {
		"tsserver",
		"sumneko_lua",
		"gopls",
		"denols",
		"jsonls",
	},
	has = function(ls)
		for _, _ls in ipairs(t.collections) do
			if ls == _ls then
				return true
			end
		end
		return false
	end,
}

local on_attach = function(client, bufnr)
	if t.has(client.name) then
		if vim.fn.has("nvim-0.8.0") == 1 then
			client.server_capabilities.documentFormattingProvider = false
		else
			client.resolved_capabilities.document_formatting = false
		end
	end
	-- if not t[client.name] and client.resolved_capabilities.document_formatting
	-- then
	-- 	vim.cmd([[
	-- 	augroup LspFormatting
	-- 			autocmd! * <buffer>
	-- 			autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()
	-- 	augroup END
	-- 	]])
	-- end
	local function buf_set_keymap(...)
		api.nvim_buf_set_keymap(bufnr, ...)
	end

	local function buf_set_option(...)
		api.nvim_buf_set_option(bufnr, ...)
	end
	buf_set_option("omnifunc", "v:lua.vim.lsp.omnifunc")
	local opts = { noremap = true, silent = true }
	-- buf_set_keymap('n', '<space>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)
	buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
	buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
	buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
	buf_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
	-- buf_set_keymap('n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
	buf_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", opts)
	buf_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", opts)
	-- buf_set_keymap('n', '<leader>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
	buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
	-- buf_set_keymap('n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
	buf_set_keymap("n", "<leader>rn", "<cmd>LspVarRename<CR>", opts)
	buf_set_keymap("n", "<F2>", "<cmd>LspVarRename<CR>", opts)
	buf_set_keymap("n", "<leader>ca", "<cmd>CodeActionMenu<CR>", opts)
	buf_set_keymap("n", "<F1>", "<cmd>CodeActionMenu<CR>", opts)
	buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
	buf_set_keymap("n", "<leader>e", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)
	buf_set_keymap("n", "<leader>k", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
	buf_set_keymap("n", "<leader>j", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
	buf_set_keymap("n", "<leader>q", "<cmd>lua vim.lsp.diagnostic.set_loclist()<CR>", opts)
end

return on_attach
