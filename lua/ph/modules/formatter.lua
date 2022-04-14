local node_module = require(_G.p("hack.node-module"))

local t = {
	logging = false,
	filetype = {
		go = {
			function()
				return {
					exe = "gofmt",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		json = {
			function()
				return {
					exe = "jsonlint",
					args = { "--indent", 2 },
					stdin = true,
				}
			end,
		},
		dart = {
			function()
				return {
					exe = "dartfmt",
					args = { vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		c = {
			function()
				return {
					exe = "clang-format",
					args = { '-style="{IndentWidth: 4,TabWidth: 4}"', vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
		cpp = {
			function()
				return {
					exe = "clang-format",
					args = { '-style="{IndentWidth: 4,TabWidth: 4}"', vim.api.nvim_buf_get_name(0) },
					stdin = true,
				}
			end,
		},
	},
}
if node_module.is_existed("luafmt") == true then
	local exe = node_module.get_server("luafmt")
	t.filetype = vim.tbl_extend("force", t.filetype, {
		lua = {
			function()
				return {
					exe = exe,
					args = { "--indent-count", 2, "--stdin" },
					stdin = true,
				}
			end,
		},
	})
end

if node_module.is_existed("prettier") == true then
	local exe = node_module.get_server("prettier")
	t.filetype = vim.tbl_extend("force", t.filetype, {
		vue = {
			function()
				return {
					exe = exe,
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
					stdin = true,
				}
			end,
		},
		javascript = {
			function()
				return {
					exe = exe,
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
					stdin = true,
				}
			end,
		},
		typescriptreact = {
			function()
				return {
					exe = exe,
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
					stdin = true,
				}
			end,
		},
		typescript = {
			function()
				return {
					exe = exe,
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
					stdin = true,
				}
			end,
		},
		markdown = {
			function()
				return {
					exe = exe,
					args = { "--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote" },
					stdin = true,
				}
			end,
		},
	})
end

require("formatter").setup(t)

local function format()
	local filetype = vim.bo.filetype
	if t.filetype[filetype] ~= nil then
		vim.cmd([[Format]])
	else
		if #vim.lsp.buf_get_clients() > 0 then
			vim.lsp.buf.formatting_sync()
		else
		end
	end
end

vim.api.nvim_set_keymap(
	"n",
	"F",
	":lua require(_G.p('modules.formatter')).format()<CR>",
	{ noremap = true, silent = true }
)

return {
	format = format,
	t = t,
}
