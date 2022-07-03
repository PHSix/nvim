local utils = r("utils")
utils.push_async_task(function()
	local fn = vim.fn
	if not utils.is_plugin_installed("packer.nvim") then
		fn.system({
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
			use("wbthomason/packer.nvim")
			use("theniceboy/nvim-deus")
			use("navarasu/onedark.nvim")
			use("sainnhe/everforest")
			use("sainnhe/sonokai")
			use("tiagovla/tokyodark.nvim")
			use("marko-cerovac/material.nvim")
			use("nvim-lua/plenary.nvim")
			use({ "famiu/bufdelete.nvim", cmd = "Bdelete" })
			use({ "kyazdani42/nvim-web-devicons" })
			use({
				"lewis6991/impatient.nvim",
				config = [[require("impatient")]],
			})
			use({
				"glepnir/dashboard-nvim",
				config = [[r("plugins.dashboard")]],
			})
			use({
				"ethanholz/nvim-lastplace",
				config = function()
					require("nvim-lastplace").setup({
						lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
						lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
						lastplace_open_folds = true,
					})
				end,
			})

			use({
				"tpope/vim-surround",
				keys = { "c", "d" },
			})
			use({
				"tpope/vim-commentary",
				keys = { "gc", ",c" },
				config = function()
					vim.api.nvim_set_keymap("n", ",cc", "gcc", { noremap = false, silent = true })
					vim.api.nvim_set_keymap("v", ",c", "gc", { noremap = false, silent = true })
					vim.api.nvim_set_keymap("x", ",cc", "gc", { noremap = false, silent = true })
				end,
			})
			use({
				"voldikss/vim-translator",
				cmd = { "TranslateW" },
			})

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
				cmd = { "Gitsigns" },
				config = [[r("plugins.gitsign")]],
			})
			use({
				"folke/which-key.nvim",
				keys = {
					"<space>",
				},
				config = [[r("plugins.which-key")]],
			})
			use({
				"nvim-neo-tree/neo-tree.nvim",
				branch = "v2.x",
				cmd = { "NeoTreeRevealToggle" },
				keys = { "<C-n>" },
				requires = {
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
				"lukas-reineke/indent-blankline.nvim",
				event = { "BufRead", "BufNewFile" },
				config = [[r("plugins.indentline")]],
			})

			use({
				"hrsh7th/nvim-cmp",
				event = { "InsertEnter" },
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
			use({
				"liuchengxu/vim-clap",
				run = ":Clap install-binary",
				cmd = "Clap",
				config = [[r("plugins.clap")]],
			})
			use({
				"sindrets/diffview.nvim",
				cmd = { "DiffviewFileHistory", "DiffviewOpen" },
				config = [[r("plugins.diffview")]],
			})
			use({
				"nvim-pack/nvim-spectre",
				config = function()
					require("spectre").setup()
				end,
			})
			use({
				"windwp/nvim-autopairs",
				after = "nvim-cmp",
				config = [[require("nvim-autopairs").setup()]],
			})
			use({ "liuchengxu/vista.vim", cmd = "Vista" })

			use({
				"phaazon/hop.nvim",
				keys = { "s" },
				config = function()
					require("hop").setup({ keys = "asdfghjkl;'qweruiop" })
					vim.api.nvim_set_keymap("n", "s", ":HopChar2<CR>", { noremap = true, silent = true })
					-- vim.api.nvim_command("highlight default HopUnmatched guifg=#666666 guibg=bg guisp=#666666 ctermfg=242")
				end,
			})
			use({ "skywind3000/asynctasks.vim", opt = true, requires = { "skywind3000/asyncrun.vim", opt = true } })
			use({ "shaeinst/penvim", event = { "BufRead", "BufNewFile" }, config = [[require("penvim").setup()]] })
			use({ "romgrk/barbar.nvim", event = { "BufRead", "BufNewFile" } })
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
end, { isRecord = false })

r("default")
