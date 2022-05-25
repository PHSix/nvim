local M = {}
local status = "1\n"
local function set_chinese()
	vim.fn.system("fcitx5-remote -o")
end

local function set_english()
	vim.fn.system("fcitx5-remote -c")
end

function M.leave_insert()
	status = vim.fn.system("fcitx5-remote")
	if status == "1\n" then
		return
	end
	set_english()
end

function M.enter_insert()
	if status == "1\n" then
		return
	end
	set_chinese()
end

function M.setup()
	if vim.fn.executable("fcitx5") then
		vim.cmd([[autocmd InsertLeave * lua require(_G.p("hack.fcitx5")).leave_insert()]])
		vim.cmd([[autocmd InsertEnter * lua require(_G.p("hack.fcitx5")).enter_insert()]])
	end
end

return M
