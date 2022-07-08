vim.defer_fn(function()
	-- vim.g.material_style = "oceanic"
	-- vim.cmd("colorscheme material")

	-- vim.g.everforest_background = "soft"
	vim.cmd([[colorscheme everforest]])

	-- vim.g.onedark_config = {
	-- 	style = "deep",
	-- }
	-- vim.cmd([[colorscheme onedark]])

	-- vim.cmd([[colorscheme deus]])

	vim.g.vista_default_executive = "coc"

	vim.g.exclude_ft = { "plaintext" }

	require('indent_guides').setup({
		indent_levels = 30;
		indent_guide_size = 1;
		indent_start_level = 1;
		indent_enable = true;
		indent_space_guides = true;
		indent_tab_guides = false;
		indent_soft_pattern = '\\s';
		exclude_filetypes = { 'help', 'dashboard', 'dashpreview', 'NvimTree', 'vista', 'sagahover', "neo-tree" };
		even_colors = { fg = '#2a3834', bg = '#332b36' };
		odd_colors = { fg = '#332b36', bg = '#2a3834' };
	})
end, 1)
