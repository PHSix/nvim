local lazy = require('lazy')
local package = require('core.pack').package
local conf = require('modules.coding.config')

package({
  'nvim-telescope/telescope.nvim',
  cmd = 'Telescope',
  config = conf.telescope,
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-fzy-native.nvim' },
  },
})

package({ 'echasnovski/mini.pairs', config = conf.pairs })

package({
  'stevearc/conform.nvim',
  config = conf.conform,
})

package({
  'echasnovski/mini.comment',
  event = { 'VeryLazy' },
  config = conf.comment,
  enabled = false,
})

package({
  'numToStr/Comment.nvim',
  config = conf.comment_nvim,
  lazy = true,
})

package({
  'sustech-data/wildfire.nvim',
  dependencies = { 'nvim-treesitter/nvim-treesitter' },
  lazy = true,
})

package({
  'tpope/vim-surround',
  keys = { 'd', 'c' },
})

package({
  'nvim-pack/nvim-spectre',
  cmd = { 'Spectre' },
  config = conf.spectre,
})
