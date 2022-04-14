local ludash = require("ludash")
ludash.fs.watchFile("~/.config/nvim/test/watchfile-test.lua", {
	on_error = function ()
	end,
	on_change = function ()
		print("watch test file change")
	end,
	["repeat"] = true
})


