local on_attach = require(_G.p("modules.lsp.attach"))
local lsp_installer = require("nvim-lsp-installer")
local ok, rust = lsp_installer.get_server("rust_analyzer")
local opts = nil
if ok then
	opts = rust:get_default_options()
	opts.on_attach = on_attach
end
local opts = {
	tools = {
		autoSetHints = false,
		hover_with_actions = true,
		runnables = {
			use_telescope = true,
		},
		inlay_hints = {
			show_parameter_hints = true,
			parameter_hints_prefix = "<- ",
			other_hints_prefix = "=> ",
			max_len_align = false,
			max_len_align_padding = 1,
			right_align = false,
			right_align_padding = 7,
		},
		hover_actions = {
			border = {
				{ "╭", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╮", "FloatBorder" },
				{ "│", "FloatBorder" },
				{ "╯", "FloatBorder" },
				{ "─", "FloatBorder" },
				{ "╰", "FloatBorder" },
				{ "│", "FloatBorder" },
			},
			auto_focus = false,
		},
	},
	server = opts,
}

require("rust-tools").setup(opts)
