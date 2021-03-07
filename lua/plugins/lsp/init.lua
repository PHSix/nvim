local config = require("plugins.lsp.config")
local lsp = {}
lsp["neovim/nvim-lspconfig"] = {
	config = function ()
require("plugins.lsp.lspc")
	end
}

lsp["hrsh7th/nvim-compe"] = {
  event = {"InsertEnter *"},
  requires = {
    {"hrsh7th/vim-vsnip-integ", opt = true},
    {"hrsh7th/vim-vsnip", event = {"BufReadPre *"}},
    {"PHSix/compe-tabnine", run = "./install.sh", opt=true},
    {"onsails/lspkind-nvim", opt = true}
  },
  config = config.compe
}

lsp["glepnir/lspsaga.nvim"] = {
  cmd = "Lspsaga"
}

lsp["akinsho/flutter-tools.nvim"] = {
  ft = {"dart"},
  config = config.flutter
}

return lsp
