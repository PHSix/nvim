-- TODO: use libuv handle
local uv = vim.loop

local chmod = function(path, mode)
	-- vim.fn.chmod(path, mode)
	vim.fn.system({ "chmod", string.format("%s", mode), path })
end

local isExist = function(filePath)
	return uv.fs_access(filePath, 438)
end

local isFolder = function(filePath) end

local mkdirSync = function(path)
	-- mode is {own,group,other}
	-- return uv.fs_mkdir(path, 428)
	return vim.fn.mkdir(path)
end

local renameFile = function(path, newPath)
	return uv.fs_rename(path, newPath)
end

local rmBlock = function(path)
	vim.fn.system({ "rm", "-rf", path })
end

return {
	isExist = isExist,
	isFolder = isFolder,
	mkdirSync = mkdirSync,
	renameFile = renameFile,
	chmod = chmod,
	rmBlock = rmBlock,
}
