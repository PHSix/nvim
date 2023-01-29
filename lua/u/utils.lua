local M = {}
local fn = vim.fn
local api = vim.api
M.plugins_path = fn.stdpath("data") .. "/site/pack/packer"

function M.is_plugin_installed(plugins_name)
	if fn.empty(fn.glob(M.plugins_path .. "/start/" .. plugins_name)) > 0
		and fn.empty(fn.glob(M.plugins_path .. "/opt/" .. plugins_name)) > 0
	then
		return false
	else
		return true
	end
end

function M.push_async_task(callback, obj)
	obj = obj or {}
	local isRecord = obj.isRecord or false
	local start
	local async_task
	async_task = vim.loop.new_async(vim.schedule_wrap(function()
		if isRecord then
			start = vim.loop.hrtime()
		end
		callback()
		if isRecord then
			print("cost: " .. (vim.loop.hrtime() - start) / 1000000)
		end
		async_task:close()
	end))
	async_task:send()
end

M.getCwd = function()
	local is_success, ret = pcall(function()
		local folders = vim.g.WorkspaceFolders
		local path = nil
		local buffer_path = vim.fn.expand("%:p")
		for _, folder in ipairs(folders) do
			if string.match(buffer_path, folder) then
				if not path or folder.length > path.length then
					path = folder
				end
			end
		end

		return path
	end)
	if not is_success then
		ret = nil
	end
	return ret
end

-- [[
-- @params au_name {string}
-- @params aus {table}
-- @return {string}
-- ]]
M.create_augroup = function(au_name, aus)
	aus = aus or {}
	local id = api.nvim_create_augroup(au_name, { clear = true })
	for _, au in ipairs(aus) do
		api.nvim_create_autocmd(au[1], au[2])
	end
	return id
end

M.new_eventEmitter = function(opt)
	local Async = require("async")
	local async = Async.sync
	local await = Async.wait
	local t = {}
	opt = opt or { after_emit = function() end }

	-- @params ev {string}
	-- @params {any[]}
	t.emit = async(function(ev, ...)
		if t[ev] == nil then
			return
		end
		for _, cb in ipairs(t[ev]) do
			await(cb(...))
		end
		opt.after_emit()
	end)

	-- @params ev {string}
	-- @params cb {function}
	t.subscribe = function(ev, cb)
		if t[ev] == nil then
			t[ev] = {}
		end
		table.insert(t[ev], cb)
	end
	return t
end

return M
