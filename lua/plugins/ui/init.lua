local conf = require("plugins.ui.config")
local ui = {}

-- starup widget
ui["glepnir/dashboard-nvim"] = {
  config = conf.dashboard
}
-- my custom theme
ui["PHSix/nvim-hybrid"] = {
  config = conf.hybrid
}
-- modify statusline
ui["hoob3rt/lualine.nvim"] = {
  config = conf.lualine,
  requires = {{"kyazdani42/nvim-web-devicons", opt = true}}
}

-- useful tabline
ui["romgrk/barbar.nvim"] = {
  opt = true,
  config = conf.barbar,
  requires = {{"kyazdani42/nvim-web-devicons", opt = true}}
}
-- cursor word underline
ui["itchyny/vim-cursorword"] = {
  event = {"CursorMoved"}
}

-- rainbow surround pairs
ui["p00f/nvim-ts-rainbow"] = {
  event = {"BufReadPre"},
  config = conf.rainbow
}
-- tabline
ui["akinsho/nvim-bufferline.lua"] = {
  config = conf.nvim_bufferline()
}
-- indent line plugin
ui["lukas-reineke/indent-blankline.nvim"] = {
  branch = "master",
  config = conf.indentLine
}


return ui
