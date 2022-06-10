local create_cmd = vim.api.nvim_create_user_command

return {
	setup = function()
		create_cmd("ToggleTabline", function(opts)
			if vim.o.showtabline >= 2 then
				vim.o.showtabline = 0
			else
				vim.o.showtabline = 2
			end
		end, { nargs = 0 })
	end,
}
