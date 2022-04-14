-- copy from luvit docs
-- url: https://github.com/luvit/luv/blob/master/docs.md#uv_timer_t--timer-handle

local uv = vim.loop
-- Creating a simple setTimeout wrapper
local function setTimeout(callback, timeout)
  local timer = uv.new_timer()
  timer:start(timeout, 0, function ()
    timer:stop()
    timer:close()
    callback()
  end)
  return timer
end

-- Creating a simple setInterval wrapper
local function setInterval(callback, interval)
  local timer = uv.new_timer()
  timer:start(interval, interval, function ()
    callback()
  end)
  return timer
end

-- And clearInterval
local function clearInterval(timer)
  timer:stop()
  timer:close()
end

return {
  setTimeout = setTimeout,
  setInterval = setInterval,
  clearInterval = clearInterval,
}
