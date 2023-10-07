local forEach = require('ld.forEach')

--- @generic T
--- @generic R
--- @param tbl T[]
--- @param callback fun(result: R, value: T, index?: number, sel?: T[]): R
--- @param initial R
--- @return R
return function(tbl, callback, initial)
  forEach(tbl, function(value, index, sel)
    initial = callback(initial, value, index, sel)
  end)
  return initial
end
