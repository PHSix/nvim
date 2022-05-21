local uv = vim.loop

-- [[
-- TODO: flag feature
-- @params file_path {string}
-- @params content {string}
-- @params flag {table}
-- @return {integer} write file status
-- ]]
local writeFileSync = function(file_path, content, flag)
	local fd = assert(uv.fs_open(file_path, "w+", 438))
	local status = assert(uv.fs_write(fd, content))
	assert(uv.fs_close(fd))
	return status
end

return {
	writeFileSync = writeFileSync,
}
