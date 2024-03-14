--@param callback fun()
local function then_call(callback)
  return vim.defer_fn(callback, 0)
end

local function tbl_get(t, k, d)
  local v = vim.tbl_get(t, k)
  if v == nil and d then
    return d
  end

  return v
end

---@param val string
local function encode_value(val)
  local res, _ = string.gsub(val, '%%', '%%%%')

  return res
end

return {
  then_call = then_call,
  tbl_get = tbl_get,
  encode_value = encode_value,
}

