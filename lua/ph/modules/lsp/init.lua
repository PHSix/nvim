require(_G.p("modules.lsp.handlers")).setup()
local util = require("lspconfig.util")
local attach = require(_G.p("modules.lsp.attach"))
local capabilities = require(_G.p("modules.lsp.capabilities"))
local lsp_installter = require("nvim-lsp-installer")
local M = {
	attach = attach,
	capabilities = capabilities,
}
local function get_typescript_server_path(root_dir)
	local project_root = util.find_node_modules_ancestor(root_dir)

	local local_tsserverlib = project_root ~= nil
		and util.path.join(project_root, "node_modules", "typescript", "lib", "tsserverlibrary.js")
	local global_tsserverlib = vim.fn.stdpath("data") .. "lsp_servers/tsserver/typescript/lib/tsserverlibrary.js"

	if local_tsserverlib and util.path.exists(local_tsserverlib) then
		return local_tsserverlib
	else
		return global_tsserverlib
	end
end

local function initialize_server(server_name, opts)
	opts = opts or {}
	opts["on_attach"] = attach
	local ok, server = lsp_installter.get_server(server_name)
	if ok then
		if server:is_installed() then
			server:setup_lsp(opts)
		else
			server:install()
		end
	end
end
M.initialize_server = initialize_server
M.setup = function()
	initialize_server("sumneko_lua", {
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
	initialize_server("gopls", {
		init_options = {
			usePlaceholders = true,
			completeUnimported = true,
		},
	})
	-- initialize_server("tsserver")
	require'lspconfig'.tsserver.setup{
		cmd = { "/home/ph/.local/share/nvim/lsp_servers/tsserver/node_modules/.bin/typescript-language-server", "--tsserver-log-file=/home/ph/log/ts-logs.txt", "--stdio" }
	}
	initialize_server("clangd")
	initialize_server("rust_analyzer", {
		checkOnSave = {
			enable = false,
		},
	})
	initialize_server("pyright", {
		settings = {
			python = {
				disableLanguageServices = false,
				disableOrganizeImports = false,
				analysis = {
					autoImportCompletions = true,
					autoSearchPaths = true,
					diagnosticMode = "openFilesOnly",
					stubPath = "typings",
					typeshedPaths = {},
					diagnosticSeverityOverrides = vim.empty_dict(),
					typeCheckingMode = "basic",
					useLibraryCodeForTypes = true,
					pythonPath = "python3",
				},
			},
		},
	})
	initialize_server("vimls")
	initialize_server("bashls")
	initialize_server("jsonls", {
		settings = {
			json = {
				schemas = require("schemastore").json.schemas({
					select = {
						".eslintrc",
						"package.json",
					},
				}),
			},
		},
	})
	initialize_server("cssls")
	initialize_server("volar", {
		config = {
			on_new_config = function(new_config, new_root_dir)
				new_config.init_options.typescript.serverPath = get_typescript_server_path(new_root_dir)
			end,
		},
	})
	initialize_server("cmake")
	initialize_server("rnix")
	initialize_server("tailwindcss")
	initialize_server("html")
	initialize_server("zls")
	initialize_server("svelte")
	initialize_server("asm_lsp")
	initialize_server("arduino_language_server")
	initialize_server("svelte")
	initialize_server("dartls")
end

return M
