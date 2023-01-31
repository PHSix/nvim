local Async = require('async')
local async = Async.sync
local await = Async.wait
return {
	remove_duplicates = function(str_table)
		local unique = {}
		local result = {}
		for _, str in ipairs(str_table) do
			if not unique[str] then
				unique[str] = true
				table.insert(result, str)
			end
		end
		return result
	end,

	concat_lists = function(list1, list2)
		local result = {}
		for _, item in ipairs(list1) do
			table.insert(result, item)
		end
		for _, item in ipairs(list2) do
			table.insert(result, item)
		end
		return result
	end,

	new_eventEmitter = function(opt)
		local store = {}
		local t = {}
		opt = vim.tbl_extend('keep', opt or {}, { after_emit = function() end })

		t.emit = function(ev)
			if store[ev] == nil then
				return
			end
			async(function()
				for _, cb in ipairs(store[ev]) do
					await(cb())
				end
				opt.after_emit()
			end)
		end

		t.subscribe = function(ev, cb)
			if store[ev] == nil then
				store[ev] = {}
			end
			table.insert(store[ev], cb)
		end

		t.clear = function()
			store = {}
		end
		return t
	end,

	--- list table map
	--- @param func function
	--- @param tb table
	--- @return table
	map = function(func, tb)
		assert(type(tb) == 'table', string.format('map need recive a table, but recive a %s', type(tb)))
		local ret = {}

		for idx, value in ipairs(tb) do
			table.insert(ret, func(value, idx, tb))
		end

		return ret
	end,

	--- @param group string
	--- @param t table
	hiTable = function(group, t)
		local cmd = string.format('hi %s', group)
		local default = vim.api.nvim_get_hl_by_name("StatusLine", true)
		local fg
		if t.style then
			cmd = cmd .. string.format(" gui=%s", t.style)
		end
		if t.fg then
			cmd = cmd .. string.format(" guifg=%s", t.fg)
		end
		if t.bg then
			cmd = cmd .. string.format(" guibg=%s", t.bg)
		end
		vim.cmd(cmd)
	end,

	--- clone deep table
	--- @parma t table
	--- @return table
	cloneDeep = function(t)
		return vim.tbl_deep_extend("keep", {}, t)
	end,

	debounce = function(fn, wait)
		local timer
		local uv = vim.loop
		return function(...)
			if timer then
				uv.timer.stop(timer)
			end
			timer = uv.timer.start(wait, 0, function()
				fn(...)
				timer = nil
			end)
		end

	end
}
