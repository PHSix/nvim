-- local async
local load_comple = function()
  require("main.opts")
  require("main.packer")
  require("main.event")
  require("mappings")
  require("utils.fcitx5")
  require("utils.capslock")
end

load_comple()
