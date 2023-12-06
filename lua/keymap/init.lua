---@diagnostic disable: unused-local
local keymap = require('core.keymap')
local nmap, imap, cmap, xmap, tmap, vmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap, keymap.tmap, keymap.vmap
local silent, noremap, expr = keymap.silent, keymap.noremap, keymap.expr
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = ' '

-- leaderkey
nmap({ ' ', '', opts(noremap) })
xmap({ ' ', '', opts(noremap) })
nmap({ ';', ':', opts(silent) })
xmap({ ';', ':', opts(silent) })

-- copy to clipboard
-- xmap({ 'fy', '"+y', opts(silent) })

-- buffer delete
nmap({ '<leader>bd', cmd('Bdelete'), opts(noremap, silent) })

-- faster move keys
nmap({ '<C-j>', '5j', opts(silent) })
nmap({ '<C-k>', '5j', opts(silent) })
vmap({ '<C-j>', '5j', opts(silent) })
vmap({ '<C-k>', '5j', opts(silent) })

-- usage example
nmap({
  -- noremal remap
  -- close buffer
  { '<C-x>k', cmd('bdelete'), opts(noremap, silent) },
  -- save
  { '<C-s>', cmd('write'), opts(noremap) },
  -- yank
  { 'Y', 'y$', opts(noremap) },
  -- buffer jump
  { ']b', cmd('bn'), opts(noremap) },
  { '[b', cmd('bp'), opts(noremap) },
  -- remove trailing white space
  { '<Leader>t', cmd('TrimTrailingWhitespace'), opts(noremap) },
  -- faster moving
  { '<C-h>', '3h', opts(noremap) },
  { '<C-l>', '3l', opts(noremap) },
  { '<C-j>', '3j', opts(noremap) },
  { '<C-k>', '3k', opts(noremap) },
})

vmap({
  -- faster moving
  { '<C-h>', '3h', opts(noremap) },
  { '<C-l>', '3l', opts(noremap) },
  { '<C-j>', '3j', opts(noremap) },
  { '<C-k>', '3k', opts(noremap) },
})

imap({
  -- insert mode
  { '<C-h>', '<Bs>', opts(noremap) },
  { '<C-e>', '<End>', opts(noremap) },
})

-- commandline remap
cmap({ '<C-b>', '<Left>', opts(noremap) })
-- usage of plugins
nmap({
  -- plugin manager: Lazy.nvim
  { '<Leader>pu', cmd('Lazy update'), opts(noremap, silent) },
  { '<Leader>pi', cmd('Lazy install'), opts(noremap, silent) },
  -- dashboard
  { '<Leader>n', cmd('DashboardNewFile'), opts(noremap, silent) },
  { '<Leader>ss', cmd('SessionSave'), opts(noremap, silent) },
  { '<Leader>sl', cmd('SessionLoad'), opts(noremap, silent) },
  -- Telescope
  { '<Leader>fb', cmd('Telescope buffers'), opts(noremap, silent) },
  { '<Leader>fw', cmd('Telescope live_grep'), opts(noremap, silent) },
  { '<Leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
  { '<Leader>fo', cmd('Telescope oldfiles'), opts(noremap, silent) },
  { '<leader>fd', cmd('Telescope diagnostics'), opts(noremap, silent) },
  { '<leader>fs', cmd('Telescope lsp_dynamic_workspace_symbols'), opts(noremap, silent) },
  { '<leader>ft', cmd('Telescope todo-comments'), opts(noremap, silent) },
  { '<leader>fr', cmd('Telescope resume'), opts(noremap, silent) },
  { '<M-x>', cmd('Telescope commands'), opts(noremap, silent) },

  -- Neotree
  { '<C-n>', cmd('Neotree toggle reveal'), opts(noremap, silent) },

  -- Lspsaga
  { '<leader>j', cmd('Lspsaga diagnostic_jump_next'), opts(noremap, silent) },
  { '<leader>k', cmd('Lspsaga diagnostic_jump_prev'), opts(noremap, silent) },
  { 'gd', cmd('Glance definitions'), opts(noremap, silent) },
  -- { 'gd', cmd('Lspsaga goto_definition'), opts(noremap, silent) },
  { 'gy', cmd('Glance type_definitions'), opts(noremap, silent) },
  -- { 'gy', cmd('Lspsaga goto_type_definition'), opts(noremap, silent) },
  { 'gr', cmd('Glance references'), opts(noremap, silent) },
  -- { 'gr', cmd('Lspsaga finder'), opts(noremap, silent) },
  { 'K', vim.lsp.buf.hover, opts(noremap, silent) },
  -- { 'K', cmd('Lspsaga hover_doc'), opts(noremap, silent) },
  { '<leader>rn', cmd('Lspsaga rename'), opts(noremap, silent) },
  { '<leader>ca', cmd('Lspsaga code_action'), opts(noremap, silent) },
  { '<C-t>', cmd('Lspsaga term_toggle'), opts(noremap, silent) },

  -- conform.nvim
  { '<leader>cf', cmd('LspFormat'), opts(noremap, silent) },

  -- Gitsigns
  { '<leader>gp', cmd('Gitsigns preview_hunk'), opts(noremap, silent) },
  { '<leader>gs', cmd('Gitsigns stage_hunk'), opts(noremap, silent) },
  { 'gj', cmd('Gitsigns next_hunk'), opts(noremap, silent) },
  { 'gk', cmd('Gitsigns prev_hunk'), opts(noremap, silent) },

  -- Spectre
  { '<leader>sw', cmd('Spectre'), opts(noremap, silent) },
})

tmap({ '<C-t>', '<C-\\><C-n><CMD>Lspsaga term_toggle<CR>' })
