local conf = require("plugins.operator-tools.config")
local tools = {}
tools["~/Github/faster.nvim"] = {
  opt = true
}
tools["lilydjwg/fcitx.vim"] = {
  event = {"InsertEnter *"}
}
tools["tpope/vim-surround"] = {
  keys = {"c", "d", "y"}
}
tools["gcmt/wildfire.vim"] = {
  keys = {"n", "<CR>"}
}
tools["junegunn/vim-easy-align"] = {
  keys = {{"v", "ga"}, {"n", "ga"}}
}
tools["nvim-telescope/telescope.nvim"] = {
  cmd = {"Telescope"},
  requires = {
    {"nvim-lua/popup.nvim"},
    {"nvim-lua/plenary.nvim", opt = true}
  },
  config = conf.telescope
}
tools["kyazdani42/nvim-tree.lua"] = {
  cmd = {"NvimTreeToggle"},
  config = conf.nvim_tree
}
tools["tkmpypy/chowcho.nvim"] = {
  opt = true
}

tools["windwp/nvim-autopairs"] = {
  event = {"BufEnter *"},
  config = conf.autopairs
}
tools["tyru/caw.vim"] = {
  opt = true
}
tools["npxbr/glow.nvim"] = {
  cmd = {"Glow"}
}
tools["numtostr/FTerm.nvim"] = {
  cmd = {"FTermOpen"},
  config = conf.fterm
}

tools["norcalli/nvim-colorizer.lua"] = {
  ft = {"lua", "vim", "css", "html", "javascript", "typescript"},
  config = conf.colorizer
}

tools["glacambre/firenvim"] = {
  opt = true
}

tools["voldikss/vim-translator"] = {
  cmd = "TranslateW"
}
tools["mg979/vim-visual-multi"] = {
  keys = {"<C-d>"},
  config = conf.multi_cursor
}
return tools
