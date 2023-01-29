local Async = require('async')
local async = Async.sync
local await = Async.wait
local utils = require("u.statusline.utils")
local concat_lists = utils.concat_lists
local remove_duplicates = utils.remove_duplicates
local new_eventEmitter = utils.new_eventEmitter
local map = utils.map
local hiTable = utils.hiTable

local components = {
	left = {},
	right = {}
}

local state = {
	left = {},
	right = {}
}

local render = function()
	local left = ''
	local right = ''

	for _, v in ipairs(state.left) do
		left = left .. v
	end
	for _, v in ipairs(state.right) do
		right = right .. v
	end

	local width = vim.o.columns - string.len(left) - string.len(right)
	local frag = " "
	local space = ''
	if width > 0 then
		space = frag:rep(width)
	end
	local line = '%#StatusLine#' .. left .. space .. right

	vim.wo.statusline = line
	vim.notify(line, vim.log.levels.DEBUG)
end

local eventEmitter = new_eventEmitter({
	after_emit = render
})

--- preset highlight and prefix, suffix
--- @param comp table
--- @param idx number
--- @return table
local function component_preset(comp, idx, list)

	-- highlight
	local highlight_type = type(comp.highlight)
	comp.hi_group = string.format("SL%sGroup", list.from) .. idx
	if highlight_type == "nil" or highlight_type == "function" then
		vim.cmd(string.format("hi link %s StatusLine", comp.hi_group))
	elseif highlight_type == 'string' then
		vim.cmd(string.format("hi link %s %s", comp.hi_group, comp.highlight))
	elseif highlight_type == 'table' then
		hiTable(comp.hi_group, comp.highlight)
	end
	return comp
end

local function setup(_components)
	_components.left.from = "Left"
	_components.right.from = "Right"
	components = {
		left = map(component_preset, _components.left) or {},
		right = _components.right or {}
	}

	-- clear event emitter and initial state
	eventEmitter.clear()
	state = {
		left = vim.tbl_map(function()
			return ''
		end, components.left),
		right = vim.tbl_map(function()
			return ''
		end, components.right),
	}

	-- autocmd
	local all_events = vim.tbl_map(function(comp) return comp.ev end, concat_lists(components.left, components.right))
	local subscribe_events = remove_duplicates(vim.tbl_flatten(all_events))
	vim.cmd [[augroup statusline#emitter]]
	vim.cmd [[autocmd!]]
	for _, event in ipairs(subscribe_events) do
		vim.cmd(string.format("autocmd %s lua require('u.statusline.core').emit('%s')", event, event))
	end
	vim.cmd [[augroup END]]

	--- @param comp table
	--- @return string
	local component_render = function(comp)
		local value = await(comp.render())
		if type(comp.highlight) == 'function' then
			hiTable(comp.hi_group, comp.highlight())
		end
		return "%" .. string.format("#%s#%s", comp.hi_group, value)
	end

	-- subscribe callback function
	local left_comps = components.left
	local right_comps = components.right
	for idx, comp in ipairs(left_comps) do
		for _, ev in ipairs(comp.ev) do
			eventEmitter.subscribe(ev, function()
				state.left[idx] = component_render(comp)
			end)
		end
	end
	for idx, comp in ipairs(right_comps) do
		for _, ev in ipairs(comp.ev) do
			eventEmitter.subscribe(ev, function()
				state.right[idx] = await(comp.render())
			end)
		end
	end

	-- run get state and render at first time
	async(function()
		for idx, comp in ipairs(left_comps) do
			state.left[idx] = component_render(comp)
		end
		for idx, comp in ipairs(right_comps) do
			state.left[idx] = component_render(comp)
		end

		render()
	end)
end

return {
	setup = setup,
	emit = eventEmitter.emit
}
