local conf = require("plugins.ui.config")
local new = require("main.global").new
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
  requires = {new {"kyazdani42/nvim-web-devicons", opt = true}}
}

ui["romgrk/barbar.nvim"] = {
  config = conf.barbar,
  requires = {new {"kyazdani42/nvim-web-devicons", opt=true}}
}
-- ui["ojroques/nvim-hardline"] = {
--   event = {"VimEnter"},
--   config = conf.hardline
-- }
ui["itchyny/vim-cursorword"] = {
  event = {"CursorMoved"}
}
-- ui["Yggdroot/indentLine"] = {
--   event = {"BufEnter", "BufReadPre"},
--   config = conf.indentLine
-- }
-- ui["glepnir/indent-guides.nvim"] = {
--   event = {"BufReadPre"},
--   config = conf.indent_guides
-- }
-- ui["lukas-reineke/indent-blankline.nvim"] = {
--   branch = "lua",
--   event = {"BufReadPre", "BufNewFile"},
--   config = conf.blankline
-- }
-- ui["akinsho/nvim-bufferline.lua"] = {
--   config = conf.nvim_bufferline,
--   -- requires = {{"kyazdani42/nvim-web-devicons", opt = true}}
-- }

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
-- ui["beauwilliams/focus.nvim"] = {
--   -- event = "WinLeave",
--   config = conf.focus
-- }
return ui
