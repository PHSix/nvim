local package = require('core.pack').package
local conf = require('modules.ui.config')

package({ 'glepnir/dashboard-nvim', config = conf.dashboard })

package({ 'tjdevries/colorbuddy.nvim', lazy = true })

package({
  'echasnovski/mini.indentscope',
  event = 'VeryLazy',
  config = conf.indentscope,
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

require('modules.ui.colorschemer')()
