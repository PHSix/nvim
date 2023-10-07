--- @generic T
--- @param tbl T[]
--- @param callback fun(value: T,index?: number, sel?: T[]): boolean
--- @return boolean
return function(tbl, callback)
  for index, value in ipairs(tbl) do
    local t = callback(value, index, tbl)
    if t == nil or t == false then
      return false
    end
  end
  return true
end
