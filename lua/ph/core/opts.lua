local M = {
	["global"] = {
		laststatus = 3,
		guifont = "Cascadia Mono PL:h15",
		mouse = "a",
		undofile = true,
		tabstop = 2,
		shiftwidth = 2,
		softtabstop = 2,
		expandtab = false,
		autowrite = true,
		swapfile = false,
		hlsearch = true,
		ignorecase = true,
		smartcase = true,
		backup = false,
		autochdir = true,
		autoindent = true,
		history = 400,
		encoding = "utf-8",
		fileencodings = "utf-8,gb2312,gbk,gb18030",
		syntax = "on",
		hidden = true,
		writebackup = true,
		showtabline = 2,
		splitright = false,
		splitbelow = true,
	},
	["buffer"] = {
		undofile = true,
		tabstop = 2,
		shiftwidth = 2,
		softtabstop = 2,
		expandtab = false,
		swapfile = false,
		autoindent = true,
		syntax = "on",
	},
	["win"] = {
		wrap = false,
		cursorline = true,
		number = true,
		relativenumber = true,
		scrolloff = 5,
		signcolumn = "yes",
		fdm = "marker",
	},
}

local function load_opts()
	for opt, value in pairs(M["buffer"]) do
		vim.bo[opt] = value
	end
	for opt, value in pairs(M["win"]) do
		vim.wo[opt] = value
	end
	for opt, value in pairs(M["global"]) do
		vim.o[opt] = value
	end
	vim.cmd([[language en_US.UTF-8]])
	if vim.fn.has("nvim-0.8.0") == 1 then
		vim.o.cmdheight = 0
	end
end

return {
	setup = load_opts,
}
