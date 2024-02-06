local package = require('core.pack').package
local conf = require('modules.coc.config')

package({
  'neoclide/coc.nvim',
  branch = 'release',
  config = conf.coc,
  init = function()
    vim.cmd([[set rtp+=~/.config/nvim/extensions/coc-improve]])
    vim.cmd([[set rtp+=~/.config/nvim/extensions/coc-stylua]])
    vim.cmd([[set rtp+=~/.config/nvim/extensions/coc-pos]])
    vim.cmd([[set rtp+=~/.config/nvim/extensions/coc-peek]])
  end,
})

package({
  'kevinhwang91/nvim-ufo',
  -- dir = '~/repos/nvim-ufo',
  events = { 'BufRead' },
  dependencies = 'kevinhwang91/promise-async',
  config = conf.ufo,
})
