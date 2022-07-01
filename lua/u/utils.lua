local M = {}
local fn = vim.fn
M.plugins_path = fn.stdpath("data") .. "/site/pack/packer"
function M.is_plugin_installed(plugins_name)
  if
    fn.empty(fn.glob(M.plugins_path .. "/start/" .. plugins_name)) > 0
    and fn.empty(fn.glob(M.plugins_path .. "/opt/" .. plugins_name)) > 0
  then
    return false
  else
    return true
  end
end

function M.push_async_task(fn, obj)
	obj = obj or {}
	local isRecord = obj.isRecord or false
	local start
	local async_task
	async_task = vim.loop.new_async(vim.schedule_wrap(function()
		if isRecord then
			start = vim.loop.hrtime()
		end
		fn()
		if isRecord then
			print("cost: " .. (vim.loop.hrtime() - start) / 1000000)
		end
		async_task:close()
	end))
	async_task:send()
end
return M
