local log = require("fi.utils.log")
local Job = require("plenary.job")
-- download file api.
-- from {url} to {path}/{filename}.
-- @param path string
-- @param filename string
-- @param url string
-- @return plenary.job
local download = function(path, filename, url)
	if string.sub(path, string.len(path), string.len(path)) ~= "/" then
		path = path .. "/"
	end
	return Job:new({
		command = "wget",
		args = { url, "-O", path .. filename },
		cwd = vim.env.HOME,
		on_start = function()
			log(string.format("DownLoading %s ...", filename))
		end,
		-- debug mode
		-- on_exit = function(j, code)
		-- log("status code: " .. code)
		-- log(string.format("Download Sucessful.", filename))
		-- end,
		on_error = function()
			log(string.format("ERROR ON DOWNLOAD %s", filename))
		end,
	})
end

-- unzip flie form {from} to {to}
-- @param from string
-- @param to string
-- @param exdir
local unzip = function(from, to)
	local args = {
		"-d",
		to,
		from,
	}
	return Job:new({
		command = "unzip",
		args = args,
		cwd = vim.env.HOME,
		on_start = function()
			log(string.format("unziping file %s", from))
		end,
		-- debug mode
		-- on_exit = function(j, code, signal)
		-- log("status code: " .. code .. signal)
		-- log(string.format("%s unzip sucessful.", to))
		-- end,
		on_error = function()
			log(string.format("unzip failed!"))
		end,
	})
end

return {
	download = download,
	unzip = unzip,
}
