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
tools["nvim-telescope/telescope.nvim"] = {
  cmd = {"Telescope"},
  requires = {
    new {"nvim-lua/plenary.nvim", opt = true},
    new {"nvim-lua/popup.nvim", opt = true}
  },
  config = conf.telescope
}
tools["kyazdani42/nvim-tree.lua"] = {
  cmd = {"NvimTreeToggle"},
  config = conf.nvim_tree
}
tools["windwp/nvim-autopairs"] = {
  event = {"BufEnter"},
  config = conf.autopairs
}
tools["tyru/caw.vim"] = {
  opt = true
}
-- tools["tomtom/tcomment_vim"] = {
--
-- }
tools["npxbr/glow.nvim"] = {
  cmd = {"Glow"}
}

tools["norcalli/nvim-colorizer.lua"] = {
  ft = {"lua", "vim", "css", "html", "javascript", "typescript", "c", "cpp"},
  config = conf.colorizer
}

tools["voldikss/vim-translator"] = {
  cmd = "TranslateW"
}
tools["smolck/nvim-todoist.lua"] = {
  opt = true
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
tools["mbbill/undotree"] = {
  cmd = "UndotreeToggle"
}
tools["phaazon/hop.nvim"] = {
  cmd = "HopChar2"
}
return tools
