local os = "linux"
local version = "0.13.1"
local url = string.format(
	"https://github.com/JohnnyMorganz/StyLua/releases/download/v%s/stylua-%s.zip",
	version,
	os
)

local utils = require("fi.utils")
local fs = require("ludash").fs
local path = require("fi.global").install_path .. "stylua"
local log = require("fi.utils.log")
local download = utils.download
local unzip = utils.unzip

local exec_path = path .. "/stylua"

local is_installed = function()
	fs.isExist(exec_path)
	return false
end

local install = function()
	if is_installed() == false then
		fs.rmBlock(path)
	else
		return
	end
	fs.mkdirSync(path)
	local download_job = download(path, "stylua.zip", url)
	local unzip_job = unzip(path .. "/stylua.zip", path)
	download_job:after(function ()
		if download_job.code == 0 then
			unzip_job:start()
		else
			log("stylua install failed!")
		end
	end)
	download_job:start()
	unzip_job:after(function ()
		if unzip_job.code == 0 then
			vim.schedule(function ()
				fs.chmod(exec_path, "+x")
			end)
		end
	end)
end

return {
	install = install,
	check_install = is_installed,
}
