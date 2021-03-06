local fn = vim.fn
local t = {}
local pack = {}
-- vim.g.github_mirror = "https://github.com.cnpmjs.org/"
local http_prefix = vim.g.github_mirror or "https://hub.fastgit.org/"
if fn.getenv("https_proxy") ~= vim.NIL then
  http_prefix = ""
end
function pack:new(req)
  local repo = http_prefix .. req[1]
  self.__index = self
  setmetatable(req, self)
  req[1] = repo
  return req
end

function t.new(req)
  local r = pack:new(req)
  return r
end

return t
