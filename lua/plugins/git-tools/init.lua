local conf = require("plugins.git-tools.config")
local git = {}
git["lewis6991/gitsigns.nvim"] = {
  event = {"BufRead", "BufNewFile"},
  requires = {{"nvim-lua/plenary.nvim", opt = true}},
  config = conf.gitsigns
}

return git
