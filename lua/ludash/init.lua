local timer = require("ludash.timer")
local debounce = require("ludash.debounce")
local throttle = require("ludash.throttle")
local fs = require("ludash.fs")

return {
	setTimeout = timer.setTimeout,
	clearInterval = timer.clearInterval,
	setInterval = timer.setInterval,
	debounce = debounce,
	throttle = throttle,
	fs = fs,
}
