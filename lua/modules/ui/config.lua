local config = {}

function config.dashboard()
  local db = require('dashboard')
  db.setup({
    theme = 'doom',
    config = {
      week_header = {
        enable = true,
      },
      center = {
        {
          icon = '[  ]',
          icon_hl = 'DashboardShortCut',
          desc = ' Talk is cheap, show me your code.',
          desc_hl = 'DashboardShortCut',
          key_hl = 'DashboardShortCut',
          action = '',
        },
      },
    },
  })
end

function config.indentscope()
  require('mini.indentscope').setup({})
end

function config.lualine()
  require('lualine').setup({})
end

function config.windline()
  require('modules.ui.windline')
end

function config.indent_blankline()
  -- This module contains a number of default definitions
  local rainbow_delimiters = require('rainbow-delimiters')

  ---@type rainbow_delimiters.config
  vim.g.rainbow_delimiters = {
    strategy = {
      [''] = rainbow_delimiters.strategy['global'],
      vim = rainbow_delimiters.strategy['local'],
    },
    query = {
      [''] = 'rainbow-delimiters',
      lua = 'rainbow-blocks',
    },
    priority = {
      [''] = 110,
      lua = 210,
    },
    highlight = {
      'RainbowDelimiterRed',
      'RainbowDelimiterYellow',
      'RainbowDelimiterBlue',
      'RainbowDelimiterOrange',
      'RainbowDelimiterGreen',
      'RainbowDelimiterViolet',
      'RainbowDelimiterCyan',
    },
  }

  local highlight = {
    'RainbowDelimiterRed',
    'RainbowDelimiterYellow',
    'RainbowDelimiterBlue',
    'RainbowDelimiterOrange',
    'RainbowDelimiterGreen',
    'RainbowDelimiterViolet',
    'RainbowDelimiterCyan',
  }
  local hooks = require('ibl.hooks')
  -- create the highlight groups in the highlight setup hook, so they are reset
  -- every time the colorscheme changes
  hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
    vim.api.nvim_set_hl(0, 'RainbowRed', { fg = '#E06C75' })
    vim.api.nvim_set_hl(0, 'RainbowYellow', { fg = '#E5C07B' })
    vim.api.nvim_set_hl(0, 'RainbowBlue', { fg = '#61AFEF' })
    vim.api.nvim_set_hl(0, 'RainbowOrange', { fg = '#D19A66' })
    vim.api.nvim_set_hl(0, 'RainbowGreen', { fg = '#98C379' })
    vim.api.nvim_set_hl(0, 'RainbowViolet', { fg = '#C678DD' })
    vim.api.nvim_set_hl(0, 'RainbowCyan', { fg = '#56B6C2' })
  end)

  vim.g.rainbow_delimiters = { highlight = highlight }
  require('ibl').setup({
    scope = { highlight = highlight },
    exclude = {
      filetypes = {
        'dashboard',
        'help',
      },
    },
  })

  hooks.register(hooks.type.SCOPE_HIGHLIGHT, hooks.builtin.scope_highlight_from_extmark)
end

return config

