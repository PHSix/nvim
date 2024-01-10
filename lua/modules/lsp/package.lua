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
  },
  config = conf.nvim_lsp,
})

vim.g.coq_settings = {
  ['keymap.pre_select'] = true,
  ['auto_start'] = true,
}

package({
  'ms-jpq/coq_nvim',
})

package({
  'glepnir/lspsaga.nvim',
  event = 'BufRead',
  cmd = 'Lspsaga',
  config = conf.lspsaga,
})

package({
  'nvimdev/epo.nvim',
  config = conf.epo,
  enabled = false,
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
