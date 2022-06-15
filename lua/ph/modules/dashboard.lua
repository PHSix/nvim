local dashboard = require("dashboard")

dashboard.custom_center = {
	{
		icon = "  ",
		desc = "Recently laset session                  ",
		shortcut = "SPC s l",
		action = "SessionLoad",
	},
	{
		icon = "  ",
		desc = "Recently opened files                   ",
		action = "Telescope oldfiles",
		shortcut = "SPC f h",
	},
	{
		icon = "  ",
		desc = "Find  File                              ",
		action = "Telescope find_files find_command=rg,--hidden,--files",
		shortcut = "SPC f f",
	},
	{
		icon = "  ",
		desc = "Find  word                              ",
		aciton = "Telescope live_grep",
		shortcut = "SPC f w",
	},
}

local height = vim.fn.winheight(0)

local fill_height = math.floor((height - #dashboard.default_banner - (#dashboard.custom_center + 1) * 2) / 3)
local header = {}

local default_banner = {
	" ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗  █████╗ ██████╗ ██████╗  ",
	" ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔══██╗ ",
	" ██║  ██║███████║███████╗███████║██████╔╝██║   ██║███████║██████╔╝██║  ██║ ",
	" ██║  ██║██╔══██║╚════██║██╔══██║██╔══██╗██║   ██║██╔══██║██╔══██╗██║  ██║ ",
	" ██████╔╝██║  ██║███████║██║  ██║██████╔╝╚██████╔╝██║  ██║██║  ██║██████╔╝ ",
	" ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ",
	"",
	"[ Dashboard version 0.2.1 ]",
	"",
}

for i = 0, fill_height, 1 do
	table.insert(header, "")
end

for _, v in ipairs(default_banner) do
	table.insert(header, v)
end

dashboard.custom_header = header
vim.defer_fn(function()
	vim.cmd([[hi! link DashboardHeader WarningMsg]])
end, 1)
