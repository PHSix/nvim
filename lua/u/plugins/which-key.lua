local wk = require("which-key")
wk.setup()

wk.register({
	f = {
		name = "Fuzzy Finder",
		
		f = {"<Cmd>Leadef file<CR>", "Find File"},
		w = {"<Cmd>Leadef line<CR>", "Live Grep"},
		b = {"<Cmd>Leadef buffer<CR>", "Find Buffer"},
	},
},{ prefix = "<leader>" })
