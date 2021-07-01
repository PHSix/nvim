local map = vim.api.nvim_set_keymap

local M = {}
M.g = function(mode,key, value, opts)
	map(mode, key, value, opts)
end

M.gn = function(key, value, opts)
	map("n", key, value, opts)
end

M.gi = function(key, value, opts)
	if opts == nil then
		opts = {}
	end
	if opts["expr"] == nil then
		opts["expr"] = true
	end
	map("i", key, value, opts)
end

M.gv = function(key, value, opts)
	map("i", key, value, opts)
end


return M
