-- local async
local load_comple = function()
  -- vim.cmd [[set guifont=FiraCode\ Nerd\ Font:h20]]
  require("main.opts")
  require("main.packer")
  require("main.event")
  require("mappings")
  require("utils.fcitx5")
end

load_comple()
