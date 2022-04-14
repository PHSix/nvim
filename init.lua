vim.g.os = "ph"
function _G.p(path)
	return vim.g.os .. "." .. path
end
function _G.complete_path(path)
	return vim.g.os .. "." .. path
end

require(vim.g.os .. ".core")
local uv = vim.loop
local opts = {
	watch_entry = false, -- true = when dir, watch dir inode, not dir content
	stat = false, -- true = don't use inotify/kqueue but periodic check, not implemented
	recursive = false,
}
local ludash = require("ludash")
local fn = function ()
	print("write")
end
local rep 
rep = function ()
	local handle = uv.new_fs_event()
	handle:start("/home/ph/.config/nvim/init.lua", opts, function ()
		print("hello worl")
		handle:stop()
		handle:close()
		fn()
		rep()
	end)
end
rep()
