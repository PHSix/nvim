local package = require('core.pack').package
local spec_colorscheme = 'vitesse'

local use_light = false

-- helgo worl

--- random get one of list in day
--- @generic T
--- @param tbl T[]
local function random_by_day(tbl)
  local v = math.floor(os.time() / 60 / 60 / 24)

  local ret = tbl[v % #tbl]
  if ret == nil then
    ret = tbl[1]
  end

  return ret
end

return function()
  local dark_colorscheme_tbls = {
    { spec = 'NTBBloodbath/doom-one.nvim', 'doom-one' },
    { spec = 'nyoom-engineering/oxocarbon.nvim', 'oxocarbon' },
    { spec = '2nthony/vitesse.nvim', 'vitesse' },
    { spec = 'sainnhe/everforest', 'everforest' },
    {
      spec = 'olimorris/onedarkpro.nvim',
      config = function()
        require('onedarkpro').setup({
          plugins = {
            all = false,
            nvim_lsp = true,
            treesitter = true,
            dashboard = true,
            flash_nvim = true,
            gitsigns = true,
            lsp_saga = true,
            neo_tree = true,
            nvim_cmp = true,
            telescope = true,
            trouble = true,
          },
          options = {
            cursorline = true,
          },
        })
      end,
      'onedark',
    },
    {
      spec = 'AlexvZyl/nordic.nvim',
      'nordic',
      config = function()
        require('nordic').setup({
          override = {
            SpellBad = {
              bg = '#2E3440',
              sp = '#BF616A',
              undercurl = true,
              fg = '#BF616A',
            },
            SagaWinBarSep = {
              bg = 'NONE',
              fg = '#c0c8d8',
            },
            WinBar = {
              bg = 'NONE',
            },
            WinBarNC = {
              bg = 'NONE',
            },
          },
        })
      end,
    },
    { spec = 'shaunsingh/moonlight.nvim', 'moonlight' },
    { spec = 'dasupradyumna/midnight.nvim', 'midnight' },
  }

  local light_colorscheme_tbls = {
    {
      spec = 'sainnhe/edge',
      'edge',
    },
    { spec = 'sainnhe/everforest', 'everforest' },
  }

  local colorscheme_tbls = use_light and light_colorscheme_tbls or dark_colorscheme_tbls

  vim.o.background = use_light and 'light' or 'dark'

  local colorschemes = {}
  local colorschemes_map = {}

  for _, tbl in ipairs(colorscheme_tbls) do
    colorschemes_map[tbl.spec] = colorschemes_map[tbl.spec] or {}

    for _, c in ipairs(tbl) do
      table.insert(colorschemes, c)
      table.insert(colorschemes_map[tbl.spec], c)
    end
  end

  local colorscheme_plugins = vim.tbl_map(function(record)
    return { spec = record.spec, config = record.config }
  end, colorscheme_tbls)

  local random_colorscheme = spec_colorscheme or random_by_day(colorschemes)

  return (
    vim.tbl_map(
      --- @return LazySpec
      function(colorscheme)
        local spec, config = colorscheme.spec, colorscheme.config
        local plugin
        if vim.tbl_contains(colorschemes_map[spec], random_colorscheme) then
          plugin = {
            spec,
            config = function()
              if config ~= nil then
                config()
              end

              vim.cmd(string.format('colorscheme %s', random_colorscheme))
              vim.notify(
                string.format('Use the %s colorscheme successful! 💅 💅 💅', random_colorscheme),
                vim.log.levels.TRACE
              )
            end,
          }
        else
          plugin = {
            spec,
            lazy = true,
          }
        end

        return package(plugin)
      end,
      colorscheme_plugins
    )
  )
end
