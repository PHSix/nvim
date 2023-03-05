--- @param path string
--- @return table
local r = function(path)
	return require("u." .. path)
end
_G.r = r

r("opts")
r("plugins")

-- vim.cmd [[set rtp+=$HOME/projects/rl-nvim]]

-- require("rl.presets.simple")
-- vim.cmd [[
-- autocmd BufHidden * lua print(vim.wo.statusline)
-- ]]
