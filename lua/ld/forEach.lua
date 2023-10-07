--- map a array table
--- @generic T
--- @param tbl T[]
--- @param callback fun(value: T,index?: number, sel?: T[]): any
--- @return nil
return function(tbl, callback)
  assert(type(tbl) == 'table' and type(callback) == 'function')
  for index, value in ipairs(tbl) do
    callback(value, index, tbl)
  end
end
