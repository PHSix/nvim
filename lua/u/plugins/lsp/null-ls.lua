local nu = require("null-ls")
local has_eslint_config = function(u)
	return u.root_has_file(".eslintrc") or u.root_has_file(".eslintrc.json") or u.root_has_file(".eslintrc.js")
end

local has_stylelint_config = function(u)
	return u.root_has_file(".stylelintrc") or u.root_has_file(".stylelintrc.json") or u.root_has_file(".stylelintrc.js")
end

local has_stylua_config = function(u)
	return u.root_has_file("stylua.toml") or u.root_has_file(".stylua.toml")
end
nu.setup({
	update_in_insert = false,
	sources = {
		nu.builtins.completion.spell,
		-- nu.builtins.code_actions.eslint_d.with({
		-- 	condition = has_eslint_config,
		-- 	prefer_local = "node_modules/.bin",
		-- }),

		-- nu.builtins.diagnostics.eslint_d.with({
		-- 	condition = has_eslint_config,
		-- 	prefer_local = "node_modules/.bin",
		-- }),
		nu.builtins.diagnostics.stylelint.with({
			condition = has_stylelint_config,
			prefer_local = "node_modules/.bin",
		}),
		nu.builtins.diagnostics.fish,
		nu.builtins.diagnostics.zsh,

		-- nu.builtins.formatting.clang_format,
		nu.builtins.formatting.eslint_d.with({
			condition = has_eslint_config,
			prefer_local = "node_modules/.bin",
		}),
		nu.builtins.formatting.gofmt,
		nu.builtins.formatting.goimports,
		-- nu.builtins.formatting.prettier_d_slim
		-- nu.builtins.formatting.prettierd,
		nu.builtins.formatting.prettierd.with({
			env = {
				PRETTIERD_DEFAULT_CONFIG = vim.fn.getcwd() .. "./.prettierrc",
			},
		}),
		nu.builtins.formatting.rustfmt,
		-- nu.builtins.formatting.stylua,
		nu.builtins.formatting.stylua.with({
			condition = has_stylua_config,
		}),
		nu.builtins.formatting.stylelint.with({
			condition = has_stylelint_config,
			prefer_local = "node_modules/.bin",
		}),
	},
})
vim.api.nvim_create_user_command("LSPFormat", function()
	if vim.fn.has("nvim-0.8") == 1 then
		vim.lsp.buf.format({
			timeout_ms = 3000,
			bufnr = 0,
			async = false,
			name = "null-ls",
		})
	else
		vim.lsp.buf.formatting_sync()
	end
end, { desc = "format from null-ls or lsp" })
local Recorder = r("benchmark").Recorder
local fts = {}
vim.api.nvim_create_autocmd("BufWritePre", {
	pattern = { "*" },
	desc = "LSP Autocmd to format file.",
	callback = function()
		if vim.tbl_contains(fts, vim.bo.filetype) then
			return
		end
		local record = Recorder:new()
		record:start()
		if vim.fn.has("nvim-0.8") == 1 then
			local clients = vim.lsp.get_active_clients()
			local null_ls_client = vim.tbl_filter(function(c)
				return c.name == "null-ls"
			end, clients)[1]
			if not (null_ls_client and null_ls_client.supports_method("textDocument/formatting")) then
				return
			end
			vim.lsp.buf.format({
				timeout_ms = 1000,
				bufnr = 0,
				async = false,
				filter = function(client)
					return client.name == "null-ls"
				end,
			})
		else
			vim.lsp.buf.formatting()
		end
		record:stop()
		if record:getms() > 300 then
			vim.notify(string.format("LSP Auto Format cost too long time, last time it cost %dms.", record:getms()))
			table.insert(fts, vim.bo.filetype)
		end
	end,
})
