local debounce = require("ludash.debounce")
local uv = vim.loop
-- [[
-- watch file api
-- help you to automation call {t.on_change} when file content has change.
-- support absolute path and relative path.
-- @params filePath {string}
-- @params t {table}
-- ]]
local watchFile = function(filePath, t)
	-- check {t} type
	assert(type(t["on_change"]) == "function", "Watch file function api must provide a on_change function parameter.")
	if t["on_error"] == nil then
		t["on_error"] = function ()end
	end
	local _filesub = string.sub(filePath, 1, 1)
	-- translate relative path to absolute path
	if _filesub == "~" then
		filePath = vim.env.HOME .. string.sub(filePath, 2, string.len(filePath))
	end
	-- [[
	-- use debounce to merge on_change call.
	-- ]]
	local _fn = debounce(function()
		t.on_change()
	end, 70, true)
	if t["repeat"] == true then
		local _rep
		local _handle
		_rep = function()
			_handle = uv.new_fs_event()
			_handle:start(filePath, {
				recursive = true,
			}, function(err, filename, events)
				if err then
					t.on_error(err)
					return
				else
					_fn(filename, events, _handle)
				end
				_handle:stop()
				_handle:close()
				_rep()
			end)
		end
		_rep()
	else
		local _handle = uv.new_fs_event()
		_handle:start(filePath, {}, function(err, filename, events)
			if err then
				t.on_error(err)
				return
			else
				_fn(filename, events)
			end
			_handle:stop()
			_handle:close()
		end)
	end
end

return {
	watchFile = watchFile,
}
