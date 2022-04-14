local M = {}

function M.setup()
	require(_G.p("hack.fcitx5")).setup()
	require(_G.p("hack.capslock")).setup()
	require(_G.p("hack.autosave")).setup()
end

return M
