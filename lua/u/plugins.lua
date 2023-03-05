local utils = r("utils")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not vim.loop.fs_stat(lazypath) then
	vim.fn.system({
		"git",
		"clone",
		"--filter=blob:none",
		"https://github.com/folke/lazy.nvim.git",
		"--branch=stable", -- latest stable release
		lazypath,
	})
end
vim.opt.rtp:prepend(lazypath)

local tbl = {
	-- dependences
	"nvim-lua/plenary.nvim",
	"RishabhRD/popfix",
	"kevinhwang91/promise-async",
	"MunifTanjim/nui.nvim",
	"tpope/vim-repeat",
	"navarasu/onedark.nvim",
	"sainnhe/everforest",
	"sainnhe/sonokai",
	"tiagovla/tokyodark.nvim",
	"marko-cerovac/material.nvim",
	"kartikp10/noctis.nvim",
	"Th3Whit3Wolf/one-nvim",
	"sam4llis/nvim-tundra",
	"projekt0n/github-nvim-theme",
	"catppuccin/nvim",
	as = "catppuccin",
	"sainnhe/gruvbox-material",
	"kyazdani42/nvim-web-devicons",
	{ "folke/noice.nvim",
		event = { "VeryLazy" },
		config = function()
			require("noice").setup({
				cmdline_popup = {
					zindex = 100
				}
			})
		end },
	"romainl/vim-cool",
	"rktjmp/lush.nvim",
	{
		"xiyaowong/nvim-cursorword",
		event = { "VeryLazy" }
	},
	{
		"TimUntersberger/neogit",
		lazy = true,
		config = function()
			require("neogit").setup()
		end,
	},
	{
		"anuvyklack/hydra.nvim",
		keys = { "<leader>g" },
		config = function()
			r("plugins.hydra")
		end,
	},
	{ "famiu/bufdelete.nvim",       cmd = "Bdelete" },
	{ "glepnir/hlsearch.nvim",
		event = 'BufRead',
		config = function()
			require('hlsearch').setup()
		end
	},
	{
		"glepnir/dashboard-nvim",
		config = function()
			r("plugins.dashboard")
		end
	},
	-- "mhinz/vim-startify",
	{
		"ethanholz/nvim-lastplace", event = "BufRead",
		config = function()
			require("nvim-lastplace").setup({
				lastplace_ignore_buftype = { "quickfix", "nofile", "help" },
				lastplace_ignore_filetype = { "gitcommit", "gitrebase", "svn", "hgcommit" },
				lastplace_open_folds = true,
			})
		end,
	},
	{
		"tpope/vim-surround",
		event = { "VeryLazy" }
	},
	{
		"numToStr/Comment.nvim",
		event = { "VeryLazy" },
		config = function()
			require("Comment").setup({
				mappings = {
					basic = true,
					extra = false,
				},
				pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
			})
		end,
	},
	{
		"voldikss/vim-translator",
		cmd = { "TranslateW" },
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "VeryLazy" },
		cmd = { "Gitsigns" },
		config = function()
			r("plugins.gitsign")
		end,
	},
	{
		"folke/which-key.nvim",
		keys = {
			"<space>",
			"g",
		},
		config = function()
			r("plugins.which-key")
		end,
	},
	{
		"PHSix/faster.nvim",
		event = { "VeryLazy" },
		-- keys = { "j", "k" },
		enabled = false,
		config = function()
			vim.api.nvim_set_keymap("n", "j", "<Plug>(faster_move_gj)", { noremap = false, silent = true })
			vim.api.nvim_set_keymap("n", "k", "<Plug>(faster_move_gk)", { noremap = false, silent = true })
			vim.api.nvim_set_keymap("v", "j", "<Plug>(faster_vmove_j)", { noremap = false, silent = true })
			vim.api.nvim_set_keymap("v", "k", "<Plug>(faster_vmove_k)", { noremap = false, silent = true })
		end,
	},
	{
		"nvim-telescope/telescope.nvim",
		dependencies = { "fannheyward/telescope-coc.nvim", lazy = true },
		cmd = "Telescope",
		config = function()
			r("plugins.telescope")
		end,
	},
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewFileHistory", "DiffviewOpen" },
		config = function()
			r("plugins.diffview")
		end,
	},
	{
		"nvim-pack/nvim-spectre",
		cmd = {
			'SpectreSearch'
		},
		config = function()
			require("spectre").setup()

			vim.api.nvim_create_user_command("SpectreSearch", function()
				require('spectre').open_visual({
					cwd = utils.getCwd(),
				})
			end, { desc = "Spectre search width coc" })
		end,
	},
	-- {
	-- 	"ggandor/leap.nvim",
	-- 	config = function()
	-- 		require("leap").add_default_mappings()
	-- 	end,
	-- },
	{ "skywind3000/asynctasks.vim", lazy = true,    requires = { "skywind3000/asyncrun.vim", lazy = true } },
	-- use({ "romgrk/barbar.nvim", event = { "BufRead", "BufNewFile" } })
	{
		"kevinhwang91/nvim-ufo",
		event = { "VeryLazy" },
		config = function()
			r("plugins.ufo")
		end,
	},
	{
		"neoclide/coc.nvim",
		branch = "release",
		event = { "VeryLazy" },
		config = function()
			r("plugins.coc")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		-- enabled = false,
		-- event = { "VeryLazy" },
		event = { "BufRead" },
		config = function()
			r("plugins.indentline")
		end,
	},
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
	"JoosepAlviste/nvim-ts-context-commentstring",
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "RRethy/nvim-treesitter-textsubjects", },
		-- branch = "v0.8.0",
		event = { "VeryLazy" },
		config = function()
			-- vim.cmd [[Lazy load nvim-treesitter-textsubjects]]
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
					"bash",
					"fish",
					"haskell",
					"nix",
				},
				sync_install = false,
				auto_install = true,
				highlight = {
					enable = false,
					disable = { "c", "rust" },
					additional_vim_regex_highlighting = false,
				},
				context_commentstring = {
					enable = true,
				},
				textsubjects = {
					enable = true,
					prev_selection = ',', -- (Optional) keymap to select the previous selection
					keymaps = {
						['<CR>'] = 'textsubjects-smart',
						-- ['<CR>'] = 'textsubjects-container-outer',
						['i;'] = 'textsubjects-container-inner',
					},
				},
			})

			vim.keymap.set("n", "<CR>", function()
				vim.fn.feedkeys("<CR>", "v")
			end, { silent = true })
		end,
	},
	{
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
	},
	{
		"nvim-zh/colorful-winsep.nvim",
		event = { "VeryLazy" },
		config = function()
			require("colorful-winsep").setup()
		end,
	},
	{ "lervag/vimtex", ft = { 'tex' }, config = function()
		r('plugins.vimtex')
	end
	},
	{ "norcalli/nvim-colorizer.lua",
		event = { "VeryLazy" },
		config = function()
			require 'colorizer'.setup()
		end
	},
	{
		"jackMort/ChatGPT.nvim",
		cmd = { "ChatGPT" },
		config = function()
			vim.cmd [[Lazy load telescope.nvim]]
			require("chatgpt").setup({})
		end
	},
	{
		'akinsho/bufferline.nvim',
		event = { "BufEnter" },
		config = function()
			r('plugins.bufferline')
		end
	},
	{
		"windwp/windline.nvim",
		-- enabled = false,
		config = function()
			r("plugins.windline")
		end
	},
	{
		"Exafunction/codeium.vim",
		enabled = false,
		config = function()
			vim.g.codeium_disable_bindings = 1
		end
	},
	{
		"ii14/emmylua-nvim",
		lazy = false
	},
	{
		"psliwka/vim-smoothie",
		event = { "VeryLazy" },
	},
}

require("lazy").setup(vim.tbl_map(function(record)
	if type(record) == 'string' then
		return {
			record,
			lazy = true
		}
	end
	return record;
end, tbl), {
	performance = {
		enable = true,
	},
	git = {
		timeout = 30
	}
})

r("default")
