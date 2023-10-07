--- filter in a array table
--- @generic T
--- @param tbl T[]
--- @param callback fun(value: T,index?:  number, sel?: T[]): boolean
--- @return T[]
return function(tbl, callback)
  local ret = {}

  for index, value in ipairs(tbl) do
    local t = callback(value, index, tbl)
    assert(type(t) == 'boolean', 'filter callback need return a boolean')
    if t == true then
      table.insert(ret, value)
    end
  end

  return ret
end
