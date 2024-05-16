local package = require('core.pack').package
local conf = require('modules.ui.config')

package({ 'nvim-tree/nvim-web-devicons', lazy = true })

package({
  'nvimdev/dashboard-nvim',
  event = 'VimEnter',
  enabled = false,
  config = function()
    require('dashboard').setup({
      theme = 'hyper',
    })
  end,
})

package({
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = conf.indent_blankline,
  event = 'VeryLazy',
  dependencies = { 'https://gitlab.com/HiPhish/rainbow-delimiters.nvim', lazy = true },
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
  'PHSix/vitesse.nvim',
  config = function()
    vim.cmd([[colorscheme vitesse]])
  end,
})

