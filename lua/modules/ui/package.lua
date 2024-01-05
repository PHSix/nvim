local package = require('core.pack').package
local conf = require('modules.ui.config')

package({ 'glepnir/dashboard-nvim', config = conf.dashboard })

package({
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = conf.indent_blankline,
  event = 'VeryLazy',
  dependencies = { 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim', lazy = true },
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

package({
  'folke/noice.nvim',
  opts = {
    views = {
      cmdline_popup = {
        border = {
          style = 'none',
          padding = { 1, 3 },
        },
        filter_options = {},
        win_options = {
          winhighlight = 'NormalFloat:NormalFloat,FloatBorder:FloatBorder',
        },
      },
    },
  },
  dependencies = {
    {
      'MunifTanjim/nui.nvim',
      lazy = true,
    },
  },
})

require('modules.ui.colorschemer')()
