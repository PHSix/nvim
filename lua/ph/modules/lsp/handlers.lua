return {
	setup = function()
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			underline = true,
			virtual_text = {
				spacing = 4,
				severity_limit = "Warning",
				prefix = "",
			},
			signs = {
				enable = true,
				priority = 20,
			},
			update_in_insert = true,
		})
	end,
}
