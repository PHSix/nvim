local conf = require("plugins.git-tools.config")
local git = {}
git["lewis6991/gitsigns.nvim"] = {
  event = {"BufRead", "BufNewFile"},
  requires = {{"nvim-lua/plenary.nvim", opt = true}},
  config = conf.gitsigns
}
git["tveskag/nvim-blame-line"] = {
  cmd = {"EnableBlameLine"}
}
git["TimUntersberger/neogit"] = {
  cmd = {"Neogit"},
  requires = {{'nvim-lua/plenary.nvim', opt=true}}
}
git["sindrets/diffview.nvim"] = {
  cmd = {"DiffviewOpen"},
  config = conf.diffview
}
git["kdheepak/lazygit.nvim"] = {
  cmd = "LazyGit",
}

return git
