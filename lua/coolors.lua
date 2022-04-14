-- tooltips function for coolors colorscheme
local uv = vim.loop
local M = {}

local tailwind = nil

local function read_file_sync(path)
	local fd = assert(uv.fs_open(path, "r", 438))
	local stat = assert(uv.fs_fstat(fd))
	local data = assert(uv.fs_read(fd, stat.size, 0))
	assert(uv.fs_close(fd))
	return data
end

-- colors from tailwindcss
-- @return {table}
M.get_colors = function()
	if tailwind == nil then
		tailwind = vim.json.decode(read_file_sync("/home/ph/.config/nvim/static/tailwind.json"))
	end
	return tailwind
end

-- [[
-- highlight define api
-- @param t {table}
-- ]]
M.hi = function(t)
	local bg = ""
	local fg = ""
	local style = ""
	if t["bg"] ~= nil then
		bg = string.format("guibg=%s", t["bg"])
	end
	if t["fg"] ~= nil then
		fg = string.format("guifg=%s", t["fg"])
	end
	for idx in ipairs(t) do
		if idx ~= 1 then
			if style == "" then
				style = "gui="
			else
				style = style .. ","
			end
			style = style .. t[idx]
		end
	end
	local prefix = string.format("hi %s", t[1])
	local cmd = string.format("%s %s %s %s", prefix, bg, fg, style)
	vim.cmd(cmd)
end

-- [[
-- highlight link api
-- @param t {table}
-- ]]
M.link = function(t)
	local cmd = string.format("hi link %s %s", t[1], t[2])
	vim.cmd(cmd)
end


-- [[
-- debug function
-- ]]
M.debug = function()
	local fs = require("ludash").fs
	vim.cmd([[hl clear]])
	vim.cmd([[colorscheme coolors]])
	fs.watchFile("~/.config/nvim/colors/coolors.lua", {
		on_change = function()
			vim.cmd([[luafile ~/.config/nvim/colors/coolors.lua]])
		end,
		["repeat"] = true,
	})
end

return M
