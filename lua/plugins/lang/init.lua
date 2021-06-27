local conf = require("plugins.lang.config")
local lang = {}
lang["mhartington/formatter.nvim"] = {
  ft = {"typescript", "lua", "javascript", "json", "vue"},
  config = conf.formatter
}
lang["dhruvasagar/vim-table-mode"] = {
  ft = {"markdown"}
}
lang["nvim-treesitter/nvim-treesitter"] = {
  --  event = {"BufRead"},
  run = ":TSUpdate",
  config = conf.treesitter
}

lang["skywind3000/vim-rt-format"] = {
  event = {"InsertEnter"},
  config = conf.rt_format
}
lang["dart-lang/dart-vim-plugin"] = {
  ft = {"dart"}
  -- opt = true
}
-- lang["kevinhwang91/nvim-bqf"] = {
--   event = {"InsertEnter"}
-- }

lang["kristijanhusak/vim-dadbod-ui"] = {
  -- cmd = {'DBUIToggle','DBUIAddConnection','DBUI','DBUIFindBuffer','DBUIRenameBuffer'},
  opt = true,
  config = conf.vim_dadbod_ui,
  requires = {{"tpope/vim-dadbod", opt = true}}
}
lang["leafOfTree/vim-vue-plugin"] = {
  ft = {"vue"}
  -- opt = true
}
lang["othree/html5.vim"] = {
  ft = {"html"}
}
lang["ajorgensen/vim-markdown-toc"] = {
  ft = {"markdown"}
}
lang["dkarter/bullets.vim"] = {
  ft = {"markdown"}
}
lang["rafcamlet/nvim-luapad"] = {
  cmd = "Luapad",
  config = conf.luapad
}
lang["windwp/nvim-ts-autotag"] = {
  ft ={"vue", "html", "xml"}
}

lang["davidgranstrom/nvim-markdown-preview"] = {
  ft = {"markdown"}
}

lang["mattn/emmet-vim"] = {
  ft = {"html"}
}

return lang
