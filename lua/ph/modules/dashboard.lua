vim.cmd([[augroup dashboard_autocmd]])
vim.cmd([[autocmd FileType alpha lua vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<CR>', {noremap=true, silent=true})]])
vim.cmd([[augroup END]])

local default_header = {
	type = "text",
	val = {
		"",
		"",
		"",
		"",
		"",
		"",
		"          ▀████▀▄▄              ▄█ ",
		"            █▀    ▀▀▄▄▄▄▄    ▄▄▀▀█ ",
		"    ▄        █          ▀▀▀▀▄  ▄▀  ",
		"   ▄▀ ▀▄      ▀▄              ▀▄▀  ",
		"  ▄▀    █     █▀   ▄█▀▄      ▄█    ",
		"  ▀▄     ▀▄  █     ▀██▀     ██▄█   ",
		"   ▀▄    ▄▀ █   ▄██▄   ▄  ▄  ▀▀ █  ",
		"    █  ▄▀  █    ▀██▀    ▀▀ ▀▀  ▄▀  ",
		"   █   █  █      ▄▄           ▄▀   ",
	},
	opts = {
		position = "center",
		hl = "DashboardHeader",
		-- wrap = "overflow";
	},
}

-- local set_space_before_line = function(header)
--   local append_lines = math.floor((vim.o.lines - 20 - 3) / 2)
--   for i = append_lines, 1, -1 do
--     table.insert(header, 0, "")
--   end
--   print(vim.inspect(header))
--   return header
-- end
-- default_header.val = set_space_before_line(default_header.val)

local footer = {
	type = "text",
	val = "Happy with use neovim everytime.",
	opts = {
		position = "center",
		hl = "Number",
	},
}

--- @param sc string
--- @param txt string
--- @param keybind string optional
--- @param keybind_opts table optional
local function button(sc, txt, keybind, keybind_opts)
	local opts = {
		position = "center",
		shortcut = sc,
		cursor = 5,
		width = 50,
		align_shortcut = "right",
		hl_shortcut = "Keyword",
		hl = "DashboardMenu",
	}

	local function on_press()
		vim.cmd(keybind)
		-- local key = vim.api.nvim_replace_termcodes(sc_ .. "<Ignore>", true, false, true)
		-- vim.api.nvim_feedkeys(key, "normal", false)
	end

	return {
		type = "button",
		val = txt,
		on_press = on_press,
		opts = opts,
	}
end

local buttons = {
	type = "group",
	val = {
		button("<C-f> u", "  Recently Files", "Telescope oldfiles"),
		button("<C-f> f", "  Find File", "Telescope find_files"),
		button("<C-f> v", "  VimWiKi", "Telescope vimwiki"),
		button("<C-f> f", "  Live Grep", "Telescope live_grep"),
		button("<C-f> f", "  New File", "enew"),
		button("<M-x>", "  Commands", "Telescope commands"),
	},
	opts = {
		spacing = 1,
	},
}

local section = {
	header = default_header,
	buttons = buttons,
	footer = footer,
}

local opts = {
	layout = {
		{ type = "padding", val = 2 },
		section.header,
		{ type = "padding", val = 2 },
		section.buttons,
		section.footer,
	},
	opts = {
		margin = 5,
	},
}

return {
	button = button,
	section = section,
	opts = opts,
}
