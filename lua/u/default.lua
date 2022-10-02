pcall(function()
	vim.defer_fn(function()
		-- vim.g.material_style = "oceanic"
		-- vim.cmd("colorscheme material")

		-- vim.g.everforest_background = "soft"
		-- vim.cmd([[colorscheme everforest]])

		-- vim.g.sonokai_style = 'atlantis'
		-- vim.g.sonokai_better_performance = 1
		-- vim.cmd [[colorscheme sonokai]]

		vim.g.onedark_config = {
			style = "deep",
		}
		vim.cmd([[colorscheme onedark]])

		-- vim.cmd([[colorscheme deus]])

		vim.g.exclude_ft = { "plaintext" }
	end, 1)
end)
