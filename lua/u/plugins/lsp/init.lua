local installer = require("nvim-lsp-installer")
local lspconfig = require("lspconfig")
local capabilities = r("plugins.lsp.capabilities")
r("plugins.lsp.null-ls")
local st = function(server_name, opts)
	local ok, server = installer.get_server(server_name)
	opts = opts or {}
	if not ok then
		return
	end
	if not server:is_installed() then
		server:install()
		server:on_ready(function()
			lspconfig[server_name].setup(vim.tbl_extend("force", server:get_default_options(), opts))
		end)
		return
	end
	lspconfig[server_name].setup(vim.tbl_extend("force", server:get_default_options(), opts))
end

st("sumneko_lua", {
	settings = {
		Lua = {
			diagnostics = {
				enable = true,
				globals = { "vim", "packer_plugins", "awesome" },
			},
			runtime = { version = "LuaJIT" },
			workspace = {
				library = {
					["/usr/share/awesome/lib"] = true,
					[vim.fn.expand("$VIMRUNTIME/lua")] = true,
				},
			},
		},
	},
})

st("gopls", {
	init_options = {
		usePlaceholders = true,
		completeUnimported = true,
	},
})

st("html", {
	capabilities = capabilities,
})

st("cssls", {
	capabilities = capabilities,
})

st("vimls")

st("rust_analyzer", {
	checkOnSave = {
		enable = false,
	},
})
st("angularls")

st("clangd")

local ok, tsserver = installer.get_server("tsserver")
if not ok then
	return
end
if not tsserver:is_installed() then
	tsserver:install()
	return
end
local t = {
	disable_commands = false,
	debug = false,
	server = vim.tbl_deep_extend("force", tsserver:get_default_options(), {
		on_attach = attach,
	}),
}
require("typescript").setup(t)
vim.cmd([[
	sign define DiagnosticSignError text=  texthl=DiagnosticSignError linehl= numhl=
	sign define DiagnosticSignWarn  text= texthl=DiagnosticSignWarn linehl= numhl=
	sign define DiagnosticSignInfo  text= texthl=DiagnosticSignInfo linehl= numhl=
	sign define DiagnosticSignHint  text=ﴞ texthl=DiagnosticSignHint linehl= numhl=
]])