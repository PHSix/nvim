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
  ft = {"markdown"}
}
lang["nvim-treesitter/nvim-treesitter"] = {
  event = {"BufRead"},
  run = ":TSUpdate",
  config = conf.treesitter
}

lang["skywind3000/vim-rt-format"] = {
  event = {"InsertEnter"},
  config = conf.rt_format
}
lang["crispgm/nvim-go"] = {
  ft = {"go"},
  config = conf.nvim_go
}
lang["TravonteD/luajob"] = {
  opt = true
}
lang["alex-popov-tech/timer.nvim"] = {
  opt = true
}
lang["dart-lang/dart-vim-plugin"] = {
  ft = {"dart"}
}
lang["kevinhwang91/nvim-bqf"] = {
  event = {"InsertEnter"}
}

lang["kristijanhusak/vim-dadbod-ui"] = {
  -- cmd = {'DBUIToggle','DBUIAddConnection','DBUI','DBUIFindBuffer','DBUIRenameBuffer'},
  opt = true,
  config = conf.vim_dadbod_ui,
  requires = {{"tpope/vim-dadbod", opt = true}}
}

return lang
