local conf = require("plugins.operator-tools.config")
local tools = {}
tools["PHSix/faster.nvim"] = {
  opt = true
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
    {"nvim-lua/plenary.nvim", opt = true},
    {"nvim-lua/popup.nvim", opt = true},
    {"nvim-telescope/telescope-fzy-native.nvim", opt = true}
  },
  config = conf.telescope
}
tools["junegunn/fzf.vim"] = {
  config = conf.fzf
}
tools["kyazdani42/nvim-tree.lua"] = {
  -- cmd = {"NvimTreeToggle"},
  config = conf.nvim_tree
}
tools["windwp/nvim-autopairs"] = {
  event = {"BufEnter"},
  config = conf.autopairs
}
tools["tyru/caw.vim"] = {
  requires = {{"Shougo/context_filetype.vim", ft = {"html", "vue"}}},
  opt = true
}
tools["npxbr/glow.nvim"] = {
  cmd = {"Glow"}
}

tools["norcalli/nvim-colorizer.lua"] = {
  ft = {"lua", "vim", "css", "html", "javascript", "typescript", "c", "cpp", "vue"},
  config = conf.colorizer
}

tools["voldikss/vim-translator"] = {
  cmd = "TranslateW"
}
tools["glepnir/smartinput.nvim"] = {
  event = {"InsertEnter"},
  config = conf.smartinput
}
tools["hrsh7th/vim-eft"] = {
  opt = true
}
tools["mbbill/undotree"] = {
  cmd = "UndotreeToggle"
}
tools["phaazon/hop.nvim"] = {
  cmd = "HopChar2"
}
tools["ekickx/clipboard-image.nvim"] = {
  ft = {"markdown"},
  config = conf.clipboard
}
tools["lambdalisue/fern.vim"] = {
  cmd = "Fern"
}
tools["simrat39/symbols-outline.nvim"] = {
  cmd = "SymbolsOutline"
}
tools["NTBBloodbath/rest.nvim"] = {
  requires = {{"nvim-lua/plenary.nvim", opt = true}},
  config = conf.rest,
  opt = true
}
tools["nanotee/luv-vimdocs"] = {}
return tools
