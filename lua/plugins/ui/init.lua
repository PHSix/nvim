local conf = require("plugins.ui.config")
local ui = {}

ui["glepnir/dashboard-nvim"] = {
  config = conf.dashboard
}
ui["~/Github/nvim-hybrid/"] = {
  config = conf.hybrid
}

ui["romgrk/barbar.nvim"] = {
  config = conf.barbar
}
ui["ojroques/nvim-hardline"] = {
  event = {"VimEnter *"},
  config = conf.hardline
}
ui["itchyny/vim-cursorword"] = {
  event = {"CursorMoved *"}
}
ui["Yggdroot/indentLine"] = {
    event = {"BufEnter *", "BufReadPre *"},
    config = conf.indentLine
}
ui["kyazdani42/nvim-web-devicons"] = {}

ui["p00f/nvim-ts-rainbow"] = {
    event = {"BufReadPost *"},
    config = conf.rainbow
}
return ui
