--- map a array table
--- @generic T
--- @generic R
--- @param tbl T[]
--- @param callback fun(value: T,index?: number, sel?: T[]): T[]
--- @return R[]
return function(tbl, callback)
  assert(type(tbl) == 'table' and type(callback) == 'function')
  local ret = {}

  for index, value in ipairs(tbl) do
    local t = callback(value, index, tbl)
    assert(t ~= nil, 'map callback function must return a value but not nil.')

    table.insert(ret, t)
  end

  return ret
end
