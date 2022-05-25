local M = {}
local health = require("_health")

function M.setup()
	if health["fcitx5-remote"] then
		require(_G.p("hack.fcitx5")).setup()
	end
	require(_G.p("hack.capslock")).setup()
	require(_G.p("hack.autosave")).setup()
end

return M
