local package = require('core.pack').package
local conf = require('modules.lsp.config')
package({
  'williamboman/mason.nvim',
  cmd = { 'Mason', 'MasonUpdate' },
  build = ':MasonUpdate',
  lazy = true,
  enabled = vim.fn.executable('nix') == 0,
  config = conf.mason,
  dependencies = { 'williamboman/mason-lspconfig.nvim', lazy = true },
})

package({
  'neovim/nvim-lspconfig',
  event = 'BufRead',
  dependencies = {
    { 'b0o/schemastore.nvim', lazy = true },
    { 'pmizio/typescript-tools.nvim', lazy = true },
    { 'folke/neodev.nvim', lazy = true },
    { 'davidmh/cspell.nvim', lazy = true },
  },
  config = conf.nvim_lsp,
})

package({
  'glepnir/lspsaga.nvim',
  event = 'BufRead',
  cmd = 'Lspsaga',
  config = conf.lspsaga,
})

package({
  'ms-jpq/coq_nvim',
  dependencies = {
    {
      'ms-jpq/coq.thirdparty',
      branch = '3p',
    },
  },
  enabled = false,
  config = conf.coq,
})

package({
  'Shougo/ddc.vim',
  enabled = false,
  config = conf.ddc,
  dependencies = {
    'vim-denops/denops.vim',
    'matsui54/denops-popup-preview.vim',
    'Shougo/ddc-source-nvim-lsp',
  },
})

package({
  'echasnovski/mini.completion',
  version = '*',
  opts = {},
  enabled = false,
  config = function()
    require('mini.completion').setup({
      window = {
        info = { height = 25, width = 80, border = 'single' },
        signature = { height = 25, width = 80, border = 'single' },
      },
    })
  end,
})

package({
  'hrsh7th/nvim-cmp',
  config = conf.nvim_cmp,
  enabled = true,
  event = 'InsertEnter',
  dependencies = {
    { 'hrsh7th/cmp-nvim-lsp', lazy = true },
    { 'hrsh7th/cmp-path', lazy = true },
    { 'hrsh7th/cmp-buffer', lazy = true },
    { 'hrsh7th/cmp-nvim-lua', lazy = true },
    { 'saadparwaiz1/cmp_luasnip', lazy = true },
  },
})

package({
  'L3MON4D3/LuaSnip',
  build = 'make install_jsregexp',
  opts = {
    history = true,
    delete_check_events = 'TextChanged',
  },
  lazy = true,
  cmd = { 'LuaSnipEdit' },
  config = conf.luasnip,
  keys = {
    {
      '<tab>',
      function()
        return require('luasnip').jumpable(1) and '<Plug>luasnip-jump-next' or '<tab>'
      end,
      expr = true,
      silent = true,
      mode = 'i',
    },
    {
      '<tab>',
      function()
        require('luasnip').jump(1)
      end,
      mode = 's',
    },
    {
      '<s-tab>',
      function()
        require('luasnip').jump(-1)
      end,
      mode = { 'i', 's' },
    },
  },
})

package({
  'j-hui/fidget.nvim',
  event = 'LspAttach',
  config = conf.fidget,
})

package({
  'VidocqH/lsp-lens.nvim',
  event = 'LspAttach',
  opts = {
    enable = false,
  },
})

package({
  'https://git.sr.ht/~whynothugo/lsp_lines.nvim',
  event = 'LspAttach',
  enabled = false,
  config = conf.lsp_lines,
})

package({
  'DNLHC/glance.nvim',
  cmd = { 'Glance' },
  config = true,
})

package({
  'kevinhwang91/nvim-ufo',
  dependencies = 'kevinhwang91/promise-async',
  event = { 'BufReadPost' },
  config = conf.ufo,
})

package({
  'simrat39/rust-tools.nvim',
  ft = { 'rust', 'toml' },
  config = true,
})

package({
  'ray-x/go.nvim',
  dependencies = { -- optional packages
    'ray-x/guihua.lua',
  },
  config = conf.go_nvim,
  event = { 'CmdlineEnter' },
  ft = { 'go', 'gomod' },
  build = ':lua require("go.install").update_all_sync()', -- if you need to install/update all binaries
})
