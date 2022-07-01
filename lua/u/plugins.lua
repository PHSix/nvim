local utils = r("utils")
utils.push_async_task(function()
	local uv = vim.loop
	local fn = vim.fn
	local packer_bootstrap
	if not utils.is_plugin_installed("packer.nvim") then
		packer_bootstrap = fn.system({
			"git",
			"clone",
			"--depth",
			"1",
			"https://github.com/wbthomason/packer.nvim",
			utils.plugins_path .. "/start/packer.nvim",
		})
		vim.cmd([[packadd packer.nvim]])
	end

	local use = require("packer").use

	require("packer").startup({
		function()
			use({ "wbthomason/packer.nvim" })
			use({ "theniceboy/nvim-deus" })
			use({
				"lewis6991/impatient.nvim",
				config = [[require("impatient")]],
			})
			use("nvim-lua/plenary.nvim")
			use({
				"williamboman/nvim-lsp-installer",
				event = { "BufRead", "BufNewFile" },
				cmd = {
					"LspInstall",
					"LspInstallInfo",
					"LspPrintInstalled",
					"LspRestart",
					"LspStart",
					"LspStop",
					"LspUninstall",
					"LspUninstallAll",
				},
			})
			use({
				"jose-elias-alvarez/null-ls.nvim",
				after = "nvim-lsp-installer",
			})
			use({ "jose-elias-alvarez/typescript.nvim", after = "null-ls.nvim" })
			use({
				"neovim/nvim-lspconfig",
				after = "typescript.nvim",
				config = [[r("plugins.lsp")]],
			})
			use({ "glepnir/lspsaga.nvim", cmd = "Lspsaga", config = [[r("plugins.saga")]] })
			use({
				"lewis6991/gitsigns.nvim",
				event = { "BufRead", "BufNewFile" },
				config = [[r("plugins.gitsign")]],
			})
			use({
				"folke/which-key.nvim",
				keys = {
					"<leader>",
					"g",
					"d",
					"y",
					"!",
					"z",
					">",
					"<",
					"]",
					"[",
					"v",
					"c",
				},
				config = [[r("plugins.which-key")]],
			})
			use({
				"nvim-neo-tree/neo-tree.nvim",
				branch = "v2.x",
				cmd = { "NeoTreeRevealToggle" },
				keys = { "<C-n>" },
				requires = {
					{ opt = true, "kyazdani42/nvim-web-devicons" },
					{ opt = true, "MunifTanjim/nui.nvim" },
				},
				config = [[r("plugins.neotree")]],
			})
			use({
				"PHSix/faster.nvim",
				keys = { "j", "k" },
				config = function()
					vim.api.nvim_set_keymap("n", "j", "<Plug>(faster_move_gj)", { noremap = false, silent = true })
					vim.api.nvim_set_keymap("n", "k", "<Plug>(faster_move_gk)", { noremap = false, silent = true })
					vim.api.nvim_set_keymap("v", "j", "<Plug>(faster_vmove_j)", { noremap = false, silent = true })
					vim.api.nvim_set_keymap("v", "k", "<Plug>(faster_vmove_k)", { noremap = false, silent = true })
				end,
			})
			use({
				"glepnir/galaxyline.nvim",
				config = [[r("plugins.statusline")]],
			})
			use({
				"nvim-treesitter/nvim-treesitter",
				event = { "BufNewFile", "BufRead" },
				requires = {
					{ "windwp/nvim-ts-autotag", after = "nvim-treesitter" },
					{ "p00f/nvim-ts-rainbow", after = "nvim-treesitter" },
					{ "JoosepAlviste/nvim-ts-context-commentstring", after = "nvim-treesitter" },
					{ "nvim-treesitter/playground", after = "nvim-treesitter" },
				},
				config = [[r("plugins.treesitter")]],
			})
			use({
				"hrsh7th/nvim-cmp",
				event = { "InsertEnter" },
				-- commit = "4f1358e659d51c69055ac935e618b684cf4f1429",
				requires = {
					{
						"hrsh7th/cmp-nvim-lsp",
						opt = true,
					},
					{
						"hrsh7th/cmp-buffer",
						opt = true,
					},
					{
						"hrsh7th/cmp-vsnip",
						opt = true,
					},
					{
						"hrsh7th/vim-vsnip",
						opt = true,
					},
					{
						"hrsh7th/cmp-path",
						opt = true,
					},
					{
						"hrsh7th/cmp-nvim-lua",
						opt = true,
					},
					{
						"ray-x/cmp-treesitter",
						opt = true,
					},
					{
						"onsails/lspkind-nvim",
						opt = true,
					},
					{
						"lukas-reineke/cmp-under-comparator",
						opt = true,
					},
				},
				config = [[r("plugins.cmp")]],
			})
			use({"Yggdroot/LeaderF", run = ":LeaderfInstallCExtension", config = [[r("plugins.leaderf")]], cmd = "Leaderf"})
		end,
		config = {
			-- Default compile path of packer_compiled file.
			compile_path = fn.stdpath("config") .. "/plugin/" .. "packer_compiled.lua",
			git = {
				clone_timeout = 300,
			},
			-- Adding single border to packer window.
			display = {
				open_fn = function()
					return require("packer.util").float({ border = "single" })
				end,
			},
		},
	})
end, { isRecord = true })
vim.cmd([[colorscheme deus]])
