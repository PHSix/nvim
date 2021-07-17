local conf = require("plugins.lsp.config")
local lsp = {}

lsp["neovim/nvim-lspconfig"] = {
  config = function()
    require("plugins.lsp.lspconfig")
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
  opt = true
  -- config = conf.lspsaga
}

lsp["akinsho/flutter-tools.nvim"] = {
  ft = {"dart"},
  config = conf.flutter
}
lsp["folke/trouble.nvim"] = {
  requires = {{"kyazdani42/nvim-web-devicons", opt = true}},
  -- cmd = "LspTroubleToggle",
  event = {"InsertEnter"},
  config = conf.lsp_trouble
}
lsp["ray-x/lsp_signature.nvim"] = {
  config = conf.lsp_signature,
  event = {"InsertEnter"}
}
lsp["simrat39/symbols-outline.nvim"] = {
  cmd = "SymbolsOutline"
}

lsp["nanotee/sqls.nvim"] = {
  ft = {"sql"}
}

lsp["jose-elias-alvarez/nvim-lsp-ts-utils"] = {
  ft = {"typescript", "typescriptreact"}
}
lsp["RishabhRD/nvim-lsputils"] = {
  requires = {{"RishabhRD/popfix", opt = true}},
  event = {"BufEnter"},
  config = conf.lsputils
}
lsp["simrat39/rust-tools.nvim"] = {
  -- ft = {"rust"},
  config = conf.rust
}
return lsp
