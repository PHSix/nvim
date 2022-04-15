local packer = require("packer")
local use = packer.use

use "wbthomason/packer.nvim"

use({
	"goolord/alpha-nvim",
	requires = { "kyazdani42/nvim-web-devicons" },
	config = function()
		require("alpha").setup(require(_G.p("modules.dashboard")).opts)
	end,
})

-- [[
-- bufferline
-- ]]

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

use({
	"lukas-reineke/indent-blankline.nvim",
	config = function()
		require(_G.p("modules.indentLine"))
	end,
})

-- [[
-- lsp
-- ]]

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
	"simrat39/rust-tools.nvim",
	ft = { "rust" },
	config = function()
		require(_G.p("modules.rust"))
	end,
})

use({
	"simrat39/symbols-outline.nvim",
	cmd = { "SymbolsOutline" },
	config = function()
		require(_G.p("modules.outline"))
	end,
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
		{
			"rafamadriz/friendly-snippets",
			opt = true,
		},
	},
	config = function()
		require(_G.p("modules.cmp"))
	end,
})

use({
	"ms-jpq/coq_nvim",
	disable = true,
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
	"crispgm/nvim-go",
	requires = { { "nvim-lua/plenary.nvim", opt = true }, { "nvim-lua/popup.nvim", opt = true } },
	ft = { "go" },
	config = function()
		vim.cmd([[PackerLoad plenary.nvim]])
		vim.cmd([[PackerLoad popup.nvim]])
		require("go").setup({
			notify = true,
			auto_format = true,
			auto_lint = true,
			linter = "revive",
			linter_flags = {},
			lint_prompt_style = "qf",
			formatter = "goimports",
			test_flags = { "-v" },
			test_timeout = "30s",
			test_env = {},
			test_popup = true,
			test_popup_auto_leave = false,
			test_popup_width = 80,
			test_popup_height = 10,
			test_open_cmd = "edit",
			tags_name = "json",
			tags_options = { "json=omitempty" },
			tags_transform = "snakecase",
			tags_flags = { "-skip-unexported" },
			quick_type_flags = { "--just-types" },
		})
	end,
})

use({
	"PHSix/faster.nvim",
	keys = {"j", "k"},
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
	"nvim-telescope/telescope.nvim",
	keys = { "<C-f>", "<A-x>" },
	cmd = { "Telescope" },
	requires = {
		{ "nvim-lua/popup.nvim", opt = true },
		{ "nvim-lua/plenary.nvim" },
		{ "AckslD/nvim-neoclip.lua" },
		{ "ElPiloto/telescope-vimwiki.nvim", opt = true },
	},
	config = function()
		require(_G.p("modules.telescope"))
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
	"voldikss/vim-translator",
	keys = {"<leader>tt"},
	config = function()
		vim.cmd([[
			nmap <silent> <Leader>tt <Plug>TranslateW
			vmap <silent> <Leader>tt <Plug>TranslateWV
		]])
	end,
})

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
	end,
})

use({
	"jose-elias-alvarez/null-ls.nvim",
	requires = { "PlatyPew/format-installer.nvim" },
	config = function()
		require("format-installer").setup({
			installation_path = vim.fn.stdpath("data") .. "/formatters/",
		})
		local null_ls = require("null-ls")
		local formatter_install = require("format-installer")

		local sources = {}
		for _, formatter in ipairs(formatter_install.get_installed_formatters()) do
			local config = { command = formatter.cmd }
			table.insert(sources, null_ls.builtins.formatting[formatter.name].with(config))
		end

		null_ls.setup({
			sources = sources,
		})
	end,
})

use({
	"nvim-treesitter/nvim-treesitter",
	requires = {
		{ "windwp/nvim-ts-autotag", ft = { "vue", "html", "javascriptreact", "typescriptreact" } },
		{ "p00f/nvim-ts-rainbow", event = { "BufReadPre" } },
		{ "JoosepAlviste/nvim-ts-context-commentstring" },
	},
	config = function()
		require("nvim-treesitter.configs").setup({
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
			},
			highlight = {
				enable = true,
				disable = { "rust" },
			},
			context_commentstring = {
				enable = true,
			},
		})
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
	"dhruvasagar/vim-table-mode",
	ft = { "markdown" },
})

use({
	"itchyny/vim-cursorword",
	event = { "CursorMoved" },
})

use({
	"tpope/vim-commentary",
	config = function()
		vim.api.nvim_set_keymap("n", ",cc", "gcc", { noremap = false, silent = true })
		vim.api.nvim_set_keymap("v", ",cc", "gc", { noremap = false, silent = true })
		vim.api.nvim_set_keymap("x", ",cc", "gc", { noremap = false, silent = true })
	end,
})

use {
  "b3nj5m1n/kommentary",
  disable = true,
  keys = {",cc"},
  config = function ()
    vim.api.nvim_set_keymap("n", ",cc", "<Plug>kommentary_line_default", {})
    vim.api.nvim_set_keymap("n", ",c", "<Plug>kommentary_motion_default", {})
    vim.api.nvim_set_keymap("v", ",c", "<Plug>kommentary_visual_default<C-c>", {})
  end
}

use({
	"tpope/vim-surround",
	keys = { "c", "d" },
})

use({
	"oberblastmeister/termwrapper.nvim",
	keys = { "<C-t>" },
	config = function()
		vim.cmd([[
      nnoremap <C-t> :Ttoggle<CR>
      tmap <silent> <C-t> <C-\><C-n>:Ttoggle<CR>
    ]])
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
		require('wlsample.evil_line')
	end,
})

use {'ojroques/nvim-hardline',
config = function()
	require('hardline').setup {}
end
}

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

use "kevinhwang91/nvim-bqf"

use({
	"nathom/filetype.nvim",
	config = function()
		vim.g.did_load_filetypes = 1
	end,
})

use({
	"kyazdani42/nvim-tree.lua",
	config = function()
		require(_G.p("modules.nvim_tree"))
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
	"lewis6991/impatient.nvim",
	config = function()
		require("impatient")
	end,
})

use({
	"akinsho/flutter-tools.nvim",
	requires = "nvim-lua/plenary.nvim",
	config = function()
		require(_G.p("modules.flutter"))
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
	"rcarriga/nvim-dap-ui",
	disable = true,
	requires = { "mfussenegger/nvim-dap", "Pocco81/DAPInstall.nvim" },
	config = function()
		require(_G.p("modules.dap"))
	end,
})


-- [[
-- colorscheme setting
-- ]]

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
	"rcarriga/nvim-notify",
	config = function ()
		vim.notify = require("notify")
	end
})

use({
	"iamcco/markdown-preview.nvim",
	ft = {"markdown"},
})

use({
	"junegunn/vim-easy-align",
	keys = {"ga"},
	config = function ()
		vim.cmd [[
			nmap ga <Plug>(EasyAlign)
			xmap ga <Plug>(EasyAlign)
		]]
	end
})


vim.defer_fn(function()
	vim.cmd([[PackerLoad wilder.nvim]])
end, 300)
