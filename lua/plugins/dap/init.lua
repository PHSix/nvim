local conf = require("plugins.dap.config")
local new = require("main.global").new
local dap = {}

dap["skywind3000/asynctasks.vim"] = {
   requires = {new {"skywind3000/asyncrun.vim", opt= true}},
   opt = true
}

dap["mfussenegger/nvim-dap"] = {
  opt=true,
  config = conf.dap
}

return dap
