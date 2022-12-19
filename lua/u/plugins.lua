local utils = r("utils")

local isMac = vim.loop.os_uname().system == 'Darwin';

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

	-- local use = require("packer").use

	require("packer").startup({
		function()
			-- dependences
			use("wbthomason/packer.nvim")
			use("nvim-lua/plenary.nvim")
			use("RishabhRD/popfix")
			use('kevinhwang91/promise-async')
			use("MunifTanjim/nui.nvim")
			use('tpope/vim-repeat')

			-- colorscheme
			use("navarasu/onedark.nvim")
			use("sainnhe/everforest")
			use("sainnhe/sonokai")
			use("tiagovla/tokyodark.nvim")
			use("marko-cerovac/material.nvim")
			use("Th3Whit3Wolf/one-nvim")

			-- else
			use("sam4llis/nvim-tundra")
			use('folke/noice.nvim')
			use("romainl/vim-cool")
			use('xiyaowong/nvim-cursorword')
			use({ "TimUntersberger/neogit", config = [[require('neogit').setup()]] })
			use({ 'anuvyklack/hydra.nvim',
				keys = { "<leader>g" },
				config = [[r('plugins.hydra')]]
			})
			use({ "kartikp10/noctis.nvim", requires = { "rktjmp/lush.nvim" } })
			use({ "projekt0n/github-nvim-theme" })
			use({ "catppuccin/nvim", as = "catppuccin" })
			use({ "famiu/bufdelete.nvim", cmd = "Bdelete" })
			use({ "kyazdani42/nvim-web-devicons" })

			use({
				"lewis6991/impatient.nvim",
				disable = isMac,
				config = [[require("impatient")]],
			})
			use("mhinz/vim-startify")
			-- use({
			-- 	"glepnir/dashboard-nvim",
			-- 	config = [[r("plugins.dashboard")]],
			-- })
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
				'itchyny/lightline.vim',
				requires = {
					'mengelbrecht/lightline-bufferline',
					'josa42/vim-lightline-coc'
				},
				config = [[r('plugins.lightline')]]

			})
			-- use({
			-- 	"glepnir/galaxyline.nvim",
			-- 	config = [[r("plugins.statusline")]],
			-- })
			-- use({
			-- 	"liuchengxu/vim-clap",
			-- 	run = ":Clap install-binary",
			-- 	cmd = "Clap",
			-- 	config = [[r("plugins.clap")]],
			-- })

			use({ "nvim-telescope/telescope.nvim",
				requires = { "fannheyward/telescope-coc.nvim", opt = true },
				cmd = "Telescope", config = [[r("plugins.telescope")]] })
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

			use({ 'ggandor/leap.nvim', config = function()
				require('leap').add_default_mappings()
			end })

			use({ "skywind3000/asynctasks.vim", opt = true, requires = { "skywind3000/asyncrun.vim", opt = true } })
			-- use({ "romgrk/barbar.nvim", event = { "BufRead", "BufNewFile" } })
			use { 'kevinhwang91/nvim-ufo', config = [[r('plugins.ufo')]] }
			use({
				"neoclide/coc.nvim",
				branch = "release",
				config = [[r('plugins.coc')]],
			})
			use({ "lukas-reineke/indent-blankline.nvim", config = [[r("plugins.indentline")]] })
			use({
				"nvim-treesitter/nvim-treesitter",
				branch = "v0.8.0",
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
							enable = false,
							disable = { "c", "rust" },
							additional_vim_regex_highlighting = false,
						},
					})
				end,
			})
			use({
				"numToStr/FTerm.nvim",
				keys = { "<C-t>" },
				config = function()
					require("FTerm").setup({
						border = "rounded",
						dimensions = {
							height = 0.9,
							width = 0.9,
						},
					})

					-- Example keybindings
					vim.keymap.set("n", "<C-t>", '<CMD>lua require("FTerm").toggle()<CR>')
					vim.keymap.set("t", "<C-t>", '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
				end,
			})
			use {
				"nvim-zh/colorful-winsep.nvim",
				config = [[require('colorful-winsep').setup()]]
			}
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
