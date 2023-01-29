require("dashboard").setup({
	theme = 'hyper',
	config = {
		shortcut = {
			{ desc = ' Update', group = '@property', action = 'Lazy update', key = 'u' },
			{
				desc = ' Files',
				group = 'Label',
				action = 'Telescope find_files',
				key = 'f',
			},
			{
				desc = ' Grep',
				group = 'Number',
				action = 'Telescope live_grep',
				key = 'g',
			},
		},
		project = { enable = false, limit = 0 }
	},
	hide = {
		statusline = true,
		tabline = true,
		winbar = true,
	},
	-- preview = {
	--   command       -- preview command
	--   file_path     -- preview file path
	--   file_height   -- preview file height
	--   file_width    -- preview file width
	-- },
})
local group = vim.api.nvim_create_augroup("dashboard_au", {clear = true})
vim.api.nvim_create_autocmd({"Filetype"}, {
	pattern = {"dashboard"},
	callback = function ()
		vim.api.nvim_buf_set_keymap(0, 'n', 'q', '<Cmd>q<CR>',  {silent=true})
	end,
	group = group
})



