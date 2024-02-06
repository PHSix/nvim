local opt = vim.opt
local cache_dir = vim.env.HOME .. '/.cache/nvim/'

opt.termguicolors = true
opt.hidden = true
opt.magic = true
opt.virtualedit = 'block'
opt.swapfile = false
opt.directory = cache_dir .. 'swap/'
opt.undodir = cache_dir .. 'undo/'
opt.backupdir = cache_dir .. 'backup/'
opt.viewdir = cache_dir .. 'view/'
opt.spellfile = cache_dir .. 'spell/en.uft-8.add'
opt.history = 2000
opt.ignorecase = true
opt.smartcase = true
opt.infercase = true
opt.spell = false
opt.spelllang = 'en,cjk'

if vim.fn.executable('rg') == 1 then
  opt.grepformat = '%f:%l:%c:%m,%f:%l:%m'
  opt.grepprg = 'rg --vimgrep --no-heading --smart-case'
end

opt.showmode = true
opt.shortmess = 'aoOTIcF'
opt.scrolloff = 2
opt.sidescrolloff = 5
opt.ruler = false
opt.showtabline = 0
opt.winwidth = 30
opt.pumheight = 15
opt.showcmd = false

-- opt.cmdheight = 0
opt.laststatus = 3
opt.list = true
-- opt.listchars = 'tab:»·,nbsp:+,trail:·,extends:→,precedes:←'
opt.listchars = 'tab:  ,nbsp:+,trail: ,extends:→,precedes:←'
opt.pumblend = 10
opt.winblend = 10
opt.undofile = true

opt.smarttab = true
opt.expandtab = true
opt.autoindent = true
opt.tabstop = 2
opt.shiftwidth = 2

-- wrap
opt.linebreak = true
-- opt.whichwrap = 'h,l,<,>,[,],~'
opt.whichwrap = '<,>,[,],~'
opt.breakindentopt = 'shift:2,min:20'
opt.showbreak = '↳ '

opt.foldlevelstart = 99
opt.foldmethod = 'manual'

opt.number = true
opt.signcolumn = 'yes'
opt.spelloptions = 'camel'

-- opt.textwidth = 100
-- opt.colorcolumn = '100'
if vim.loop.os_uname().sysname == 'Darwin' then
  vim.g.clipboard = {
    name = 'macOS-clipboard',
    copy = {
      ['+'] = 'pbcopy',
      ['*'] = 'pbcopy',
    },
    paste = {
      ['+'] = 'pbpaste',
      ['*'] = 'pbpaste',
    },
    cache_enabled = 0,
  }
  vim.g.python_host_prog = '/usr/bin/python'
  -- vim.g.python3_host_prog = '/usr/local/bin/python3'
  vim.g.python3_host_prog = '/opt/homebrew/bin/python3'
end
opt.cursorline = true

local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
for type, icon in pairs(signs) do
  local hl = 'DiagnosticSign' .. type
  vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
end

