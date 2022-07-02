local Recorder = {}
local uv = vim.loop

function Recorder:new()
	local r = {}
	setmetatable(r, self)
	self.__index = self
	return r
end

function Recorder:start()
	assert(self._start == nil, "record have started!")
	self._start = uv.hrtime()
end

function Recorder:stop()
	assert(self._stop == nil, "record have stoped!")
	self._stop = uv.hrtime()
end

function Recorder:getms()
	assert(self._start, "record have not start")
	assert(self._stop, "record have not stop")
	return (self._stop - self._start) / 1000000
end

return Recorder
