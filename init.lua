vim.g.os = "ph"

--[[
-- check health if first time for enter neovim.
--]]
function check_health()
	local ok, sta = pcall(require, "_health")
	-- print(ok, sta)
	if ok then
		return
	end
	local fs = require("ludash.fs")
	local exectable = vim.fn.executable
	local _cmds = {
		"stylua",
		"node",
		"go",
		"npm",
		"prettier",
		"cargo",
		"dart",
		"ghcup",
		"fzf",
		"ripgrep",
		"lazygit",
	}
	local _h = {}
	for _, cmd in ipairs(_cmds) do
		if exectable(cmd) == 1 then
			_h[cmd] = true
		else
			_h[cmd] = false
		end
	end
	vim.notify("[health]: '_health.lua' is not exists.", vim.log.levels.TRACE)

	local content = "return {%s\n}"
	local kvstr = ""
	local torf = function(_s)
		if _s then
			return "true"
		else
			return "false"
		end
	end
	for cmd, status in pairs(_h) do
		kvstr = kvstr .. string.format('\n\t["%s"] = %s,', cmd, torf(status))
	end
	content = string.format(content, kvstr)
	fs.writeFileSync(vim.fn.stdpath("config") .. "/lua/_health.lua", content)
	vim.notify("[health]: '_health.lua' has created.", vim.log.levels.TRACE)
end

check_health()

function _G.p(path)
	return vim.g.os .. "." .. path
end
function _G.complete_path(path)
	return vim.g.os .. "." .. path
end

require(vim.g.os .. ".core")
