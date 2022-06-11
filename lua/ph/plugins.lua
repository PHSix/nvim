local packer = require("packer")
local use = packer.use
local health = require("_health")

use("wbthomason/packer.nvim")

--
-- startup preview
--
use({
	"goolord/alpha-nvim",
	disable = true,
	-- requires = { "kyazdani42/nvim-web-devicons" },
	config = function()
		require("alpha").setup(require(_G.p("modules.dashboard")).opts)
	end,
})

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

use({
	"nanozuki/tabby.nvim",
	disable = true,
	config = function()
		require("tabby").setup()
		-- vim.api.nvim_set_keymap("n", "<leader>ta", ":$tabnew<CR>", { noremap = true })
		-- vim.api.nvim_set_keymap("n", "<leader>tc", ":tabclose<CR>", { noremap = true })
		-- vim.api.nvim_set_keymap("n", "<leader>to", ":tabonly<CR>", { noremap = true })
		-- vim.api.nvim_set_keymap("n", "<leader>tn", ":tabn<CR>", { noremap = true })
		-- vim.api.nvim_set_keymap("n", "<leader>tp", ":tabp<CR>", { noremap = true })
		-- -- move current tab to previous position
		-- vim.api.nvim_set_keymap("n", "<leader>tmp", ":-tabmove<CR>", { noremap = true })
		-- -- move current tab to next position
		-- vim.api.nvim_set_keymap("n", "<leader>tmn", ":+tabmove<CR>", { noremap = true })
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
	"hoob3rt/lualine.nvim",
	disable = true,
	config = function()
		require(_G.p("modules.lualine"))
	end,
})

use({
	"windwp/windline.nvim",
	disable = true,
	config = function()
		-- require(_G.p("modules.windline"))
		require("wlsample.evil_line")
	end,
})

use({
	"ojroques/nvim-hardline",
	config = function()
		require("hardline").setup({})
	end,
})

--
-- auto completion
--
use({
	"hrsh7th/nvim-cmp",
	disable = true,
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
	config = function()
		require(_G.p("modules.cmp"))
	end,
})

use({
	"ms-jpq/coq_nvim",
	branch = "coq",
	requires = {
		{ "ms-jpq/coq.artifacts", branch = "artifacts" },
		{ "ms-jpq/coq.thirdparty", branch = "3p" },
	},
	config = function()
		require(_G.p("modules.coq"))
	end,
})
use({
	"gelguy/wilder.nvim",
	opt = true,
	config = function()
		vim.cmd([[
      call wilder#setup({'modes': [':', '/', '?']})
      call wilder#set_option('pipeline', [
            \   wilder#branch(
            \     wilder#cmdline_pipeline(),
            \     wilder#search_pipeline(),
            \   ),
            \ ])
      call wilder#set_option('renderer', wilder#popupmenu_renderer({
            \ 'highlighter': wilder#basic_highlighter(),
            \ }))
    ]])
	end,
})

--
-- flutter
--
use({
	"akinsho/flutter-tools.nvim",
	disable = not health["flutter"],
	requires = "nvim-lua/plenary.nvim",
	config = function()
		require(_G.p("modules.flutter"))
	end,
})

--
-- dap
--
use({
	"rcarriga/nvim-dap-ui",
	disable = true,
	requires = { "mfussenegger/nvim-dap", "Pocco81/DAPInstall.nvim" },
	config = function()
		require(_G.p("modules.dap"))
	end,
})

--
-- colorscheme setting
--

use({
	"PHSix/nvim-hybrid",
	disable = true,
	config = function()
		require("hybrid").setup()
		vim.cmd([[colorscheme hybrid]])
	end,
})

use({
	"sainnhe/everforest",
	disable = true,
	config = function()
		vim.o.termguicolors = true
		vim.g.everforest_background = "hard"
		vim.cmd([[colorscheme everforest]])
	end,
})

use({
	"sainnhe/gruvbox-material",
	disable = true,
	config = function()
		vim.cmd([[
    if has('termguicolors')
      set termguicolors
    endif
    set background=dark
    let g:gruvbox_material_background = 'medium'
    colorscheme gruvbox-material
    ]])
	end,
})

use({
	"Shatur/neovim-ayu",
	disable = true,
	config = function()
		require("ayu").setup({
			mirage = false,
			overrides = {},
		})
		vim.cmd([[colorscheme ayu]])
	end,
})

use({
	"mangeshrex/everblush.vim",
	disable = true,
	config = function()
		vim.g.everblushNR = 1
		vim.cmd([[colorscheme everblush]])
	end,
})

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
	"kdheepak/lazygit.nvim",
	disable = not health["lazygit"],
	config = function()
		vim.g.lazygit_floating_window_winblend = 0
		vim.g.lazygit_floating_window_scaling_factor = 0.9
		vim.g.lazygit_floating_window_corner_chars = { "╭", "╮", "╰", "╯" }
		vim.g.lazygit_floating_window_use_plenary = 0
		vim.g.lazygit_use_neovim_remote = 1
	end,
})

use({
	"TimUntersberger/neogit",
	cmd = { "Neogit" },
	config = function()
		require(_G.p("modules.neogit"))
	end,
})

-- preview diffview
use({
	"sindrets/diffview.nvim",
	opt = true,
	requires = { "nvim-lua/plenary.nvim" },
	config = function()
		require(_G.p("modules.diffview"))
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

--
-- code formatter
--

-- neoformat was slowly
use({
	"sbdchd/neoformat",
	opt = true,
	disable = true,
	config = function()
		vim.cmd([[
		augroup fmt
			autocmd!
			autocmd BufWritePre * undojoin | Neoformat
		augroup END
		]])
		vim.api.nvim_set_keymap("n", "<leader>cf", "<CMD>Neoformat<CR>", { silent = true, noremap = true })
	end,
})

--
-- golang coding enhance
--

use({
	"crispgm/nvim-go",
	disable = true,
	config = function()
		require("go").setup({})
	end,
})

use({
	"fatih/vim-go",
	ft = { "go" },
	disable = true,
	config = function()
		vim.g.go_def_mapping_enabled = 0
	end,
})

use({ "tweekmonster/gofmt.vim", disable = true })

--
-- lua development
--
use({
	"wesleimp/stylua.nvim",
	disable = true,
	-- disable = not health["stylua"],
	ft = { "lua" },
	config = function()
		local id = vim.api.nvim_create_augroup("lua_auto_format", { clear = true })
		vim.api.nvim_create_autocmd("BufWritePre", {
			pattern = { "*.lua" },
			callback = function()
				require("stylua").format()
			end,
			group = id,
		})
	end,
})

--
-- js/ts/frontend development
--
use({
	"prettier/vim-prettier",
	config = function()
		vim.g["prettier#autoformat"] = 1
		vim.g["prettier#autoformat_require_pragma"] = 0
	end,
	run = "yarn install --frozen-lockfile --production",
	ft = {
		"javascript",
		"typescript",
		"javascriptreact",
		"typescriptreact",
		"html",
		"css",
		"less",
		"scss",
		"json",
		"vue",
		"yaml",
	},
})

--
-- buffer
--
use({
	"matbme/JABS.nvim",
	config = function()
		-- (Optional) easy way to get Neovim current size.
		local ui = vim.api.nvim_list_uis()[1]
		vim.o.showtabline = 0

		require("jabs").setup({
			-- Options for the main window
			position = "corner", -- center, corner. Default corner
			width = 60, -- default 50
			height = 15, -- default 10
			border = "shadow", -- none, single, double, rounded, solid, shadow, (or an array or chars). Default shadow

			-- Options for preview window
			preview_position = "left", -- top, bottom, left, right. Default top
			preview = {
				width = 40, -- default 70
				height = 60, -- default 30
				border = "single", -- none, single, double, rounded, solid, shadow, (or an array or chars). Default double
			},

			-- Default highlights (must be a valid :highlight)
			highlight = {
				current = "Title", -- default StatusLine
				hidden = "StatusLineNC", -- default ModeMsg
				split = "WarningMsg", -- default StatusLine
				alternate = "StatusLine", -- default WarningMsg
			},

			-- Default symbols
			symbols = {
				current = "C", -- default 
				split = "S", -- default 
				alternate = "A", -- default 
				hidden = "H", -- default ﬘
				locked = "L", -- default 
				ro = "R", -- default 
				edited = "E", -- default 
				terminal = "T", -- default 
				default_file = "D", -- Filetype icon if not present in nvim-web-devicons. Default 
			},

			-- Whether to use nvim-web-devicons next to filenames
			use_devicons = true, -- true or false. Default true

			-- The options below are ignored when position = 'center'
			col = ui.width, -- Window appears on the right
			row = ui.height / 2, -- Window appears in the vertical middle
		})
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
	"rcarriga/nvim-notify",
	disable = true,
	config = function()
		vim.notify = require("notify")
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
	"b3nj5m1n/kommentary",
	disable = true,
	keys = { ",cc" },
	config = function()
		vim.api.nvim_set_keymap("n", ",cc", "<Plug>kommentary_line_default", {})
		vim.api.nvim_set_keymap("n", ",c", "<Plug>kommentary_motion_default", {})
		vim.api.nvim_set_keymap("v", ",c", "<Plug>kommentary_visual_default<C-c>", {})
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
	"windwp/nvim-autopairs",
	event = { "InsertEnter" },
	config = function()
		require(_G.p("modules.autopairs"))
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

vim.defer_fn(function()
	packer.loader("wilder.nvim")
end, 300)
