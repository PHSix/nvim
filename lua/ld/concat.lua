---@generic T
---@param tbl1 T[]
---@param tbl2 T[]
---@return T
return function(tbl1, tbl2)
  local result = {}
  for _, t in ipairs(tbl1) do
    table.insert(result, t)
  end
  for _, t in ipairs(tbl2) do
    table.insert(result, t)
  end

  return result
end
