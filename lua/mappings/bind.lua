local rhs = {}
local bind = {}
function rhs:new()
  local M = {
    cmd = '',
    opts = {
      noremap = false,
      nowait = false,
      expr = false,
      silent = false 
    }
  }
  setmetatable(M,self)
  self.__index = self
  return M
end

function rhs:map_cmd(command)
  self.cmd = ":" .. command .. "<CR>"
end

function rhs:map_key(key)
  self.cmd = key
end

function rhs:noremap()
  self.opts['noremap'] = true
  return self
end

function rhs:expr()
  self.opts['expr'] = true
  return self
end
function rhs:silent()
  self.opts['silent'] = true
  return self
end
function rhs:nowait()
  self.opts['nowait'] = true
  return self
end

function bind.map_cmd(command)
  local r = rhs:new()
  r:map_cmd(command)
  return r
end

function bind.map_key(key)
  local r = rhs:new()
  r:map_key(key)
  return r
end


return bind

