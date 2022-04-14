return {
	setup = function()
		vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
			-- Enable underline, use default values
			underline = true,
			-- Enable virtual text, override spacing to 4
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
