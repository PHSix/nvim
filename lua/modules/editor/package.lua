local package = require('core.pack').package
local conf = require('modules.editor.config')

package({
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = conf.nvim_treesitter,
  event = { 'BufRead' },
  dependencies = {
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      lazy = true,
    },
  },
})

package({
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  cmd = { 'Neotree' },
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- not strictly required, but recommended
    'MunifTanjim/nui.nvim',
  },
  config = conf.neo_tree,
})

package({
  'folke/todo-comments.nvim',
  event = 'BufRead',
  config = true,
})

package({
  'psliwka/vim-smoothie',
  event = { 'BufRead' },
})

package({
  'famiu/bufdelete.nvim',
  cmd = 'Bdelete',
})

package({
  'ahmedkhalf/project.nvim',
  event = 'BufRead',
  config = conf.project,
})

package({
  'folke/flash.nvim',
  lazy = true,
  opts = {},
  keys = {
    {
      's',
      mode = { 'n', 'x', 'o' },
      function()
        require('flash').jump()
      end,
      desc = 'Flash',
    },
    {
      'S',
      mode = { 'n', 'o', 'x' },
      function()
        require('flash').treesitter()
      end,
      desc = 'Flash Treesitter',
    },
    {
      'r',
      mode = 'o',
      function()
        require('flash').remote()
      end,
      desc = 'Remote Flash',
    },
    {
      'R',
      mode = { 'o', 'x' },
      function()
        require('flash').treesitter_search()
      end,
      desc = 'Treesitter Search',
    },
    {
      '<c-s>',
      mode = { 'c' },
      function()
        require('flash').toggle()
      end,
      desc = 'Toggle Flash Search',
    },
  },
  config = conf.flash,
})

package({
  'ethanholz/nvim-lastplace',
  config = conf.lastplace,
})

package({
  'lewis6991/gitsigns.nvim',
  event = 'BufRead',
  config = conf.gitsigns,
})

package({
  'nvimdev/hlsearch.nvim',
  event = 'BufRead',
  config = true,
})

--- [[
--- co — choose ours
--- ct — choose theirs
--- cb — choose both
--- c0 — choose none
--- ]x — move to previous conflict
--- [x — move to next conflict
--- ]]
package({
  'akinsho/git-conflict.nvim',
  version = '*',
  config = true,
  event = 'BufRead',
})

package({
  'ojroques/nvim-osc52',
  config = conf.nvim_osc52,
})

package({
  'sontungexpt/stcursorword',
  event = 'VeryLazy',
  config = true,
})

package({
  'numToStr/Comment.nvim',
  config = conf.comment_nvim,
  lazy = true,
})
