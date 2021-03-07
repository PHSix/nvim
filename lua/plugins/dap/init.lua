local conf = require("plugins.dap.config")
local dap = {}

dap["skywind3000/asynctasks.vim"] = {
   requires = {"skywind3000/asyncrun.vim", opt= true},
   opt = true
}

dap["mfussenegger/nvim-dap"] = {
  opt=true,
  config = conf.dap
}

return dap
