local t = require("ludash.timer")
-- [[
-- debounce function
-- @params fn {function} debounce function
-- @params ms {intger} time in debounce
-- @params immediate {boolean} execute fn at first if true.
-- ]]
return function(fn, ms, immediate)
	local _flag = true
	local _t = nil
	if immediate then
		return function(...)
			if _flag then
				_flag = false
				fn(...)
			end
			if _t ~= nil and _t:get_due_in() ~= 0 then
				t.clearInterval(_t)
			end
			_t = t.setTimeout(function()
				_flag = true
			end, ms)
		end
	else
		return function()
			if _t ~= nil then
				t.clearInterval(_t)
			end
			_t = t.setTimeout(function()
				fn()
			end, ms)
		end
	end
end
