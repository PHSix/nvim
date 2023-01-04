local utils = r("utils")

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
local isMac = vim.loop.os_uname().system == "Darwin"

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
	"folke/which-key.nvim",
	{"nvim-lua/plenary.nvim", lazy=true},
	{"RishabhRD/popfix", lazy=true},
	{"kevinhwang91/promise-async", lazy=true},
	{"MunifTanjim/nui.nvim", lazy=true},
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
	{
		"lewis6991/impatient.nvim",
		enable = not isMac,
		config = function()
			require("impatient")
		end,
	},
	"mhinz/vim-startify",
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
		keys = { "c", "d" },
	},
	{
		"numToStr/Comment.nvim",
		config = function()
			require("Comment").setup({
				mappings = {
					basic = true,
					extra = false,
				},
			})
		end,
	},
	{
		"voldikss/vim-translator",
		cmd = { "TranslateW" },
	},
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufRead" },
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
		event = "BufRead",
		config = function()
			require("spectre").setup()
		end,
	},
	{
		"ggandor/leap.nvim",
		config = function()
			require("leap").add_default_mappings()
		end,
	},
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
	{
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
	{ "lervag/vimtex", config = function()
		r('plugins.vimtex')
	end
	},
}


require("lazy").setup(tbl, {
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
