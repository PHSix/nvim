---@param callback function
---@param ms integer
return function(callback, ms)
  local timer = nil

  return function(...)
    local args = { ... }

    if timer ~= nil then
      timer:stop()
    end

    timer = vim.loop.new_timer()

    timer:start(ms, 0, function()
      timer:stop()
      timer = nil
      vim.schedule(function()
        callback(unpack(args))
      end)
    end)
  end
end
