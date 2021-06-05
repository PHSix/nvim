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
  config = conf.lspsaga
}

lsp["akinsho/flutter-tools.nvim"] = {
  ft = {"dart"},
  config = conf.flutter
}
lsp["gfanto/fzf-lsp.nvim"] = {
  opt = true
}
lsp["folke/trouble.nvim"] = {
  requires = {{"kyazdani42/nvim-web-devicons", opt = true}},
  cmd = "LspTroubleToggle",
  config = conf.lsp_trouble
}
lsp["ray-x/lsp_signature.nvim"] = {
  config = conf.lsp_signature,
  event = {"InsertEnter"},
}

lsp["nanotee/sqls.nvim"] = {}
return lsp
