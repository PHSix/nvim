--- @param path string
--- @return table
local r = function(path)
	return require("u." .. path)
end
_G.r = r

r("opts")
r("plugins")
