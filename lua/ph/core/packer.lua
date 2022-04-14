local M = {}
function M.setup()
	local execute = vim.api.nvim_command
	local fn = vim.fn
	local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
	if fn.empty(fn.glob(install_path)) > 0 then
		vim.cmd("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
		execute("packadd packer.nvim")
	end
	local packer = require("packer")
	packer.init({
		clone_timeout = 30,
		transitive_opt = true,
		git = {
			cmd = "git",
		},
		profile = {
			enable = false,
			threshold = 1,
		},
	})
	packer.reset()

	require(_G.complete_path("plugins"))
end

return M
