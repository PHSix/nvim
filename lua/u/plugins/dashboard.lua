local dashboard = require("dashboard")

-- "Telescope find_files find_command=rg,--hidden,--files"
local cmds = {
	file_recent = "Telescope oldfiles",
	find_files = "Telescope find_files",
	live_grep = "Telescope live_grep",
}
dashboard.custom_center = {
	{
		icon = "  ",
		desc = "Recently opened files                   ",
		action = cmds.file_recent,
		shortcut = "SPC f h",
	},
	{
		icon = "  ",
		desc = "Find  File                              ",
		action = cmds.find_files,
		shortcut = "SPC f f",
	},
	{
		icon = "  ",
		desc = "Find  word                              ",
		aciton = cmds.live_grep,
		shortcut = "SPC f w",
	},
}

local height = vim.fn.winheight(0)

local fill_height = math.floor((height - #dashboard.default_banner - (#dashboard.custom_center + 1) * 2) / 3)
local header = {}


-- local default_banner = {
-- 	" ██████╗  █████╗ ███████╗██╗  ██╗██████╗  ██████╗  █████╗ ██████╗ ██████╗  ",
-- 	" ██╔══██╗██╔══██╗██╔════╝██║  ██║██╔══██╗██╔═══██╗██╔══██╗██╔══██╗██╔══██╗ ",
-- 	" ██║  ██║███████║███████╗███████║██████╔╝██║   ██║███████║██████╔╝██║  ██║ ",
-- 	" ██║  ██║██╔══██║╚════██║██╔══██║██╔══██╗██║   ██║██╔══██║██╔══██╗██║  ██║ ",
-- 	" ██████╔╝██║  ██║███████║██║  ██║██████╔╝╚██████╔╝██║  ██║██║  ██║██████╔╝ ",
-- 	" ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═╝  ╚═╝╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═════╝  ",
-- 	"",
-- 	"[ Hello, world! ]",
-- 	"",
-- }

local footer = { "🎉 neovim is best editor for coding" }

for _ = 0, fill_height, 1 do
	table.insert(header, "")
end

-- for _, v in ipairs(default_banner) do
-- 	table.insert(header, v)
-- end
dashboard.custom_header = {
[[                            .:=====-:..         ..................:-::]],
[[      鸡你太美        ..... =####*##*+:        ................... ...]],
[[                     .     .:+===-==:    .    ......................  ]],
[[                  ... .-==:+%%#=-=++:-:.  ...... .....................]],
[[                ..   :#%%@%=%@@@%#%@-#@%*:     .......................]],
[[              ..  .-+%@@@%##%@%%@@%##%@@@@#+--:.    ..................]],
[[            ..  :=#@@@%#**%@@@@@%+==:.:-=+*#%%%#**+:.  ...............]],
[[           .  :*@@%#%%**%@@@@%*=.           ..:=*####+. ..............]],
[[      ....  :*@%+-=+**########+- ........... :---::-=+: ..............]],
[[....  ..  -*@*-.  =*************. ...........=++==++++: ..............]],
[[::::.....:+#*. .. -++++**=***+++=: ...........-=+++=-.................]],
[[:::::::.--.........++==+= :+#*++=+: ..........  ...   ................]],
[[:::::::::::....... :+====.  :+++==+: .................................]],
[[::::::::::::::.... :+===+: . .-+++++: ................................]],
[[.::::::::::::::::..:++++=..... -**+*- ................................]],
}
dashboard.custom_footer = footer
vim.defer_fn(function()
	vim.cmd([[
		hi DashboardHeader guifg=#F7144A
		hi DashboardCenterIcon guifg=#64D494
		hi DashboardShortCut guifg=#CAEDF8 gui=italic
		hi DashboardCenter guifg=#44B0D7
		hi DashboardFooter guifg=#FA3B07 gui=bold
	]])
	-- vim.cmd([[hi! link DashboardHeader Keyword]])
	-- vim.cmd([[hi! link DashboardFooter Error]])
	-- vim.cmd([[hi! link DashboardCenter GitSignsChange]])
	-- vim.cmd([[hi! link DashboardCenterIcon GitSignsAdd]])
	-- vim.cmd([[hi! link DashboardShortCut IndentBlankLineContextChar]])
	-- vim.cmd([[hi! DashboardShortCut gui=bold]])
end, 1)

vim.cmd([[autocmd Filetype dashboard nmap <buffer><silent> q <Cmd>:q<CR>]])
