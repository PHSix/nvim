-- Disable some builtin plugins.
local disabled_built_ins = {
	"2html_plugin",
	"gzip",
	"matchit",
	"rrhelper",
	"netrw",
	"netrwPlugin",
	"netrwSettings",
	"netrwFileHandlers",
	"zip",
	"zipPlugin",
	"tar",
	"tarPlugin",
	"getscript",
	"getscriptPlugin",
	"vimball",
	"vimballPlugin",
	"logipat",
	"spellfile_plugin",
}
for _, plugin in pairs(disabled_built_ins) do
	vim.g["loaded_" .. plugin] = 1
end

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
vim.bo.shiftwidth = 2
vim.bo.softtabstop = 2
vim.bo.tabstop = 2
vim.o.shiftwidth = 2
vim.o.softtabstop = 2
vim.o.tabstop = 2

-- back file
vim.bo.undofile = true
vim.bo.swapfile = false
vim.o.undofile = true
vim.o.swapfile = false

-- theme options
vim.o.background = "dark"
vim.o.termguicolors = true

-- remap keymap
vim.keymap.set("n", ";", ":", { noremap = true })
vim.keymap.set("n", "fy", "\"+y", { noremap = true })

-- autocmd
vim.api.nvim_create_autocmd("FileType", {
	pattern = { "help" },
	callback = function()
		vim.api.nvim_buf_set_keymap(0, "n", "q", ":q<CR>", { silent = true, noremap = true })
	end,
})

vim.cmd([[language en_US.utf8]])
