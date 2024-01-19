local package = require('core.pack').package
local conf = require('modules.coc.config')

package({
  'neoclide/coc.nvim',
  branch = 'release',
  config = conf.coc,
  init = function()
    vim.cmd([[set rtp+=~/.config/nvim/extensions/coc-stylua]])
  end,
})

package({
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  event = { 'BufReadPost' },
  config = conf.ufo,
})

