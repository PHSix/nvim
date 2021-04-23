local conf = require("plugins.lsp.config")
local lsp = {}
lsp["neovim/nvim-lspconfig"] = {
  config = function()
    require("plugins.lsp.lspc")
  end
}

lsp["hrsh7th/nvim-compe"] = {
  event = {"InsertEnter"},
  requires = {
    {"onsails/lspkind-nvim", opt = true},
    {"tamago324/compe-zsh", ft = {"zsh"}}
  },
  config = conf.compe
}
lsp["hrsh7th/vim-vsnip"] = {
  event = "InsertCharPre",
  config = conf.vsnip
}

lsp["glepnir/lspsaga.nvim"] = {
  cmd = "Lspsaga",
  config = conf.lspsaga
}

lsp["akinsho/flutter-tools.nvim"] = {
  ft = {"dart"},
  config = conf.flutter
}
lsp["gfanto/fzf-lsp.nvim"] = {
  opt = true
}
-- Lua
lsp["folke/lsp-trouble.nvim"]={
  requires = {{"kyazdani42/nvim-web-devicons", opt=true}},
  cmd = "LspTroubleToggle",
  config = conf.lsp_trouble,
}
return lsp
