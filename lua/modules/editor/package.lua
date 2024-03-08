local package = require('core.pack').package
local conf = require('modules.editor.config')

package({
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  config = conf.nvim_treesitter,
  dependencies = {
    {
      'JoosepAlviste/nvim-ts-context-commentstring',
      lazy = true,
    },
  },
})

package({
  'psliwka/vim-smoothie',
})

package({
  'famiu/bufdelete.nvim',
  cmd = 'Bdelete',
})

package({
  'folke/flash.nvim',
  lazy = true,
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
  'nvimdev/hlsearch.nvim',
  config = true,
})

package({
  'ojroques/nvim-osc52',
  config = conf.nvim_osc52,
})

package({
  'numToStr/Comment.nvim',
  config = conf.comment_nvim,
  lazy = true,
})

vim.g.floaterm_keymap_toggle = '<C-t>'

package({
  'voldikss/vim-floaterm',
  keys = '<C-t>',
})

package({
  'folke/todo-comments.nvim',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
})

package({
  'kawre/leetcode.nvim',
  build = ':TSUpdate html',
  dependencies = {
    'nvim-telescope/telescope.nvim',
    'nvim-lua/plenary.nvim', -- telescope 所需
    'MunifTanjim/nui.nvim',

    -- 可选
    'nvim-treesitter/nvim-treesitter',
    'nvim-tree/nvim-web-devicons',
  },
  opts = {
    -- 配置放在这里
    cn = {
      enabled = true,
    },
    lang = 'typescript',
  },
})

