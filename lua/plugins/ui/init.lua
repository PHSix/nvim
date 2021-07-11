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
  -- opt = true,
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
-- theme
ui["marko-cerovac/material.nvim"] = {
  opt = true,
  config = function()
    vim.g.material_style = "deep ocean"
    require("material").set()
  end
}
-- tabline, but it has a problem with dashboard
ui["akinsho/nvim-bufferline.lua"] = {
  opt = true,
  config = conf.nvim_bufferline()
}
-- theme
ui["folke/tokyonight.nvim"] = {
  opt = true,
  config = function()
    vim.g.tokyonight_style = "storm"
    vim.cmd [[colorscheme tokyonight]]
  end
}
-- theme
ui["glepnir/zephyr-nvim"] = {
  opt = true,
  config = function()
    require("zephyr")
  end
}
-- indent line plugin, but it can not work.
ui["lukas-reineke/indent-blankline.nvim"] = {
  branch = "master",
  config = conf.indentLine
}

-- highlight search
ui["kevinhwang91/nvim-hlslens"] = {
  event = {"CursorMoved"}
}

return ui
