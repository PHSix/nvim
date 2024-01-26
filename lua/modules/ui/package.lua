local package = require('core.pack').package
local conf = require('modules.ui.config')

package({ 'nvim-tree/nvim-web-devicons', lazy = true })

package({
  'eoh-bse/minintro.nvim',
  config = true,
  lazy = false,
})

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
  config = true,
})

package({
  'dasupradyumna/midnight.nvim',
  config = function()
    vim.cmd([[colorscheme midnight]])
    vim.cmd([[hi ScrollView guibg=#878d96]])
  end,
})

-- require('modules.ui.colorschemer')()

