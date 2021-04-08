local conf = require("plugins.lsp.config")
local new = require("main.global").new
local lsp = {}
lsp["neovim/nvim-lspconfig"] = {
  config = function()
    require("plugins.lsp.lspc")
  end
}

lsp["hrsh7th/nvim-compe"] = {
  event = {"InsertEnter"},
  requires = {
    new {"onsails/lspkind-nvim", opt = true},
    new {"tamago324/compe-zsh", ft = {"zsh"}}
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
<<<<<<< HEAD
lsp["gfanto/fzf-lsp.nvim"] = {
  opt = true
}
=======
>>>>>>> b27cbe1622895a0383892bd33652ea8b5f34e031
-- lsp["RishabhRD/nvim-lsputils"] = {
--   requires = {{"RishabhRD/popfix", opt = true}},
--   config = conf.lsputils
-- }

return lsp
