local conf = require("plugins.operator-tools.config")
local new = require("main.global").new
local tools = {}
tools["PHSix/faster.nvim"] = {
  opt = true
}
tools["lilydjwg/fcitx.vim"] = {
  event = {"InsertEnter"}
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
    new {"nvim-lua/plenary.nvim", opt=true},
    new {"nvim-lua/popup.nvim", opt=true},
  },
  config = conf.telescope
}
tools["kyazdani42/nvim-tree.lua"] = {
  -- commit = "58e44d29d7fbdb33241978138081f01e596e4b09",
  cmd = {"NvimTreeToggle"},
  config = conf.nvim_tree
}
tools["tkmpypy/chowcho.nvim"] = {
  opt = true
}

tools["windwp/nvim-autopairs"] = {
  event = {"BufEnter"},
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
  ft = {"lua", "vim", "css", "html", "javascript", "typescript", "c", "cpp"},
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
tools["smolck/nvim-todoist.lua"] = {
  opt = true
}
tools["ekickx/clipboard-image.nvim"] = {
  cmd = {"PasteImg"},
  config = conf.clipboard
}
tools["gennaro-tedesco/nvim-peekup"] = {
  event = {"BufReadPost", "InsertEnter"},
  config = conf.peekup
}
tools["monaqa/dial.nvim"] = {
  opt = true,
}
tools["glepnir/smartinput.nvim"] = {
  event = {"InsertEnter"},
  config = conf.smartinput

}
tools["hrsh7th/vim-eft"] = {
  opt = true
}
tools["easymotion/vim-easymotion"] = {
  opt = true
}
tools["Asheq/close-buffers.vim"] = {
}
return tools
