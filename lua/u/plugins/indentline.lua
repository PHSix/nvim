vim.g.indent_blankline_char = "│"
vim.g.indent_blankline_show_first_indent_level = true
vim.g.indent_blankline_filetype_exclude = {
	"startify",
	"dashboard",
	"dotooagenda",
	"log",
	"fugitive",
	"gitcommit",
	"packer",
	"vimwiki",
	"markdown",
	"json",
	"txt",
	"vista",
	"help",
	"todoist",
	"NvimTree",
	"peekaboo",
	"git",
	"TelescopePrompt",
	"undotree",
	"flutterToolsOutline",
	"dart",
	"",
}
vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_show_trailing_blankline_indent = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
	"class",
	"function",
	"method",
	"block",
	"list_literal",
	"selector",
	"^if",
	"^table",
	"if_statement",
	"while",
	"for",
}
vim.o.list = true
-- vim.opt.listchars:append("eol:↴,space: ")
vim.opt.list = true
vim.opt.listchars:append("eol:↴")

-- vim.opt.listchars:append("tab:|")

require("indent_blankline").setup({
	space_char_blankline = " ",
})
