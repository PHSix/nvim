local folder_name = "u"

-- @params path {string}
local r = function (path)
	return require("u." .. path)
end
_G.r = r

r("opts")
r("plugins")



