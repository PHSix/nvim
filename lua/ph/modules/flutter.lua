vim.cmd([[hi! CloseTag guifg=#64748B]])
require("flutter-tools").setup({
	ui = {
		border = "rounded",
	},
	-- flutter_path = "<full/path/if/needed>", -- <-- this takes priority over the lookup
	-- flutter_lookup_cmd = nil, -- example "dirname $(which flutter)" or "asdf where flutter"
	fvm = false, -- takes priority over path, uses <workspace>/.fvm/flutter_sdk if enabled
	widget_guides = {
		enabled = false,
	},
	closing_tags = {
		highlight = "CloseTag", -- highlight for the closing tag
		prefix = " ",
		enabled = true, -- set to false to disable
	},
	dev_log = {
		enabled = false,
		open_cmd = "tabedit",
	},
	dev_tools = {
		autostart = false, -- autostart devtools server if not detected
		auto_open_browser = false, -- Automatically opens devtools in the browser
	},
	outline = {
		open_cmd = "30vnew", -- command to use to open the outline buffer
		auto_open = false, -- if true this will open the outline automatically when it is first populated
	},
	lsp = {
		-- cmd= {"dart", "/home/ph/Document/flutter/bin/snapshots/analysis_server.dart.snapshot", "--lsp"},
		on_attach = require(_G.p("modules.lsp.attach")),
		capabilities = require(_G.p("modules.lsp.capabilities")),
		--- OR you can specify a function to deactivate or change or control how the config is created
		-- capabilities = function(config)
		--   config.specificThingIDontWant = false
		--   return config
		-- end,
		settings = {
			showTodos = true,
			completeFunctionCalls = true,
			-- analysisExcludedFolders = {<path-to-flutter-sdk-packages>}
		},
	},
})
