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

		-- vim.g.catppuccin_flavour = "mocha" -- latte, frappe, macchiato, mocha
		--
		-- require("catppuccin").setup()
		--
		-- vim.cmd([[colorscheme catppuccin]])

		-- require("github-theme").setup()

		-- vim.cmd([[colorscheme dracula]])

		-- vim.cmd([[colorscheme tokyodark]])

		-- vim.opt.background = "dark"
		-- vim.cmd("colorscheme tundra")

		-- vim.cmd([[colorscheme noctis]])

		-- vim.cmd [[colorscheme tokyodark]]

		require("noice").setup()
		vim.g.exclude_ft = { "plaintext" }
	end, 1)
end)
