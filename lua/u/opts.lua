-- Disable some builtin plugins.
vim.g.loaded_gzip = 1
vim.g.loaded_tar = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_zip = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_getscript = 1
vim.g.loaded_getscriptPlugin = 1
vim.g.loaded_vimball = 1
vim.g.loaded_vimballPlugin = 1
vim.g.loaded_matchit = 1
-- vim.g.loaded_matchparen = 0
vim.g.loaded_2html_plugin = 1
vim.g.loaded_logiPat = 1
vim.g.loaded_rrhelper = 1
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1
vim.g.loaded_netrwSettings = 1
vim.g.loaded_netrwFileHandlers = 1
-- vim.g.did_load_filetypes = 1
-- vim.g.do_filetype_lua = 1

-- set listchars=tab:\|\ ,trail:▫

-- number
vim.o.nu = true
vim.o.rnu = true
vim.o.backup = false

-- sign column enable
vim.wo.signcolumn = "yes"

-- syntax
vim.bo.syntax = "on"

-- mouse control
vim.o.mouse = "a"

-- ignore case
vim.o.ignorecase = true
vim.o.smartcase = true

-- tab width
local tab_width = 4
vim.bo.shiftwidth = tab_width
vim.bo.softtabstop = tab_width
vim.bo.tabstop = tab_width
vim.o.shiftwidth = tab_width
vim.o.softtabstop = tab_width
vim.o.tabstop = tab_width

-- back file
vim.bo.undofile = true
vim.bo.swapfile = false
vim.o.undofile = true
vim.o.swapfile = false

-- cursorline
vim.wo.cursorline = true;
vim.o.cursorline = true;

-- theme options
vim.o.background = "dark"
vim.o.termguicolors = true

-- vim.opt.listchars = "tab:»·,nbsp:+,trail:·,extends:→,precedes:←"

-- remap keymap
vim.keymap.set("n", ";", ":", { noremap = true })
vim.keymap.set("v", "fy", '"+y', { noremap = false })

vim.o.laststatus = 3
vim.o.cmdheight = 0

-- tabline
vim.o.showtabline = 2

vim.o.scrolloff = 4

-- autocmd
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help" },
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "q", ":q<CR>", { silent = true, noremap = true })
	end,
})

if vim.loop.os_uname().sysname == "Linux" then
	vim.cmd([[language en_US.utf8]])
end
