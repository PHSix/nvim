local map = vim.api.nvim_set_keymap
local function t(str)
	return vim.api.nvim_replace_termcodes(str, true, true, true)
end
local check_back_space = function()
	local col = vim.fn.col(".") - 1
	if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
		return true
	else
		return false
	end
end

function _G.smart_tab()
	if vim.fn.pumvisible() == 1 then
		return t'<C-n>'
	elseif check_back_space() then
		return t'<Tab>'
	else
		return vim.fn["coc#refresh"]()
	end

end

function _G.smart_enter()
	if vim.fn.pumvisible() == 1 then
		return vim.fn["coc#_select_confirm"]()
	else
		return t'<CR>'
	end
end

