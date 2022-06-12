local nu = require("null-ls")
nu.setup({
	sources = {
		nu.builtins.formatting.stylua,
		nu.builtins.completion.spell,
		nu.builtins.code_actions.eslint_d,

		-- nu.builtins.diagnostics.eslint_d,
		nu.builtins.diagnostics.fish,
		nu.builtins.diagnostics.stylelint,
		nu.builtins.diagnostics.zsh,

		-- nu.builtins.formatting.clang_format,
		-- nu.builtins.formatting.eslint_d,
		nu.builtins.formatting.gofmt,
		-- nu.builtins.formatting.prettier,
		-- nu.builtins.formatting.prettier_d_slim
		nu.builtins.formatting.prettierd,
		nu.builtins.formatting.rustfmt,
		nu.builtins.formatting.stylua,
	},
})

vim.api.nvim_create_user_command("LspFormat", "execute 'lua vim.lsp.buf.formatting_sync()'", {})
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	callback = function()
		vim.lsp.buf.formatting_sync()
	end,
})
