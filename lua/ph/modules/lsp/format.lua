local api = vim.api
return {
	setup = function ()
		api.nvim_create_augroup("LspAutoFormat",{clear = true})
		api.nvim_create_autocmd("BufWritePre", {pattern = {"*"}, callback = function ()
			vim.lsp.buf.formatting_sync()
		end})
	end
}
