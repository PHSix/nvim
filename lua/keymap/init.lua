---@diagnostic disable: unused-local
local keymap = require('core.keymap')
local nmap, imap, cmap, xmap, tmap, vmap = keymap.nmap, keymap.imap, keymap.cmap, keymap.xmap, keymap.tmap, keymap.vmap
local silent, noremap, expr = keymap.silent, keymap.noremap, keymap.expr
local opts = keymap.new_opts
local cmd = keymap.cmd

-- Use space as leader key
vim.g.mapleader = ' '

nmap({ ';', ':', opts() })
xmap({ ';', ':', opts(silent) })

-- buffer delete
nmap({ '<leader>bd', cmd('Bdelete'), opts(noremap, silent) })

nmap({
  { '<C-j>', '3j', opts(silent) },
  { '<C-k>', '3k', opts(silent) },
  { '<C-h>', '4h', opts(silent) },
  { '<C-l>', '4l', opts(silent) },
})

vmap({
  { '<C-j>', '3j', opts(silent) },
  { '<C-k>', '3k', opts(silent) },
  { '<C-h>', '4h', opts(silent) },
  { '<C-l>', '4l', opts(silent) },
})

nmap({
  -- save
  { '<C-s>', cmd('write'), opts(noremap) },
  -- yank
  { 'Y', 'y$', opts(noremap) },
  -- buffer jump
  { ']b', cmd('bn'), opts(noremap) },
  { '[b', cmd('bp'), opts(noremap) },
})

cmap({
  { '<C-b>', '<Left>', opts(noremap) },
  { '<C-f>', '<Right>', opts(noremap) },
})

-- usage of plugins
nmap({
  -- plugin manager: Lazy.nvim
  { '<Leader>pu', cmd('Lazy update'), opts(noremap, silent) },
  { '<Leader>pi', cmd('Lazy install'), opts(noremap, silent) },
  -- Telescope
  { '<Leader>fb', cmd('Telescope buffers'), opts(noremap, silent) },
  { '<Leader>fw', cmd('Telescope live_grep'), opts(noremap, silent) },
  { '<Leader>ff', cmd('Telescope find_files'), opts(noremap, silent) },
  { '<Leader>fo', cmd('Telescope oldfiles'), opts(noremap, silent) },
  { '<leader>ft', cmd('Telescope todo-comments'), opts(noremap, silent) },
  { '<leader>fr', cmd('Telescope resume'), opts(noremap, silent) },
  { '<M-x>', cmd('Telescope commands'), opts(noremap, silent) },

  -- Gitsigns
  { '<leader>gp', cmd('Gitsigns preview_hunk'), opts(noremap, silent) },
  { '<leader>gs', cmd('Gitsigns stage_hunk'), opts(noremap, silent) },
  { 'gj', cmd('Gitsigns next_hunk'), opts(noremap, silent) },
  { 'gk', cmd('Gitsigns prev_hunk'), opts(noremap, silent) },

  -- Spectre
  { '<leader>sw', cmd('Spectre'), opts(noremap, silent) },

  -- coc
  { '<leader>cf', cmd('CocFormat'), opts(noremap, silent) },
  { '<leader>rn', '<Plug>(coc-rename)', opts(noremap, silent) },
  { '<leader>ca', '<Plug>(coc-codeaction)', opts(noremap, silent) },
  { '<leader>j', '<Plug>(coc-diagnostic-next)', opts(noremap, silent) },
  { '<leader>k', '<Plug>(coc-diagnostic-prev)', opts(noremap, silent) },
  { '<C-n>', cmd('CocExplorer'), opts(noremap, silent) },
  { 'K', cmd("call CocActionAsync('doHover')"), opts(noremap, silent) },
  { 'gd', '<Plug>(coc-definition)', opts(noremap, silent) },
  { 'gr', '<Plug>(coc-references)', opts(noremap, silent) },
  { 'gy', '<Plug>(coc-type-definition)', opts(noremap, silent) },
  { 'gi', '<Plug>(coc-implementation)', opts(noremap, silent) },
})

