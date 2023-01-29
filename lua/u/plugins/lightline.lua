vim.g.lightline = {
	colorscheme = "one",
	active = {
		left = {
			{ "mode", "paste" },
			{ "readonly", "filename", "modified" },
			{ "coc_info", "coc_hints", "coc_errors", "coc_warnings", "coc_ok" },
			{ "coc_status" },
		},
	},
}
vim.call("lightline#coc#register")
