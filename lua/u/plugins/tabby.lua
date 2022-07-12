require "tabby".setup()
-- require('tabby.util').get_tab_name(tabid, fallback)
local set_buf_options = function(buf_id)
	vim.api.nvim_buf_set_option(buf_id, 'buftype', 'nofile')
	vim.api.nvim_buf_set_option(buf_id, 'filetype', 'tabby')
end

local set_win_options = function(win_id)
	vim.api.nvim_win_set_option(win_id, 'rnu', false)
	vim.api.nvim_win_set_option(win_id, 'nu', false)
	vim.api.nvim_win_set_option(win_id, 'signcolumn', 'no')
end

local _buf_id = nil

local get_buf_id = function()
	if _buf_id then
		return _buf_id
	else
		_buf_id = vim.api.nvim_create_buf(false, false)
		set_buf_options(_buf_id)
		return _buf_id
	end
end

vim.api.nvim_create_user_command("TabbyNew", function()
end, {})

vim.api.nvim_create_user_command("TabbyRename", function()
	local cur_name = require('tabby.util').get_tab_name(vim.api.nvim_get_current_tabpage())
	local buf_id = get_buf_id()
	vim.api.nvim_buf_set_lines(buf_id, 1, 1, true, { cur_name })

	local editor = {
		width = vim.fn.winwidth(0),
		height = vim.fn.winheight(0)
	}

	local height = 1
	local width = 20

	local win_id = vim.api.nvim_open_win(buf_id, true,
		{ relative = 'win', width = width, height = height, border = 'rounded', row = math.floor((editor.height - height) / 2),
			col = math.floor((editor.width - width) / 2) })

	set_win_options(win_id)

	vim.keymap.set("n", "<ESC>", function()
		vim.api.nvim_win_close(win_id, true)
	end, { silent = true, buffer = buf_id })

	vim.keymap.set("i", "<CR>", function()
		vim.defer_fn(function()
			local buf_text = vim.api.nvim_get_lines(buf_id, 1, 1, false)
			print(buf_text)
			vim.api.nvim_win_close(win_id, true)
		end, 20)
		return "<ESC>"
	end, { buffer = buf_id, expr = true })

	vim.keymap.set('i', "<ESC>", function()
		vim.defer_fn(function()
			vim.api.nvim_win_close(win_id, true)
		end, 30)
		return "<ESC>"
	end, { buffer = buf_id, expr = true })
end, {})
