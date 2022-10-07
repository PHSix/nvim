vim.defer_fn(function()
	local gl = require("galaxyline")
	local gls = gl.section
	local condition = require("galaxyline.condition")
	local vcs = require("galaxyline.provider_vcs")
	local fileinfo = require("galaxyline.provider_fileinfo")
	local buffer = require("galaxyline.provider_buffer")
	-- TODO: rewrite fileinfo provider(cost too many time)

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
	gls.left = {
		{
			Holder = {
				provider = function()
					return "▎ "
				end,
				highlight = { blue, bg },
			},
		},
		{
			FileIcon = {
				provider = "FileIcon",
				condition = condition.buffer_not_empty,
				highlight = { require("galaxyline.provider_fileinfo").get_file_icon_color, bg },
			},
		},
		{
			Split1 = {
				provider = function()
					return "   »  "
				end,
				condition = condition.buffer_not_empty,
				highlight = { cyan, bg },
			},
		},
		{
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
		},
		{
			FileModify = {
				provider = function()
					return "●"
				end,
				condition = function()
					if vim.bo.modified == true then
						return true
					end
					return false
				end,
				highlight = { blue, bg },
			},
		},
		{

			Split2 = {
				provider = function()
					return "  «  "
				end,
				condition = condition.buffer_not_empty,
				highlight = { cyan, bg },
			},
		},
		{
			DiagnosticError = {
				provider = "DiagnosticError",
				icon = "  ",
				highlight = { error, bg },
			},
		},
		{
			DiagnosticWarn = {
				provider = "DiagnosticWarn",
				icon = "  ",
				highlight = { warn, bg },
			},
		},
		{
			DiagnosticHint = {
				provider = "DiagnosticHint",
				icon = "  ",
				highlight = { hint, bg },
			},
		},
		{
			DiagnosticInfo = {
				provider = "DiagnosticInfo",
				icon = "  ",
				highlight = { info, bg },
			},
		},
	}

	gls.right = {
		{
			DiffAdd = {
				provider = "DiffAdd",
				condition = condition.hide_in_width,
				icon = "  ",
				highlight = { git_add, bg },
			},
		},
		{
			DiffModified = {
				provider = "DiffModified",
				condition = condition.hide_in_width,
				icon = " 柳",
				highlight = { git_change, bg },
			},
		},
		{
			DiffRemove = {
				provider = "DiffRemove",
				condition = condition.hide_in_width,
				icon = "  ",
				highlight = { git_delete, bg },
			},
		},
		{
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
		},
		{
			EndComponent = {
				provider = function()
					return "   "
				end,
				highlight = { warn, bg, "bold" },
			},
		},
	}
end, 10)
