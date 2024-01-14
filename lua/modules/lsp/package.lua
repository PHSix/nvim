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
  },
  config = conf.nvim_lsp,
})

vim.g.coq_settings = {
  ['keymap.pre_select'] = true,
  ['auto_start'] = true,
  ['display.pum.fast_close'] = false,
  ['clients.tags.enabled'] = false,
  ['clients.registers.enabled'] = false,
  ['clients.tmux.enabled'] = false,
  ['clients.buffers.enabled'] = false,
  ['clients.tree_sitter.enabled'] = false,
}

package({
  'ms-jpq/coq_nvim',
  enabled = false,
})

package({
  'glepnir/lspsaga.nvim',
  event = 'BufRead',
  cmd = 'Lspsaga',
  config = conf.lspsaga,
})

package({
  'PHSix/epo.nvim',
  config = conf.epo,
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
