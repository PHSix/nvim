local utils = r("utils")
local map = require("ld.map")

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
	-- [[
	--    dependences
	-- ]]
	"nvim-lua/plenary.nvim",
	"RishabhRD/popfix",
	"kevinhwang91/promise-async",
	"MunifTanjim/nui.nvim",
	"tpope/vim-repeat",
	"kyazdani42/nvim-web-devicons",
	"romainl/vim-cool",
	"rktjmp/lush.nvim",
	"JoosepAlviste/nvim-ts-context-commentstring",
	{ "PHSix/coc-prettier",         build = "yarn && yarn prepare" },
	-- [[
	--    colorschemes
	-- ]]
	"navarasu/onedark.nvim",
	"sainnhe/everforest",
	"Shatur/neovim-ayu",
	"sainnhe/sonokai",
	"tiagovla/tokyodark.nvim",
	"marko-cerovac/material.nvim",
	"kartikp10/noctis.nvim",
	"Th3Whit3Wolf/one-nvim",
	"sam4llis/nvim-tundra",
	"projekt0n/github-nvim-theme",
	{
		"catppuccin/nvim",
		as = "catppuccin",
	},
	"sainnhe/gruvbox-material",
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
		"famiu/bufdelete.nvim",
		cmd = "Bdelete"
	},
	{
		"glepnir/hlsearch.nvim",
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
		"lewis6991/gitsigns.nvim",
		event = { "VeryLazy" },
		cmd = { "Gitsigns" },
		config = function()
			r("plugins.gitsign")
		end,
	},

	{
		"kdheepak/lazygit.nvim",
		cmd = { "LazyGitCurrentFile" }
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
		event = { "BufRead" },
		config = function()
			r("plugins.indentline")
		end,
	},
	{ "nvim-treesitter/playground", cmd = "TSPlaygroundToggle" },
	{
		"nvim-treesitter/nvim-treesitter",
		dependencies = { "RRethy/nvim-treesitter-textsubjects", },
		event = { "VeryLazy" },
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
		enabled = false,
		config = function()
			require("colorful-winsep").setup()
		end,
	},
	{
		"norcalli/nvim-colorizer.lua",
		event = { "VeryLazy" },
		config = function()
			require 'colorizer'.setup()
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
			-- require('wlsample.evil_line')
			r("plugins.windline")
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
	{
		"kristijanhusak/vim-dadbod-ui",
		dependencies = {
			"tpope/vim-dadbod",
		},
		cmd = { "DBUIToggle" },
		keys = { "<c-m>" },
		config = function()
			r('plugins.dadbob')
		end
	},
	{
		"folke/flash.nvim",
		event = "VeryLazy",
		opts = {},
		keys = {
			{ "s", mode = { "n", "x", "o" }, function() require("flash").jump() end,       desc = "Flash" },
			{ "S", mode = { "n", "o", "x" }, function() require("flash").treesitter() end, desc = "Flash Treesitter" },
			{
				"r",
				mode = "o",
				function() require("flash").remote() end,
				desc =
				"Remote Flash"
			},
			{
				"R",
				mode = { "o", "x" },
				function() require("flash").treesitter_search() end,
				desc =
				"Treesitter Search"
			},
			{
				"<c-s>",
				mode = { "c" },
				function() require("flash").toggle() end,
				desc =
				"Toggle Flash Search"
			},
		},
	},
	{
		"gpanders/editorconfig.nvim",
	}
}

require("lazy").setup(map(tbl, function(record)
	if type(record) == 'string' then
		return {
			record,
			lazy = true
		}
	end
	return record;
end), {
	performance = {
		enable = true,
	},
	git = {
		timeout = 30
	}
})

r("default")
