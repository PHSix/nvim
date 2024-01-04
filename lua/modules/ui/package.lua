local package = require('core.pack').package
local conf = require('modules.ui.config')

package({ 'glepnir/dashboard-nvim', config = conf.dashboard })

-- package({ 'tjdevries/colorbuddy.nvim', lazy = true })

package({
  'echasnovski/mini.indentscope',
  event = 'VeryLazy',
  config = conf.indentscope,
  enabled = false,
})

package({
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = conf.indent_blankline,
  event = 'VeryLazy',
  dependencies = { 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim', lazy = true },
})

package({
  'nvim-lualine/lualine.nvim',
  event = 'BufRead',
  config = conf.lualine,
  enabled = false,
})

package({
  'sontungexpt/sttusline',
  opts = {},
  enabled = false,
})

package({
  'windwp/windline.nvim',
  config = conf.windline,
  event = 'BufRead',
})

package({
  'stevearc/dressing.nvim',
  opts = {},
})

package({
  'dstein64/nvim-scrollview',
  config = true,
})

package({
  'NvChad/nvim-colorizer.lua',
  event = { 'BufRead' },
  config = true,
})

require('modules.ui.colorschemer')()
