local gl = require("galaxyline")
local gls = gl.section
local condition = require("galaxyline.condition")
local diagnostic = require("galaxyline.provider_diagnostic")
local vcs = require("galaxyline.provider_vcs")
local fileinfo = require("galaxyline.provider_fileinfo")
local extension = require("galaxyline.provider_extensions")
local colors = require("galaxyline.colors")
local buffer = require("galaxyline.provider_buffer")
local whitespace = require("galaxyline.provider_whitespace")

local get_clients = function()
	local max_len = 15
	local msg = "No Active Lsp"
	local clients = vim.lsp.buf_get_clients()
	if #clients ~= 0 then
		msg = ""
		for _, client in pairs(clients) do
			msg = msg .. client.name .. ", "
		end
		msg = string.sub(msg, 1, string.len(msg) - 2)
	end
	if string.len(msg) > max_len then
		msg = string.sub(msg, 1, max_len)
		msg = msg .. "..."
	end
	return msg
end
local get_hl = function(group_name, attr)
	local group = vim.api.nvim_get_hl_by_name(group_name, true)
	local complete_attr
	if attr == "fg" then
		complete_attr = "foreground"
	elseif attr == "bg" then
		complete_attr = "background"
	else
		assert(false, "Attr value is negither bg or fg")
	end

	if group[complete_attr] then
		return string.format("#%x", group[complete_attr])
	end
	return "#000"
end

local buffer_not_empty = function()
	if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
		return true
	end
	return false
end

local fg = get_hl("StatusLine", "fg")
local bg = get_hl("StatusLine", "bg")
local error = "Red"
local warn = "Orange"
local info = "LightBlue"
local hint = "LightGray"
local cyan = "#22D3EE"
local blue = "#0087d7"
local git_branch = "#d7a65f"
local git_add = "#95c561"
local git_change = "#7199ee"
local git_delete = "#ee6d85"
gls.left[1] = {
	Holder = {
		provider = function()
			return "▎ "
		end,
		highlight = { blue, bg },
	},
}

gls.left[2] = {
	FileIcon = {
		provider = "FileIcon",
		condition = condition.buffer_not_empty,
		highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, bg },
	},
}

gls.left[3] = {
	Split1 = {
		provider = function()
			return "   »  "
		end,
		condition = condition.buffer_not_empty,
		highlight = { cyan, bg },
	},
}

gls.left[4] = {
	FileName = {
		provider = function()
			return fileinfo.get_current_file_name()
		end,
		condition = condition.buffer_not_empty,
		highlight = { fg, bg, "bold" },
	},
	FileType = {
		provider = function()
			local bft = buffer.get_buffer_filetype()
			bft = string.upper(bft)
			if string.len(bft) ~= 0 then
				return bft
			end
			return "NULL"
		end,
		condition = function()
			return not buffer_not_empty()
		end,
		highlight = { fg, bg, "bold" },
	},
	FileModify = {
		provider = function()
			return "●"
		end,
		condition = function()
			if vim.bo.modified == 1 then
				return true
			end
			return false
		end,
		highlight = { blue, bg },
	},
}

gls.left[5] = {

	Split2 = {
		provider = function()
			return "  «  "
		end,
		condition = condition.buffer_not_empty,
		highlight = { cyan, bg },
	},
}

gls.left[6] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = "  ",
		highlight = { error, bg },
	},
}
gls.left[7] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = "  ",
		highlight = { warn, bg },
	},
}

gls.left[8] = {
	DiagnosticHint = {
		provider = "DiagnosticHint",
		icon = "  ",
		highlight = { hint, bg },
	},
}

gls.left[9] = {
	DiagnosticInfo = {
		provider = "DiagnosticInfo",
		icon = "  ",
		highlight = { info, bg },
	},
}

gls.right[1] = {
	DiffAdd = {
		provider = "DiffAdd",
		condition = condition.hide_in_width,
		icon = "  ",
		highlight = { git_add, bg },
	},
}

gls.right[2] = {
	DiffModified = {
		provider = "DiffModified",
		condition = condition.hide_in_width,
		icon = " 柳",
		highlight = { git_change, bg },
	},
}

gls.right[3] = {
	DiffRemove = {
		provider = "DiffRemove",
		condition = condition.hide_in_width,
		icon = "  ",
		highlight = { git_delete, bg },
	},
}

gls.right[4] = {
	GitBranch = {
		provider = function()
			local msg = vcs.get_git_branch()
			if msg then
				return "   " .. msg .. " "
			else
				return ""
			end
		end,
		condition = condition.check_git_workspace,
		highlight = { git_branch, bg, "bold" },
	},
}

gls.right[5] = {
	LspClient = {
		provider = function()
			return "    " .. get_clients()
		end,
		highlight = { blue, bg },
	},
}

gls.right[6] = {
	EndComponent = {
		provider = function()
			return "   "
		end,
		highlight = { warn, bg, "bold" },
	},
}
