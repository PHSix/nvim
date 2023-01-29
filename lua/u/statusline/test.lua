--[[
--local component = {
--	render = function() 
--		returrn ''
--	end
--	ev = {},
--}
--
--]]

local left = {
	{
		render = function()
			return vim.fn.expand("%:p")
		end,
		ev = {
			"BufEnter *"
		},
		highlight = {
			fg = "#22C55E",
		}
	},
	{
		render = function ()
			return vim.fn.mode()
		end,
		ev = {
			"ModeChanged *"
		},
		highlight = "ErrorMsg"
	}
}

local core = require('u.statusline.core')

core.setup({
	left = left,
	right = {}
})
