vim.api.nvim_set_keymap("n", "<C-f>f", ":Telescope find_files<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-f>u", ":Telescope oldfiles<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<C-f>w", ":Telescope live_grep<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<A-x>", ":Telescope commands<CR>", { silent = true })
vim.api.nvim_set_keymap("n", "<c-f>v", ":Telescope vimwiki<CR>", { silent = true })
vim.cmd([[packadd plenary.nvim]])
vim.cmd([[packadd popup.nvim]])
vim.cmd([[packadd telescope-vimwiki.nvim]])
vim.cmd([[packadd telescope-fzy-native.nvim]])
local actions = require("telescope.actions")
require("telescope").setup({
	defaults = {
		mappings = {
			i = {
				["<esc>"] = actions.close,
				["<C-j>"] = actions.move_selection_next,
				["<C-k>"] = actions.move_selection_previous,
			},
		},
		vimgrep_arguments = {
			"rg",
			"--color=never",
			"--no-heading",
			"--with-filename",
			"--line-number",
			"--column",
			"--smart-case",
		},
		prompt_prefix = " ⌨️  ",
		selection_caret = " 🔭 ",
		entry_prefix = "    ",
		initial_mode = "insert",
		selection_strategy = "reset",
		sorting_strategy = "descending",
		layout_strategy = "horizontal",
		layout_config = {
			horizontal = {
				mirror = false,
			},
			vertical = {
				mirror = false,
			},
		},
		file_sorter = require("telescope.sorters").get_fuzzy_file,
		file_ignore_patterns = {},
		generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
		winblend = 0,
		border = {},
		borderchars = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
		color_devicons = true,
		use_less = true,
		path_display = {},
		set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
		file_previewer = require("telescope.previewers").vim_buffer_cat.new,
		grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
		qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
		-- Developer configurations: Not meant for general override
		buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
	},
})
require("telescope").load_extension("vimwiki")

require("neoclip").setup()
