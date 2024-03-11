return function(callback, ms)
  local timer = nil

  return function(...)
    local args = { ... }

    if timer ~= nil then
      return
    end

    timer = vim.uv.new_timer()

    timer:start(ms, 0, function()
      timer:stop()
      timer = nil
      vim.schedule(function()
        callback(unpack(args))
      end)
    end)
  end
end

