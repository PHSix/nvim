local conf = require("plugins.ui.config")
local ui = {}

ui["glepnir/dashboard-nvim"] = {
  config = conf.dashboard
}
ui["PHSix/nvim-hybrid"] = {
  config = conf.hybrid
}
ui["glepnir/galaxyline.nvim"] = {
  branch = "main",
  config = conf.galaxyline,
  requires = {{"kyazdani42/nvim-web-devicons", opt = true}}
}

ui["romgrk/barbar.nvim"] = {
  config = conf.barbar,
  requires = {{"kyazdani42/nvim-web-devicons", opt=true}}
}
ui["itchyny/vim-cursorword"] = {
  event = {"CursorMoved"}
}

ui["p00f/nvim-ts-rainbow"] = {
  event = {"BufReadPre"},
  config = conf.rainbow
}
ui["junegunn/goyo.vim"] = {
  cmd = "Goyo",
  config = conf.goyo
}
ui["tveskag/nvim-blame-line"] = {
  cmd = {"EnableBlameLine"}
}
return ui
