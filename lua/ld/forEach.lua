--- map a array table
--- @param tbl table
--- @param callback fun(value: any,index?: string | number, sel?: table): any
return function(tbl, callback)
	assert(type(tbl) == "table" and type(callback) == "function")
	for index, value in ipairs(tbl) do
		callback(value, index, tbl)
	end
end
