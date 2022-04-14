local t = require("ludash.timer")
-- [[
-- throttle function
-- @params fn {function} throttle function
-- @params ms {intger} time in debounce
-- ]]
return function (fn, ms)
  local _flag = true
  return function ()
    if _flag then
      _flag = false
      t.setTimeout(function ()
        _flag = true
      end, ms)
      fn()
    end
  end
end
