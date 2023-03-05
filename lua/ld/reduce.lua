local forEach = require("ld.forEach")
--- @param tbl table
--- @param callback fun(result: any,value: any, index?: string | number, sel?: table)
--- @param initial any
--- @return any
return function(tbl, callback, initial)
	forEach(tbl, function(value, index, sel)
		initial = callback(initial, value, index, sel)
	end)
	return initial
end
