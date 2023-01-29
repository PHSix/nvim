local utils = require('u.statusline.utils')
local cloneDeep = utils.cloneDeep
local concat_lists = utils.concat_lists

--- process component, return the source comp argument
--- @param comp table
local processComponent = function(comp, default_style)
	local highlight = comp.highlight
	local highlight_type = type(highlight)
	comp.highlight_group = string.format("SLGroup_%s_%s_%s",highlight.fg)
	if highlight_type == "nil" then
	elseif highlight_type =="string" then
	elseif highlight_type =="table" then
	end

	
	return comp
end

--- preprocess components
--- @param components_args table
local preprocess = function (components_args)
	local components = cloneDeep(components_args)
	local all_components = concat_lists(components.left, components.right)

	-- highlight
	local highlight_type = type(comp.highlight)
	comp.hi_group = string.format("SL%sGroup", list.from) .. idx
	if highlight_type == "nil" or highlight_type == "function" then
		vim.cmd(string.format("hi link %s StatusLine", comp.hi_group))
	elseif highlight_type == 'string' then
		vim.cmd(string.format("hi link %s %s", comp.hi_group, comp.highlight))
	elseif highlight_type == 'table' then
		-- hiTable(comp.hi_group, comp.highlight)
	end
	return comp
end

return preprocess
