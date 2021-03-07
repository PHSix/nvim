local conf = require("plugins.lang.config")
local lang = {}
lang["mhartington/formatter.nvim"] = {
  ft = {"typescript", "lua", "javascript", "json"},
  config = conf.formatter
}
lang["liuchengxu/vista.vim"] = {
  cmd = {"Vista"},
  config = conf.vista
}
lang["dhruvasagar/vim-table-mode"] = {
  ft={"markdown"}
}
lang["nvim-treesitter/nvim-treesitter"] = {
  event = {"BufRead *"},
  run = ":TSUpdate",
  config = conf.treesitter
}


lang["skywind3000/vim-rt-format"] = {
    event = {"InsertEnter *"},
    config = conf.rt_format
}
return lang

