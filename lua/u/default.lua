vim.defer_fn(function()
	-- vim.g.material_style = "oceanic"
	-- vim.cmd("colorscheme material")

	-- vim.g.everforest_background = "soft"
	vim.cmd([[colorscheme everforest]])

	-- vim.g.onedark_config = {
	-- 	style = "deep",
	-- }
	-- vim.cmd([[colorscheme onedark]])

	-- vim.cmd([[colorscheme deus]])

	vim.g.vista_default_executive = "coc"

	vim.g.exclude_ft = { "plaintext" }
end, 1)
