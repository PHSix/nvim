--- filter in a array table
--- @param tbl table
--- @param callback fun(value: any,index?: string | number, sel?: table): boolean
--- @return table
return function (tbl, callback)
	local ret = {}

	for index, value in ipairs(tbl) do
		local t = callback(value, index, tbl)
		assert(type(t) == "boolean", 'filter callback need return a boolean')
		table.insert(ret, t)
	end

	return ret
end
