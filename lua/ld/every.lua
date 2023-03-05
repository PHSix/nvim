--- @param tbl table
--- @param callback fun(value: any,index?: string | number, sel?: table): boolean
return function(tbl, callback)
	for index, value in ipairs(tbl) do
		local t = callback(value, index, tbl)
		if t == nil and t == false then
			return false
		end
	end
	return true
end
