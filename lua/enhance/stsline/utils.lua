--- @class Ref
--- @field get fun(): string
--- @field set fun(string)

local _update = function() end

local function trigger()
  _update()
end

---@param value string | fun():string
---@return Ref
local function ref(value)
  value = type(value) == 'string' and value or value()
  local obj = {}

  function obj.set(v)
    if value ~= v then
      value = v
      trigger()
    end
  end

  function obj.get()
    return value
  end

  return obj
end

---@param callback fun()
local function render(callback)
  callback()

  _update = callback
end

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
  render = render,
  ref = ref,
  then_call = then_call,
  tbl_get = tbl_get,
  encode_value = encode_value,
}

