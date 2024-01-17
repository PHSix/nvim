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

package({
  'tpope/vim-surround',
  keys = { 'd', 'c' },
})

package({
  'nvim-pack/nvim-spectre',
  cmd = { 'Spectre' },
  config = conf.spectre,
})

package({
  'simeji/winresizer',
  key = '<C-e>',
  config = conf.winresizer,
})
