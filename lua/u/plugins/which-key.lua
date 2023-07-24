local wk = require("which-key")
vim.cmd([[Lazy load telescope.nvim]])
local builtin = require("telescope.builtin")

local getCwd = function()
	local ok, ret = pcall(function()
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
	if not ok then
		ret = nil
	end
	return ret
end

wk.register({
	d = {
		"<Cmd>Telescope coc definitions<CR>",
		"LSP goto definition",
	},
	i = {
		"<Cmd>Telescope coc implementations<CR>",
		"LSP goto implementation",
	},
	r = {
		"<Cmd>Telescope coc references<CR>",
		"LSP goto references",
	},
	y = {
		"<Cmd>Telescope coc type_definitions<CR>",
		"LSP goto type definition"
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
		s = { "<Cmd>Telescope coc workspace_symbols<CR>", "Find Worksapce Symbols" },

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

		n = { "<Cmd>CocCommand explorer --position floating<CR>", "File Floating Tree Broswer " },
	},

	t = {
		name = "Tabline",
	},

	m = {
		name = "Misc",
		v = { "<Cmd>Vista<CR>", "Symbol Outline(BY Visita)" },
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
			"<Cmd>Telescope coc line_code_actions<CR>",
			"LSP Line Code Action",
		},
		f = {
			"<Cmd>CocFormat<CR>",
			"LSP Code Format",
		},
	},

	g = {
		name = "Git",
		j = { "<Cmd>Gitsigns next_hunk<CR>", "Goto Next Hunk" },
		k = { "<Cmd>Gitsigns prev_hunk<CR>", "Goto Prev Hunk" },
		s = { "<Cmd>Gitsigns stage_hunk<CR>", "Stage this hunk" },
		u = { "<Cmd>Gitsigns undo_stage_hunk<CR>", "Undo stage this hunk" },
		p = { "<Cmd>Gitsigns preview_hunk<CR>", "Preview this hunk" },
		d = { "<Cmd>DiffviewFileHistory<CR>", "Git History" },

		g = { "<Cmd>LazyGitCurrentFile<CR>", "Open LazyGit" },
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

		d = { "<Cmd>Bdelete<CR>", "Delete Current Buffer" },

		h = { "<Cmd>BufferLineCloseLeft<CR>", "Close left buffers" },
		l = { "<Cmd>BufferLineCloseRight<CR>", "Close right buffers" },
	},

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

wk.register({
	r = { "<Plug>(coc-codeaction-refactor-selected)", "Coc Code Refactor" },
}, { mode = "x", prefix = "<leader>" })

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
		border = "none",    -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	ignore_missing = false,
})

vim.cmd([[map <space> <leader>]])
