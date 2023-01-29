local wk = require("which-key")
vim.cmd([[Lazy load telescope.nvim]])
local builtin = require("telescope.builtin")

local getCwd = function()
	local is_success, ret = pcall(function()
		local folders = vim.g.WorkspaceFolders
		local path = nil
		local buffer_path = vim.fn.expand("%:p")
		for _, folder in ipairs(folders) do
			if string.match(buffer_path, folder) then
				if not path or folder.length > path.length then
					path = folder
				end
			end
		end

		return path
	end)
	if not is_success then
		ret = nil
	end
	return ret
end

wk.register({
	d = {
		"<Plug>(coc-definition)",
		"LSP goto definition",
	},
	i = {
		"<Plug>(coc-implementation)",
		"LSP goto implementation",
	},
	r = {
		"<Plug>(coc-references)",
		"LSP goto references",
	},
	j = {
		"<CMD>:Gitsigns next_hunk<CR>",
		"Next Git Hunk",
	},
	k = {
		"<CMD>:Gitsigns prev_hunk<CR>",
		"Prev Git Hunk",
	},
}, { prefix = "g" })

wk.register({
	f = {
		name = "Finder",

		d = { "<Cmd>Telescope coc workspace_diagnostics<CR>", "Find Workspace Diagnostics" },

		o = { "<Cmd>Telescope oldfiles<CR>", "Recently Open Files" },

		r = { "<Cmd>Telescope resume<CR>", "Resume Action" },
		f = {
			function()
				builtin.find_files({ cwd = getCwd() })
			end,
			"Find File",
		},
		w = {
			function()
				builtin.live_grep({ cwd = getCwd() })
			end,
			"Live Grep",
		},
		b = { "<Cmd>Telescope buffers<CR>", "Find Buffer" },
		h = { "<Cmd>Telescope help_tags<CR>", "Find Help Doc" },
		y = { "<Cmd>Telescope registers<CR>", "Find Yank Registers" },
		c = { "<Cmd>Telescope git_bcommits<CR>", "Find Buffer Commits" },
		C = { "<Cmd>Telescope git_commits<CR>", "Find All Commits" },

		-- o = { "<Cmd>Clap history<CR>", "Recently Open Files" },
		-- f = { "<Cmd>Clap files<CR>", "Find File" },
		-- w = { "<Cmd>Clap grep2<CR>", "Live Grep" },
		-- b = { "<Cmd>Clap buffers<CR>", "Find Buffer" },
		-- h = { "<Cmd>Clap help_tags<CR>", "Find Help Doc" },
		-- y = { "<Cmd>Clap yanks<CR>", "Find Yanks" },
		-- r = { "<Cmd>Clap registers<CR>", "Find Registers" },

		n = { "<Cmd>CocCommand explorer --position floating<CR>", "File Floating Tree Broswer " },
	},

	t = {
		name = "Tabline",
	},

	m = {
		name = "Misc",
		v = { "<Cmd>Vista<CR>", "Symbol Outline(BY Visita)" },
		t = { "<Cmd>TranslateW<CR>", "Translate in Window" },
	},

	r = {
		name = "Re Action",
		n = {
			"<Plug>(coc-rename)",
			"LSP Rename",
		},
	},

	c = {
		name = "Code",
		a = {
			"<Plug>(coc-codeaction)",
			"LSP Code Action",
		},
		f = {
			"<Cmd>CocFormat<CR>",
			"LSP Code Format",
		},
		c = {
			"<Cmd>ChatGPT<CR>",
			"Open ChatGPT"
		},
	},

	g = {
		name = "Git",
		j = { "<Cmd>Gitsigns next_hunk<CR>", "Git Next Hunk" },
		k = { "<Cmd>Gitsigns prev_hunk<CR>", "Git Prev Hunk" },
		s = { "<Cmd>Gitsigns toggle_signs<CR>", "Git Toggle sign" },
		t = { "<Cmd>Gitsigns toggle_current_line_blame<CR>", "Git Toggle Lime Blame" },
		d = { "<Cmd>DiffviewFileHistory<CR>", "Git History Mode" },
	},

	j = {
		"<Plug>(coc-diagnostic-next)",
		"LSP Diagnostic Next",
	},

	k = {
		"<Plug>(coc-diagnostic-prev)",
		"LSP Diagnostic Prev",
	},

	b = {
		name = "Buffer",

		d = { "<Cmd>Bdelete", "Delete Current Buffer" },

		h = { "<Cmd>bp<CR>", "Goto Prev Buffer" },
		l = { "<Cmd>bn<CR>", "Goto Next Buffer" },
	},

	p = {
		name = "packer",
		i = { "<Cmd>PackerInstall<CR>", "Packer Install" },
		u = { "<Cmd>PackerUpdate<CR>", "Packer Update" },
		c = { "<Cmd>PackerClean<CR>", "Packer Clean" },
		s = { "<Cmd>PackerSync<CR>", "Packer Sync" },
		o = { "<Cmd>PackerStatus<CR>", "Packer Status" },
		y = { "<Cmd>PackerComplie<CR>", "Packer Complie" },
	},

	-- ["1"] = { "<Plug>lightline#bufferline#go(1)", "Goto Buffer 1" },
	-- ["2"] = { "<Plug>lightline#bufferline#go(2)", "Goto Buffer 2" },
	-- ["3"] = { "<Plug>lightline#bufferline#go(3)", "Goto Buffer 3" },
	-- ["4"] = { "<Plug>lightline#bufferline#go(4)", "Goto Buffer 4" },
	-- ["5"] = { "<Plug>lightline#bufferline#go(5)", "Goto Buffer 5" },
	-- ["6"] = { "<Plug>lightline#bufferline#go(6)", "Goto Buffer 6" },
	-- ["7"] = { "<Plug>lightline#bufferline#go(7)", "Goto Buffer 7" },
	-- ["8"] = { "<Plug>lightline#bufferline#go(8)", "Goto Buffer 8" },

	["1"] = { "<Cmd>BufferLineGoToBuffer 1<CR>", "Goto Buffer 1" },
	["2"] = { "<Cmd>BufferLineGoToBuffer 2<CR>", "Goto Buffer 2" },
	["3"] = { "<Cmd>BufferLineGoToBuffer 3<CR>", "Goto Buffer 3" },
	["4"] = { "<Cmd>BufferLineGoToBuffer 4<CR>", "Goto Buffer 4" },
	["5"] = { "<Cmd>BufferLineGoToBuffer 5<CR>", "Goto Buffer 5" },
	["6"] = { "<Cmd>BufferLineGoToBuffer 6<CR>", "Goto Buffer 6" },
	["7"] = { "<Cmd>BufferLineGoToBuffer 7<CR>", "Goto Buffer 7" },
	["8"] = { "<Cmd>BufferLineGoToBuffer 8<CR>", "Goto Buffer 8" },
	["9"] = { "<Cmd>BufferLineGoToBuffer 9<CR>", "Goto Buffer 9" },
}, { prefix = "<leader>" })

wk.setup({
	plugins = {
		marks = false,
		registers = false,
		spelling = {
			enabled = true,
			suggestions = 20,
		},
		presets = {
			operators = true,
			motions = true,
			text_objects = true,
			nav = true,
			z = false,
			g = false,
			windows = false, -- default bindings on <c-w>
		},
	},
	key_labels = {
		["<space>"] = "SPC",
		["<leader>"] = "SPC",
		["<cr>"] = "ENT",
		["<tab>"] = "TAB",
		["<a>"] = "ALT",
		["<s>"] = "SHI",
		["<c>"] = "CTR",
	},
	window = {
		border = "none", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	ignore_missing = false,
})

vim.cmd([[map <space> <leader>]])
