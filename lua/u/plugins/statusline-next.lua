-- next statusline plugins preset

local utils = r('utils')

-- @params level {string}
local count_status = function(level)
	local info = vim.b.coc_diagnostic_info or {}
	return info[level] or 0
end

local get_coc_status = function()
	local info = {
		errors = count_status('error'),
		warnings = count_status('warning'),
		information = count_status('information'),
		hint = count_status('hint'),
	}
	local t = {}

	if not info.errors == 0 then
		table.insert(t, string.format("×%d", info.errors))
	end
	if not info.warnings == 0 then
		table.insert(t, string.format("•%d", info.warnings))
	end
	if not info.information == 0 then
		table.insert(t, string.format("~%d", info.information))
	end
	if not info.hint == 0 then
		table.insert(t, string.format(">%d", info.hint))
	end
	if #t == 0 then
		table.insert(t, '✓')
	end

	local ret = ''

	for _, str in ipairs(t) do
		ret = string.format('%s%s', ret, str)
	end

	return string.format('%s%s', vim.g.coc_status or '',ret);
end

utils.create_augroup('statusline#coc', {
	{ { "User" }, {
		pattern = { "CocStatusChange", "CocDiagnosticChange" },
		callback = function()
			-- TODO: update callback
		end
	} }
})
