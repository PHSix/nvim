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
  config       = conf.noice,
  enabled      = false,
  dependencies = {
    {
      'MunifTanjim/nui.nvim',
      lazy = true,
    },
  },
})

package({
  'NTBBloodbath/doom-one.nvim',
  config = function()
    vim.cmd([[colorscheme doom-one]])
  end,
})

-- require('modules.ui.colorschemer')()
