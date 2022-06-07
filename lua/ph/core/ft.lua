return {
	setup = function()
		local augroup = vim.api.nvim_create_augroup("font_config_ft", { clear = true })
		vim.api.nvim_create_autocmd("BufReadPost", {
			pattern = { "*.conf" },
			callback = function()
				local name = vim.api.nvim_buf_get_name(0)
				if string.match(name, "/.config/fontconfig/fonts.conf") ~= nil then
					vim.cmd([[set ft=xml]])
				end
			end,
			group = augroup,
		})
	end,
}
