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
			use("RishabhRD/popfix")
			use({ "famiu/bufdelete.nvim", cmd = "Bdelete" })
			use({ "kyazdani42/nvim-web-devicons" })
			use({
				"lewis6991/impatient.nvim",
				disable = vim.loop.os_uname().sysname == "Darwin",
				config = [[require("impatient")]],
			})
			use({
				"glepnir/dashboard-nvim",
				config = [[r("plugins.dashboard")]],
			})
			use({
				"ethanholz/nvim-lastplace",
				event = "BufRead",
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
				"numToStr/Comment.nvim",
				config = function()
					require("Comment").setup()
				end,
			})
			use({
				"voldikss/vim-translator",
				cmd = { "TranslateW" },
			})

			use({
				"lewis6991/gitsigns.nvim",
				event = { "BufRead" },
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
				"liuchengxu/vim-clap",
				run = ":Clap install-binary",
				cmd = "Clap",
				config = [[r("plugins.clap")]],
			})

			use({ "nvim-telescope/telescope.nvim", cmd = "Telescope", config = [[r("plugins.telescope")]] })
			use({
				"sindrets/diffview.nvim",
				cmd = { "DiffviewFileHistory", "DiffviewOpen" },
				config = [[r("plugins.diffview")]],
			})
			use({
				"nvim-pack/nvim-spectre",
				event = "BufRead",
				config = function()
					require("spectre").setup()
				end,
			})

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
			use({
				"shaeinst/penvim",
				disable = vim.loop.os_uname().sysname == "Darwin",
				event = { "BufRead", "BufNewFile" },
				config = [[require("penvim").setup()]],
			})
			-- use({ "romgrk/barbar.nvim", event = { "BufRead", "BufNewFile" } })
			use({
				"neoclide/coc.nvim",
				branch = "release",
				config = [[r('plugins.coc')]],
			})
			use("glepnir/indent-guides.nvim")
			use({
				"nvim-treesitter/nvim-treesitter",
				config = function()
					require("nvim-treesitter.configs").setup({
						ensure_installed = {
							"c",
							"lua",
							"rust",
							"tsx",
							"javascript",
							"typescript",
							"vim",
							"toml",
							"json",
						},
						sync_install = false,
						auto_install = true,
						highlight = {
							enable = true,
							disable = { "c", "rust" },
							additional_vim_regex_highlighting = false,
						},
					})
				end,
			})
		end,
		config = {
			compile_path = fn.stdpath("config") .. "/plugin/" .. "packer_compiled.lua",
			git = {
				clone_timeout = 30,
			},
			profile = {
				enable = true,
				threshold = 3,
			},
		},
	})
end, { isRecord = false })

r("default")
