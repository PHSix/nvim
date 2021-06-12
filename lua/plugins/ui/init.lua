local conf = require("plugins.ui.config")
local ui = {}

ui["glepnir/dashboard-nvim"] = {
  config = conf.dashboard
}
-- ui["PHSix/nvim-hybrid"] = {
-- config = conf.hybrid
-- }
ui["hoob3rt/lualine.nvim"] = {
  config = conf.lualine,
  requires = {{"kyazdani42/nvim-web-devicons", opt = true}}
}

-- ui["romgrk/barbar.nvim"] = {
--   opt = true,
--   config = conf.barbar,
--   requires = {{"kyazdani42/nvim-web-devicons", opt=true}}
-- }
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
ui["folke/tokyonight.nvim"] = {
  config = function()
    vim.g.tokyonight_style = "night"
    vim.cmd [[colorscheme tokyonight]]
  end
}
ui["marko-cerovac/material.nvim"] = {
  opt = true,
  config = function()
    vim.g.material_style = "deep ocean"
    require("material").set()
  end
}
ui["akinsho/nvim-bufferline.lua"] = {
  config = conf.nvim_bufferline()
}

return ui
