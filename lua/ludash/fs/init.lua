local watch = require("ludash.fs.watch")
local status = require("ludash.fs.status")
local write = require("ludash.fs.write")

return {
	watchFile = watch.watchFile,
	isExist = status.isExist,
	isFolder = status.isFolder,
	mkdirSync = status.mkdirSync,
	renameFile = status.renameFile,
	rmBlock = status.rmBlock,
	chmod = status.chmod,
	writeFileSync = write.writeFileSync,
}
