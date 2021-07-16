local conf = require("plugins.lang.config")
local lang = {}
lang["mhartington/formatter.nvim"] = {
  ft = {
    "typescript",
    "lua",
    "javascript",
    "json",
    "vue",
    "typescriptreact",
    "javascriptreact",
    "go",
    "dart",
    "c",
    "cpp",
    "rust"
  },
  config = conf.formatter
}
lang["dhruvasagar/vim-table-mode"] = {
  ft = {"markdown"}
}
lang["nvim-treesitter/nvim-treesitter"] = {
  run = ":TSUpdate",
  config = conf.treesitter
}

lang["dart-lang/dart-vim-plugin"] = {
  ft = {"dart"}
}

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
  ft = {"vue", "html", "xml"}
}

lang["davidgranstrom/nvim-markdown-preview"] = {
  ft = {"markdown"}
}
lang["lewis6991/spellsitter.nvim"] = {
  opt = true
}
vim.cmd [[command! Spellsitter :PackerLoad spellsitter.nvim<CR>]]

return lang
