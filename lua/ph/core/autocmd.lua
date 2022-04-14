local M = {}
function M._create(callback)
	table.insert(M, callback)
	return "lua require('" .. _G.p("core.autocmd") .. "')[" .. #M .. "]()"
end

-- @param group{{event: string, value:string, arg: string or function}}
function M.register(group_name, group)
	vim.cmd("augroup " .. group_name)
	vim.cmd("autocmd!")
	if group.event then
		if type(group.arg) == "string" then
			vim.cmd("autocmd " .. group.event .. " " .. group.value .. " " .. group.arg)
		elseif type(group.arg) == "function" then
			vim.cmd("autocmd " .. group.event .. " " .. group.value .. " " .. M._create(group.arg))
		end
	else
		for _, v in pairs(group) do
			if type(v.arg) == "string" then
				vim.cmd("autocmd " .. v.event .. " " .. v.value .. " " .. v.arg)
			elseif type(v.arg) == "function" then
				vim.cmd("autocmd " .. v.event .. " " .. v.value .. " " .. M._create(v.arg))
			end
		end
	end
	vim.cmd("augroup END")
end

function M.setup()
	M.register("help_keymap", {
		event = "FileType",
		value = "help",
		arg = function()
			vim.api.nvim_buf_set_keymap(0, "n", "q", ":bw<CR>", { silent = true })
		end,
	})
	M.register("markdown_snippets", {
		{ event = "FileType", value = "markdown", arg = 'inoremap <buffer> ,e <Esc>/<++><CR>:nohlsearch<CR>"_c4l' },
		{
			event = "FileType",
			value = "markdown",
			arg = "inoremap <buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA",
		},
		{ event = "FileType", value = "markdown", arg = "inoremap <buffer> ,i ![](<++>) <++><Esc>F[a" },
		{ event = "FileType", value = "markdown", arg = "inoremap <buffer> ,l [](<++>) <++><Esc>F[a" },
		{ event = "FileType", value = "markdown", arg = "inoremap <buffer> ,s `` <++><Esc>F`i" },
		{ event = "FileType", value = "markdown", arg = "inoremap <buffer> ,d * [] <++><Esc>F[a" },
	})
	M.register("cursorline_disable", {
		{ event = "WinLeave", value = "*", arg = "setlocal nocursorline" },
		{ event = "WinEnter", value = "*", arg = "setlocal cursorline" },
	})
	M.register("qf_map", {
		{
			event = "FileType",
			value = "qf",
			arg = function()
				vim.defer_fn(function()
					vim.api.nvim_buf_set_keymap(0, "n", "q", ":q<CR>", { silent = true })
				end, 1)
			end,
		},
	})
end

return M
