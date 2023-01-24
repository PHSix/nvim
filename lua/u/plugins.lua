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
	{ "nvim-lua/plenary.nvim", lazy = true },
	{ "RishabhRD/popfix", lazy = true },
	{ "kevinhwang91/promise-async", lazy = true },
	{ "MunifTanjim/nui.nvim", lazy = true },
	"tpope/vim-repeat",
	"navarasu/onedark.nvim",
	"sainnhe/everforest",
	"sainnhe/sonokai",
	"tiagovla/tokyodark.nvim",
	"marko-cerovac/material.nvim",
	"Th3Whit3Wolf/one-nvim",
	"sam4llis/nvim-tundra",
	"folke/noice.nvim",
	"romainl/vim-cool",
	"xiyaowong/nvim-cursorword",
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
	{ "kartikp10/noctis.nvim", dependencies = { "rktjmp/lush.nvim" } },
	{ "projekt0n/github-nvim-theme" },
	{ "catppuccin/nvim", as = "catppuccin" },
	{ "famiu/bufdelete.nvim", cmd = "Bdelete" },
	{ "kyazdani42/nvim-web-devicons" },
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
		"ethanholz/nvim-lastplace",
		event = "BufRead",
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
	},
	{
		"numToStr/Comment.nvim",
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
		event = { "BufReadPost" },
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
		keys = { "j", "k" },
		config = function()
			vim.api.nvim_set_keymap("n", "j", "<Plug>(faster_move_gj)", { noremap = false, silent = true })
			vim.api.nvim_set_keymap("n", "k", "<Plug>(faster_move_gk)", { noremap = false, silent = true })
			vim.api.nvim_set_keymap("v", "j", "<Plug>(faster_vmove_j)", { noremap = false, silent = true })
			vim.api.nvim_set_keymap("v", "k", "<Plug>(faster_vmove_k)", { noremap = false, silent = true })
		end,
	},
	{
		"itchyny/lightline.vim",
		dependencies = {
			"mengelbrecht/lightline-bufferline",
			"josa42/vim-lightline-coc",
		},
		config = function()
			r("plugins.lightline")
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
	{ "skywind3000/asynctasks.vim", lazy = true, requires = { "skywind3000/asyncrun.vim", lazy = true } },
	-- use({ "romgrk/barbar.nvim", event = { "BufRead", "BufNewFile" } })
	{
		"kevinhwang91/nvim-ufo",
		config = function()
			r("plugins.ufo")
		end,
	},
	{
		"neoclide/coc.nvim",
		branch = "release",
		config = function()
			r("plugins.coc")
		end,
	},
	{
		"lukas-reineke/indent-blankline.nvim",
		config = function()
			r("plugins.indentline")
		end,
	},
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
	{ "JoosepAlviste/nvim-ts-context-commentstring" },
	{
		"nvim-treesitter/nvim-treesitter",
		-- branch = "v0.8.0",
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
				context_commentstring = {
					enable = true,
				},
				rainbow = {
					enable = true,
					-- disable = { "jsx", "cpp" }, list of languages you want to disable the plugin for
					extended_mode = true, -- Also highlight non-bracket delimiters like html tags, boolean or table: lang -> boolean
					max_file_lines = nil, -- Do not enable for files with more than n lines, int
					-- colors = {}, -- table of hex strings
					-- termcolors = {} -- table of colour name strings
				}
			})
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
		config = function()
			require("colorful-winsep").setup()
		end,
	},
	{ "lervag/vimtex", ft = { 'tex' }, config = function()
		r('plugins.vimtex')
	end
	},
	{ "norcalli/nvim-colorizer.lua",
		event = { "BufRead" },
		config = function()
			require 'colorizer'.setup()
		end
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
})

r("default")
-- config = {
-- 			compile_path = fn.stdpath("config") .. "/plugin/" .. "packer_compiled.lua",
-- 			git = {
-- 				clone_timeout = 30,
-- 			},
-- 			profile = {
-- 				enable = true,
-- 				threshold = 3,
-- 			},
-- 		},
