local vim = vim
local M = {
	["win"] = {
		wrap = false;
    cursorline = true;
    number = true;
    relativenumber = true;
    scrolloff = 5;
		signcolumn = "yes";
	};
	["buf"] = {
		undofile = true;
    tabstop = 2;
    shiftwidth = 2;
    softtabstop = 2;
    expandtab = true;
    swapfile = false;
    autoindent = true;
    syntax = "on";
	};
	["glo"] = {
		guifont = "FiraCode Nerd Font:h13";
    mouse = "a";
    undofile = true;
    tabstop = 2;
    shiftwidth = 2;
    softtabstop = 2;
    expandtab = true;
    autowrite = true;
    swapfile = false;
    hlsearch = true;
    ignorecase = true;
    smartcase = true;
    backup = false;
    autochdir = true;
    autoindent = true;
    history = 400;
    encoding = "utf-8";
    fileencodings = "utf-8,gb2312,gbk,gb18030";
    syntax = "on";
    hidden = true;
    writebackup = true;
    showtabline = 0;
	}
}

local function set_env_variable ()
	for key, value in pairs(M["win"]) do
		vim.wo[key] = value
	end
	for key, value in pairs(M["buf"]) do
		vim.bo[key] = value
	end
	for key, value in pairs(M["glo"]) do
		vim.o[key] = value
	end
end
set_env_variable()

