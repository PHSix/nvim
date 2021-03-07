local conf = require("plugins.git-tools.config")
local git = {}
git["TimUntersberger/neogit"] = {
  opt = true
}
git["lewis6991/gitsigns.nvim"] = {
    event = {"BufReadPre *"},
  requires = {"nvim-lua/plenary.nvim", opt = true},
  config = conf.gitsigns
}
git["APZelos/blamer.nvim"] = {
opt=true
}

git["APZelos/blamer.nvim"] = {
  cmd = {"BlamerToggle"},
  config = conf.blamer
}

return git
