local M = {}
local api = vim.api
local timer = nil

function M.enable_autosave()
	vim.cmd([[augroup autosave]])
	vim.cmd([[autocmd InsertLeave * lua require(_G.p('hack.autosave')).autosave()]])
	vim.cmd([[autocmd InsertEnter * lua require(_G.p('hack.autosave')).clear_autosave()]])
	vim.cmd([[augroup END]])
	vim.cmd([[command! AutoSaveDisable lua require(_G.p('hack.autosave')).disable_autosave()]])
end

function M.disable_autosave()
	vim.cmd([[augroup autosave]])
	vim.cmd([[autocmd!]])
	vim.cmd([[augroup END]])
	vim.cmd([[delcommand AutoSaveDisable]])
end

function M.autosave()
	local cur_buf = api.nvim_get_current_buf()
	if api.nvim_buf_get_option(cur_buf, "modifiable") == false then
		return
	end
	timer = vim.defer_fn(function()
		vim.cmd([[w]])
		timer = nil
	end, 1000)
end

function M.clear_autosave()
	if timer ~= nil then
		timer:stop()
		timer:close()
		timer = nil
	end
end

function M.setup()
	vim.cmd([[command! AutoSaveEnable lua require(_G.p('hack.autosave')).enable_autosave()]])
end

return M
