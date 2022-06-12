local packer = require("packer")
local use = packer.use
local health = require("_health")

use("wbthomason/packer.nvim")

--
-- startup preview
--

use({
	"mhinz/vim-startify",
})

--
-- bufferline
--

use({
	"akinsho/nvim-bufferline.lua",
	requires = { "kyazdani42/nvim-web-devicons" },
	config = function()
		require(_G.p("modules.bufferline"))
	end,
})

--
-- lsp
--

use({
	"neovim/nvim-lspconfig",
	requires = {
		{
			"weilbith/nvim-code-action-menu",
			cmd = "CodeActionMenu",
		},
		{ "b0o/schemastore.nvim" },
		{ "williamboman/nvim-lsp-installer" },
		{ "tami5/lspsaga.nvim", branch = "main" },
		{ "jose-elias-alvarez/null-ls.nvim" },
	},
	config = function()
		require(_G.p("modules.lsp")).setup()
	end,
})

use({
	"folke/trouble.nvim",
	cmd = "TroubleToggle",
	config = function()
		require("trouble").setup({
			auto_open = true,
			auto_close = true,
		})
	end,
})

use({
	"amrbashir/nvim-docs-view",
	cmd = { "DocsViewToggle" },
	config = function()
		require("docs-view").setup({
			position = "right",
			width = 60,
		})
	end,
})

use({
	"simrat39/symbols-outline.nvim",
	cmd = { "SymbolsOutline" },
	config = function()
		require(_G.p("modules.outline"))
	end,
})

-- rust
use({
	"simrat39/rust-tools.nvim",
	disable = not health["cargo"],
	ft = { "rust" },
	config = function()
		require(_G.p("modules.rust"))
	end,
})

--
-- fuzzy finder engine
--
use({
	"nvim-telescope/telescope.nvim",
	keys = { "<C-f>", "<A-x>" },
	cmd = { "Telescope" },
	requires = {
		{ "nvim-lua/popup.nvim", opt = true },
		{ "nvim-lua/plenary.nvim" },
		{ "AckslD/nvim-neoclip.lua" },
	},
	config = function()
		require(_G.p("modules.telescope"))
	end,
})

-- treesitter syntax
use({
	"nvim-treesitter/nvim-treesitter",
	requires = {
		{ "windwp/nvim-ts-autotag", ft = { "vue", "html", "javascriptreact", "typescriptreact" } },
		{ "p00f/nvim-ts-rainbow", event = { "BufReadPre" } },
		{ "JoosepAlviste/nvim-ts-context-commentstring" },
		{ "romgrk/nvim-treesitter-context" },
	},
	config = function()
		require("nvim-treesitter.configs").setup({
			indent = {
				enable = { "typescriptreact", "typescript", "javascriptreact", "javascript" },
			},
			autotag = {
				enable = true,
			},
			ensure_installed = {
				"c",
				"cpp",
				"rust",
				"typescript",
				"javascript",
				"html",
				"css",
				"scss",
				"go",
				"yaml",
				"dart",
				"toml",
				"python",
				"json",
				"fish",
				"cmake",
				"bash",
				"gomod",
				"lua",
				"tsx",
			},
			highlight = {
				enable = true,
				disable = { "rust" },
			},
			context_commentstring = {
				enable = true,
			},
		})
		require("treesitter-context").setup({
			enable = true,
			throttle = true,
			max_lines = 0,
			patterns = {
				default = {
					"class",
					"function",
					"method",
					"for",
					"while",
					"if",
					"switch",
					"case",
				},
			},
		})
	end,
})

--
-- terminal
--

use({
	"oberblastmeister/termwrapper.nvim",
	keys = { "<C-t>" },
	config = function()
		vim.api.nvim_set_keymap("n", "<C-t>", ":Ttoggle<CR>", { silent = true, noremap = true })
		vim.api.nvim_set_keymap("t", "<C-t>", "<C-\\><C-n>:Ttoggle<CR>", { silent = true })
		-- vim.cmd([[
		-- nnoremap <C-t> :Ttoggle<CR>
		-- tmap <silent> <C-t> <C-\><C-n>:Ttoggle<CR>
		-- ]])
		vim.cmd([[autocmd Filetype termwrapper lua vim.api.nvim_buf_set_option(0, "buflisted", false)]])

		require("termwrapper").setup({
			open_autoinsert = true,
			toggle_autoinsert = true,
			autoclose = true,
			winenter_autoinsert = false,
			default_window_command = "belowright 13split",
			open_new_toggle = true,
			log = 1,
		})
	end,
})

--
-- statusline
--

use({
	"ojroques/nvim-hardline",
	config = function()
		require("hardline").setup({})
	end,
})
--
-- colorscheme setting
--

-- greate support for terminal which want transparent
use({
	"tiagovla/tokyodark.nvim",
	config = function()
		vim.g.tokyodark_transparent_background = false
		vim.g.tokyodark_enable_italic_comment = true
		vim.g.tokyodark_enable_italic = true
		vim.g.tokyodark_color_gamma = "1.0"
		vim.cmd("colorscheme tokyodark")
	end,
})

--
-- markdown
--
use({
	"iamcco/markdown-preview.nvim",
	ft = { "markdown" },
	disable = not health["node"],
})

use({
	"dhruvasagar/vim-table-mode",
	ft = { "markdown" },
})

--
-- git plugin
--
use({
	"lewis6991/gitsigns.nvim",
	event = { "BufRead", "BufNewFile" },
	config = function()
		if not packer_plugins["plenary.nvim"].loaded then
			vim.cmd([[packadd plenary.nvim]])
		end
		require("gitsigns").setup({
			keymaps = {
				noremap = false,
				buffer = false,
			},
		})
		vim.keymap.set("n", "gj", "<CMD>:Gitsigns next_hunk<CR>", { silent = true })
		vim.keymap.set("n", "gk", "<CMD>:Gitsigns prev_hunk<CR>", { silent = true })
	end,
})

use({
	"TimUntersberger/neogit",
	cmd = { "Neogit" },
	config = function()
		require(_G.p("modules.neogit"))
	end,
})

use({
	"junegunn/gv.vim",
	cmd = { "GV" },
	requires = { { "tpope/vim-fugitive", opt = true } },
	config = function()
		vim.cmd([[packadd vim-fugitive]])
	end,
})

--
-- file tree preview
--
use({
	"nvim-neo-tree/neo-tree.nvim",
	branch = "v2.x",
	cmd = { "Neotree", "NeoTreeRevealToggle" },
	keys = { "<C-n>" },
	requires = {
		{ "nvim-lua/plenary.nvim" },
		{ opt = true, "kyazdani42/nvim-web-devicons" },
		{ opt = true, "MunifTanjim/nui.nvim" },
	},
	config = function()
		require(_G.p("modules.neo_tree"))
	end,
})

use("famiu/bufdelete.nvim")

--
-- impove vim use mothon plugins
--

-- A function and autocommand pair that removes all
use("mcauley-penney/tidy.nvim")

-- scrollbar plugin
use({
	"petertriho/nvim-scrollbar",
	config = function()
		require("scrollbar").setup({})
	end,
})

use({
	"edluffy/specs.nvim",
	config = function()
		require("specs").setup({
			show_jumps = true,
			min_jump = 30,
			popup = {
				delay_ms = 0, -- delay before popup displays
				inc_ms = 10, -- time increments used for fade/resize effects
				blend = 10, -- starting blend, between 0-100 (fully transparent), see :h winblend
				width = 10,
				winhl = "PMenu",
				fader = require("specs").linear_fader,
				resizer = require("specs").shrink_resizer,
			},
			ignore_filetypes = {},
			ignore_buftypes = {
				nofile = true,
			},
		})
	end,
})

use({
	"junegunn/vim-easy-align",
	keys = { "ga" },
	config = function()
		vim.cmd([[
			nmap ga <Plug>(EasyAlign)
			xmap ga <Plug>(EasyAlign)
		]])
	end,
})

use({
	"phaazon/hop.nvim",
	config = function()
		require("hop").setup({ keys = "asdfghjkl;'qweruiop" })
		vim.api.nvim_set_keymap("n", "s", ":HopChar2<CR>", { noremap = true, silent = true })
		vim.api.nvim_command("highlight default HopUnmatched guifg=#666666 guibg=bg guisp=#666666 ctermfg=242")
	end,
})

use({
	"lewis6991/impatient.nvim",
	config = function()
		require("impatient")
	end,
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

use("kevinhwang91/nvim-bqf")

use({
	"nathom/filetype.nvim",
	config = function()
		vim.g.did_load_filetypes = 1
	end,
})

use({
	"rktjmp/highlight-current-n.nvim",
	config = function()
		require("highlight_current_n").setup({
			highlight_group = "IncSearch",
		})
		vim.cmd([[
    nmap n <Plug>(highlight-current-n-n)
    nmap N <Plug>(highlight-current-n-N)
    nmap * *N
    augroup ClearSearchHL
      autocmd!
      autocmd CmdlineEnter /,\? set hlsearch
      autocmd CmdlineLeave /,\? set nohlsearch
      autocmd CmdlineLeave /,\? lua require('highlight_current_n')['/,?']()
    augroup END

    ]])
	end,
})

use({
	"tpope/vim-surround",
	keys = { "c", "d" },
})

use({
	"itchyny/vim-cursorword",
	-- event = { "CursorMoved" },
	config = function()
		vim.g.cursorword_highlight = 0
	end,
})

use({
	"tpope/vim-commentary",
	config = function()
		vim.api.nvim_set_keymap("n", ",cc", "gcc", { noremap = false, silent = true })
		vim.api.nvim_set_keymap("v", ",c", "gc", { noremap = false, silent = true })
		vim.api.nvim_set_keymap("x", ",cc", "gc", { noremap = false, silent = true })
	end,
})

use({
	"rafcamlet/nvim-luapad",
	cmd = { "Luapad" },
	config = function()
		require("luapad").config({
			count_limit = 150000,
			error_indicator = false,
			eval_on_move = true,
			error_highlight = "WarningMsg",
			on_init = function()
				print("Hello from Luapad!")
			end,
			context = {
				the_answer = 42,
				shout = function(str)
					return (string.upper(str) .. "!")
				end,
			},
		})
	end,
})

use({
	"voldikss/vim-translator",
	keys = { "<leader>tt" },
	config = function()
		vim.cmd([[
			nmap <silent> <Leader>tt <Plug>TranslateW
			vmap <silent> <Leader>tt <Plug>TranslateWV
		]])
	end,
})

use({
	"norcalli/nvim-colorizer.lua",
	config = function()
		vim.o.termguicolors = true
		require("colorizer").setup({
			cpp = { rgb_fn = true },
			c = { rgb_fn = true },
			lua = { rgb_fn = true },
			css = { rgb_fn = true },
			scss = { rgb_fn = true },
			vue = { rgb_fn = true },
			sass = { rgb_fn = true },
			stylus = { rgb_fn = true },
			vim = { names = true },
			tmux = { names = false },
			"javascript",
			"javascriptreact",
			"typescript",
			"typescriptreact",
			"json",
			html = {
				mode = "foreground",
			},
			"*",
		})
	end,
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
	"folke/todo-comments.nvim",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		require("todo-comments").setup({})
	end,
})

use({
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require(_G.p("modules.indentLine"))
	end,
})

use({
	"folke/twilight.nvim",
	cmd = { "Twilight", "TwilightEnable", "TwilightDisable" },
	config = function()
		require("twilight").setup({
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		})
	end,
})

use({
	"Pocco81/TrueZen.nvim",
	cmd = { "TZFocus" },
	config = function()
		require(_G.p("modules.zen"))
	end,
})

use({
	"Shougo/ddc.vim",
	requires = {
		"vim-denops/denops.vim",
		"Shougo/ddc-nvim-lsp",
		"~/git/ddc-nvim-lsp-sort",
		"Shougo/ddc-matcher_head",
		"Shougo/ddc-sorter_rank",
		"Shougo/ddc-around",
		"matsui54/denops-popup-preview.vim",
		"matsui54/denops-signature_help",
		"Shougo/pum.vim",
		"tani/ddc-fuzzy",
		"hrsh7th/vim-vsnip-integ",
		"hrsh7th/vim-vsnip",
		"delphinus/ddc-treesitter",
		"matsui54/ddc-buffer",
		"ippachi/ddc-yank",
		"LumaKernel/ddc-file",
		"windwp/nvim-autopairs",
		"tani/ddc-onp",
	},
	config = function()
		require(_G.p("modules.ddc"))
	end,
})

-- use({
-- 	"Shougo/ddc.vim",
-- 	event = { "InsertEnter" },
-- 	requires = {
-- 		{ "vim-denops/denops.vim" },
-- 		{ "Shougo/ddc-nvim-lsp", opt = true },
-- 		{ "tani/ddc-fuzzy", opt = true },
-- 		{ "Shougo/ddc-around", opt = true },
-- 	},
-- 	config = function()
-- 		require(_G.p("modules.ddc"))
-- 	end,
-- })

use("~/projects/go-completion")

vim.defer_fn(function()
	-- packer.loader("wilder.nvim")
end, 300)
