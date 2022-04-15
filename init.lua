vim.g.os = "ph"
function _G.p(path)
	return vim.g.os .. "." .. path
end
function _G.complete_path(path)
	return vim.g.os .. "." .. path
end

require(vim.g.os .. ".core")
