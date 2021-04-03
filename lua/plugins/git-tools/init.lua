local conf = require("plugins.git-tools.config")
local new = require("main.global").new
local git = {}
git["lewis6991/gitsigns.nvim"] = {
  event = {"BufRead", "BufNewFile"},
  requires = {new {"nvim-lua/plenary.nvim", opt = true}},
  config = conf.gitsigns
}

return git
