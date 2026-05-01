-- =============================================
-- Neovim Full Configuration (Single file init.lua)
-- =============================================

-- Leader keys
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- =============================================
-- Bootstrap lazy.nvim
-- =============================================
local lazypath = vim.fn.stdpath 'data' .. '/lazy/lazy.nvim'
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system {
    'git',
    'clone',
    '--filter=blob:none',
    'https://github.com/folke/lazy.nvim.git',
    '--branch=stable',
    lazypath,
  }
end
vim.opt.rtp:prepend(lazypath)

-- =============================================
-- Core Neovim Options
-- =============================================
local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.termguicolors = true
opt.cursorline = true
opt.signcolumn = 'yes'
opt.colorcolumn = '100'
opt.cmdheight = 1
opt.showmode = false
opt.pumheight = 10
opt.pumblend = 10

opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.smartindent = true
opt.autoindent = true
opt.wrap = false
opt.linebreak = true

opt.ignorecase = true
opt.smartcase = true
opt.hlsearch = true
opt.incsearch = true

opt.autoread = true
opt.undofile = true
opt.swapfile = false
opt.backup = false
opt.writebackup = false
opt.updatetime = 250
opt.timeoutlen = 500

opt.mouse = 'a'

opt.lazyredraw = true
opt.redrawtime = 1500
opt.synmaxcol = 300

opt.splitright = true
opt.splitbelow = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.virtualedit = 'block'
opt.completeopt = 'menuone,noselect'

opt.foldcolumn = '0'
opt.foldlevel = 99
opt.foldlevelstart = 99
opt.foldenable = true

local signs = {
  Error = '󰅚 ',
  Warn = '󰀪 ',
  Hint = '󰌶 ',
  Info = '➔ ',
}

vim.diagnostic.config {
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = signs.Error,
      [vim.diagnostic.severity.WARN] = signs.Warn,
      [vim.diagnostic.severity.HINT] = signs.Hint,
      [vim.diagnostic.severity.INFO] = signs.Info,
    },
  },
}

vim.diagnostic.config {
  float = {
    border = 'rounded',
    title = 'Diagnostic',
    title_pos = 'left',
  },
}

-- =============================================
-- Optimized Autocmds
-- =============================================
local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

augroup('YankHighlight', { clear = true })
autocmd('TextYankPost', {
  group = 'YankHighlight',
  pattern = '*',
  callback = function() vim.highlight.on_yank { higroup = 'IncSearch', timeout = 200 } end,
})

augroup('ResizeSplits', { clear = true })
autocmd('VimResized', {
  group = 'ResizeSplits',
  pattern = '*',
  command = 'tabdo wincmd =',
})

augroup('LastPlace', { clear = true })
autocmd('BufReadPost', {
  group = 'LastPlace',
  pattern = '*',
  callback = function()
    local mark = vim.api.nvim_buf_get_mark(0, '"')
    local lcount = vim.api.nvim_buf_line_count(0)
    if mark[1] > 0 and mark[1] <= lcount then pcall(vim.api.nvim_win_set_cursor, 0, mark) end
  end,
})

augroup('CloseSpecialBuffers', { clear = true })
autocmd('FileType', {
  group = 'CloseSpecialBuffers',
  pattern = { 'help', 'qf', 'man', 'notify' },
  callback = function(event) vim.keymap.set('n', 'q', '<cmd>close<cr>', { buffer = event.buf, silent = true }) end,
})

augroup('BigFileDisable', { clear = true })
autocmd({ 'BufReadPre' }, {
  group = 'BigFileDisable',
  pattern = '*',
  callback = function()
    local file_size = vim.fn.getfsize(vim.fn.expand '%:p')
    if file_size > 1024 * 1024 then
      vim.cmd 'syntax off'
      vim.opt_local.foldmethod = 'manual'
      vim.opt_local.spell = false
      vim.opt_local.undofile = false
      vim.notify('Big file mode enabled', vim.log.levels.WARN)
    end
  end,
})

-- =============================================
-- Basic Keymaps
-- =============================================
vim.keymap.set('n', '<C-j>', '3j', { desc = 'Move down 3 lines' })
vim.keymap.set('n', '<C-k>', '3k', { desc = 'Move up 3 lines' })

vim.keymap.set('n', '<leader>w', '<cmd>w<cr>', { desc = 'Save file' })
vim.keymap.set('n', '<leader>q', '<cmd>q<cr>', { desc = 'Close window' })
vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

vim.keymap.set('v', '<leader>y', '"+y', { desc = 'Copy to clipboard' })

-- =============================================
-- Plugin Setup with lazy.nvim
-- =============================================
require('lazy').setup {

  -- Treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    opts = {
      ensure_installed = {
        'lua',
        'vim',
        'vimdoc',
        'markdown',
        'markdown_inline',
        'bash',
        'python',
        'javascript',
        'typescript',
        'html',
        'css',
        'json',
        'rust',
        'vue',
      },
      highlight = { enable = true },
      indent = { enable = true },
      incremental_selection = { enable = true },
    },
  },

  -- Comment plugin
  {
    'numToStr/Comment.nvim',
    event = 'VeryLazy',
    opts = {},
  },

  -- Colorscheme
  {
    'navarasu/onedark.nvim',
    priority = 1000,
    config = function()
      require('onedark').setup {
        style = 'darker',
        transparent = false,
        term_colors = true,
        code_style = { comments = 'italic' },
      }
      require('onedark').load()
    end,
  },

  -- LSP setup
  {
    'neovim/nvim-lspconfig',
    lazy = false,
    priority = 10000,
    dependencies = {
      'williamboman/mason.nvim',
      'williamboman/mason-lspconfig.nvim',
      'saghen/blink.cmp',
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',

      -- Rust
      {
        'mrcjkb/rustaceanvim',
        version = '^9',
        lazy = false,
      },
    },
    config = function()
      require('mason').setup()
      require('mason-lspconfig').setup {
        ensure_installed = { 'lua_ls', 'pyright', 'vtsls', 'html', 'cssls', 'jsonls', 'vue_ls', 'rust_analyzer' },
        automatic_installation = true,
        automatic_enable = false,
      }
      require('blink.cmp').setup {
        keymap = { preset = 'enter' },
        appearance = { use_nvim_cmp_as_default = true, nerd_font_variant = 'mono' },
        snippets = { preset = 'luasnip' },
        sources = { default = { 'lsp', 'path', 'snippets', 'buffer' } },
        signature = { enabled = true },
      }

      local capabilities = require('blink.cmp').get_lsp_capabilities()

      vim.api.nvim_create_autocmd('LspAttach', {
        desc = 'LSP Keybindings',
        callback = function(event)
          local bufnr = event.buf
          local map = function(mode, lhs, rhs, desc) vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc, silent = true }) end

          map('n', 'gd', vim.lsp.buf.definition, 'Go to Definition')
          map('n', 'gD', vim.lsp.buf.declaration, 'Go to Declaration')
          map('n', 'gi', vim.lsp.buf.implementation, 'Go to Implementation')
          map('n', 'gr', vim.lsp.buf.references, 'Go to References')
          map('n', 'K', vim.lsp.buf.hover, 'Hover Documentation')
          map('n', '<leader>rn', vim.lsp.buf.rename, 'Rename Symbol')
          map({ 'n', 'v' }, '<leader>ca', vim.lsp.buf.code_action, 'Code Action')
          map('n', '<leader>df', vim.diagnostic.open_float, 'Show Diagnostics')
          map('n', '<leader>k', function() vim.diagnostic.jump { count = -1, float = true } end, 'Previous Diagnostic')
          map('n', '<leader>j', function() vim.diagnostic.jump { count = 1, float = true } end, 'Next Diagnostic')
        end,
      })

      ---@type vim.lsp.Config
      local config = {
        settings = {
          Lua = {
            runtime = {
              version = 'LuaJIT',
            },
            workspace = {
              preloadFileSize = 10000,
              library = {
                vim.env.VIMRUNTIME,
              },
            },
          },
        },
      }

      vim.lsp.config('lua_ls', config)

      -- configuration work for nvim-ufo fold
      capabilities.textDocument.foldingRange = {
        dynamicRegistration = false,
        lineFoldingOnly = true,
      }
      vim.lsp.config('*', { capabilities = capabilities })

      vim.lsp.enable { 'lua_ls', 'pyright', 'vtsls', 'html', 'cssls', 'jsonls', 'vue_ls' }
    end,
  },

  -- TypeScript enhancements
  {
    'nemanjamalesija/ts-expand-hover.nvim',
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact' },
    config = function() require('ts_expand_hover').setup { keymaps = { hover = '<leader>th' } } end,
  },
  {
    'dmmulroy/ts-error-translator.nvim',
    ft = { 'typescript', 'typescriptreact', 'javascript', 'javascriptreact', 'vue' },
    config = function() require('ts-error-translator').setup() end,
  },

  -- LSP UI
  {
    'j-hui/fidget.nvim',
    event = 'LspAttach',
    config = function() require('fidget').setup { notification = { window = { winblend = 0 } } } end,
  },

  -- nvim-bqf with LSP-friendly configuration
  {
    'kevinhwang91/nvim-bqf',
    ft = 'qf',
    config = function()
      require('bqf').setup {
        auto_enable = true,
        auto_resize_height = true,

        -- LSP Jump
        preview = {
          auto_preview = true,
          win_height = 15,
          win_vheight = 15,
          delay_syntax = 50,
          border = { '┏', '━', '┓', '┃', '┛', '━', '┗', '┃' },
          show_title = true,
          should_preview_cb = function(bufnr, _)
            local ret = true
            local filename = vim.api.nvim_buf_get_name(bufnr)
            local fsize = vim.fn.getfsize(filename)
            if fsize > 100 * 1024 then ret = false end
            return ret
          end,
        },

        func_map = {
          open = 'o',
          openc = 'O',
          split = '<C-x>',
          vsplit = '<C-v>',
          tabopen = 't',
          ptogglemode = 'zp',
          pscrollup = '<C-b>',
          pscrolldown = '<C-f>',
        },

        filter = {
          fzf = {
            action_for = {
              ['ctrl-s'] = 'split',
              ['ctrl-v'] = 'vsplit',
              ['ctrl-t'] = 'tabedit',
            },
          },
        },
      }
    end,
  },

  -- Neo-tree
  {
    'nvim-neo-tree/neo-tree.nvim',
    branch = 'v3.x',
    dependencies = { 'nvim-lua/plenary.nvim', 'nvim-tree/nvim-web-devicons', 'MunifTanjim/nui.nvim' },
    cmd = 'Neotree',
    keys = { { '<C-n>', '<cmd>Neotree toggle position=right<cr>', desc = 'Toggle Neo-tree' } },
    config = function()
      require('neo-tree').setup {
        filesystem = { follow_current_file = { enabled = true } },
        window = { position = 'left', width = 35 },
      }
    end,
  },

  -- fzf-lua
  {
    'ibhagwan/fzf-lua',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<leader>sf', '<cmd>FzfLua files<cr>', desc = 'Find Files' },
      { '<leader>sw', '<cmd>FzfLua live_grep<cr>', desc = 'Live Grep' },
      { '<leader>sb', '<cmd>FzfLua buffers<cr>', desc = 'Find Buffers' },
      { '<leader>sh', '<cmd>FzfLua help_tags<cr>', desc = 'Help Tags' },
      { '<leader>sr', '<cmd>FzfLua oldfiles<cr>', desc = 'Recent Files' },
      { '<leader>ss', '<cmd>FzfLua lsp_document_symbols<cr>', desc = 'Document Symbols' },
    },
    config = function()
      local function setup()
        local columns = vim.o.columns / 2
        local rows = vim.o.lines
        local layout = columns > rows and 'horizontal' or 'vertical'
        require('fzf-lua').setup {
          winopts = {
            backdrop = 0,
            preview = {
              horizontal = 'right:55%',
              vertical = 'up:55%',
              default = 'bat',
              layout = layout,
              flip_columns = 100,
            },
          },
        }
      end

      setup()

      -- dynamically change windows layout
      vim.api.nvim_create_autocmd('VimResized', {
        callback = function() setup() end,
      })
    end,
  },

  -- Git signs
  {
    'lewis6991/gitsigns.nvim',
    lazy = false,
    keys = {
      { 'gj', '<Cmd>Gitsigns next_hunk<CR>', desc = 'Goto next hunk' },
      { 'gk', '<Cmd>Gitsigns prev_hunk<CR>', desc = 'Goto prev hunk' },
      { '<leader>gP', '<Cmd>Gitsigns preview_hunk<CR>', desc = 'Preview hunk' },
    },
    opts = {
      signs = {
        add = { text = '┃' },
        change = { text = '┃' },
        delete = { text = '▁' },
        topdelete = { text = '▔' },
        changedelete = { text = '┃' },
      },
    },
  },

  -- ToggleTerm
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<C-t>', '<cmd>ToggleTerm<cr>', desc = 'Toggle Terminal' },
    },
    opts = {
      size = 15,
      open_mapping = '<C-t>',
      hide_numbers = true,
      shade_terminals = true,
      shading_factor = 2,
      start_in_insert = true,
      insert_mappings = true,
      persist_size = true,
      direction = 'horizontal',
      close_on_exit = true,
      shell = vim.o.shell,
    },
  },

  -- Surround
  {
    'kylechui/nvim-surround',
    version = '*',
    event = 'VeryLazy',
    opts = {},
  },

  -- Smooth scrolling
  {
    'karb94/neoscroll.nvim',
    event = 'VeryLazy',
    opts = {
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', '<C-y>', '<C-e>', 'zt', 'zz', 'zb' },
      hide_cursor = true,
      stop_eof = true,
      respect_scrolloff = false,
      cursor_scrolls_alone = true,
      duration_multiplier = 0.4,
    },
  },

  -- Flash motion
  {
    'folke/flash.nvim',
    event = 'VeryLazy',
    keys = {
      { 's', mode = { 'n', 'x', 'o' }, function() require('flash').jump() end, desc = 'Flash Jump' },
      { 'S', mode = { 'n', 'x', 'o' }, function() require('flash').treesitter() end, desc = 'Flash Treesitter' },
      { 'r', mode = 'o', function() require('flash').remote() end, desc = 'Remote Flash' },
      { 'R', mode = { 'o', 'x' }, function() require('flash').treesitter_search() end, desc = 'Treesitter Search' },
      { '<c-s>', mode = { 'c' }, function() require('flash').toggle() end, desc = 'Toggle Flash Search' },
    },
    opts = {
      labels = 'asdfghjklqwertyuiopzxcvbnm',
      highlight = { backdrop = true, matches = true },
      modes = {
        char = { enabled = true, jump_labels = true },
      },
    },
  },

  -- nvim-ufo
  {
    'kevinhwang91/nvim-ufo',
    dependencies = { 'kevinhwang91/promise-async' },
    event = 'BufReadPost',
    config = function()
      require('ufo').setup {
        provider_selector = function(_, _, _) return { 'lsp', 'indent' } end,
        close_fold_kinds_for_ft = {
          defualts = { 'imports', 'comment' },
        },
        preview = {
          win_config = { border = 'rounded', winblend = 0 },
        },
      }
      vim.keymap.set('n', 'zR', require('ufo').openAllFolds, { desc = 'Open all folds' })
      vim.keymap.set('n', 'zM', require('ufo').closeAllFolds, { desc = 'Close all folds' })
    end,
  },

  -- nvim-hlchunk
  {
    'yaocccc/nvim-hlchunk',
    event = 'BufReadPost',
    config = function()
      vim.g.hlchunk_files = '*.lua,*.ts,*.js,*.json,*.go,*.c,*.cpp,*.rs,*.h,*.hpp,*.py,*.md'
      vim.g.hlchunk_time_delay = 50
      vim.g.hlchunk_line_limit = 5000
      vim.cmd [[
        augroup HLChunkHighlight
          autocmd!
          autocmd VimEnter * hi HLIndentLine ctermfg=244 guifg=#5c6370
        augroup END
      ]]
    end,
  },

  -- conform.nvim (smart formatter)
  {
    'stevearc/conform.nvim',
    event = 'BufWritePre',
    config = function()
      local conform = require 'conform'
      conform.setup {
        formatters_by_ft = {
          lua = { 'stylua' },
          python = { 'black', 'isort' },
          javascript = { 'eslint', 'biome', 'prettier', stop_after_first = true },
          typescript = { 'eslint', 'biome', 'prettier', stop_after_first = true },
          javascriptreact = { 'eslint', 'biome', 'prettier', stop_after_first = true },
          typescriptreact = { 'eslint', 'biome', 'prettier', stop_after_first = true },
          html = { 'prettier' },
          css = { 'prettier' },
          json = { 'prettier' },
          markdown = { 'prettier' },
        },
        format_on_save = {
          timeout_ms = 800,
          lsp_format = 'fallback',
        },
      }

      vim.keymap.set({ 'n', 'v' }, '<leader>fm', function() conform.format { async = true, lsp_format = 'fallback' } end, { desc = 'Format buffer (manual)' })
    end,
  },

  -- OpenCode AI
  {
    'nickjvandyke/opencode.nvim',
    version = '*',
    config = function()
      vim.g.opencode_opts = {}
      vim.o.autoread = true

      vim.keymap.set({ 'n', 'x' }, '<C-a>', function() require('opencode').ask('@this: ', { submit = true }) end, { desc = 'Ask opencode' })

      vim.keymap.set({ 'n', 'x' }, '<C-x>', function() require('opencode').select() end, { desc = 'Select opencode action' })

      vim.keymap.set({ 'n', 't' }, '<C-.>', function() require('opencode').toggle() end, { desc = 'Toggle opencode' })
    end,
  },

  -- Which-key
  {
    'folke/which-key.nvim',
    event = 'VeryLazy',
    opts = {
      delay = 200,
      spec = {
        { '<leader>s', group = 'Search' },
        { '<leader>t', group = 'Terminal/TS' },
        { '<leader>c', group = 'Code/LSP' },
        { '<leader>w', group = 'Windows' },
        { '<leader>b', group = 'Buffers' },
        { '<leader>g', group = 'Git' },
      },
      icons = {
        breadcrumb = '»',
        separator = '➜',
        group = '+',
      },
      win = {
        border = 'rounded',
      },
    },
    keys = {
      {
        '<leader>?',
        function() require('which-key').show { global = false } end,
        desc = 'Buffer Local Keymaps (which-key)',
      },
    },
  },

  -- Statusline plugin, use airline style
  {
    'nvim-lualine/lualine.nvim',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'onedark',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        globalstatus = true,
      },
      sections = {
        lualine_a = { { 'mode' } },
        lualine_b = { 'branch', 'diff' },
        lualine_c = {
          { 'filename', file_status = true, path = 1 },
        },
        lualine_x = {
          {
            'diagnostics',
            sources = { 'nvim_diagnostic' },
            symbols = { error = ' ', warn = ' ', info = ' ', hint = '󰌶 ' },
          },
          'filetype',
        },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },

  -- LSP location, render on winbar
  {
    'SmiteshP/nvim-navic',
    config = function()
      require('nvim-navic').setup {
        icons = {
          File = '󰈙 ',
          Module = ' ',
          Namespace = '󰌗 ',
          Package = ' ',
          Class = '󰌗 ',
          Method = '󰆧 ',
          Property = ' ',
          Field = ' ',
          Constructor = ' ',
          Enum = '󰕘',
          Interface = '󰕘',
          Function = '󰊕 ',
          Variable = '󰆧 ',
          Constant = '󰏿 ',
          String = '󰀬 ',
          Number = '󰎠 ',
          Boolean = '◩ ',
          Array = '󰅪 ',
          Object = '󰅩 ',
          Key = '󰌋 ',
          Null = '󰟢 ',
          EnumMember = ' ',
          Struct = '󰌗 ',
          Event = ' ',
          Operator = '󰆕 ',
          TypeParameter = '󰊄 ',
          enabled = true,
        },
        lsp = {
          auto_attach = true,
          preference = nil,
        },
        highlight = true,
        separator = ' > ',
        depth_limit = 0,
        depth_limit_indicator = '..',
        safe_output = true,
        lazy_update_context = false,
        click = false,
        format_text = function(text) return text end,
      }

      vim.o.winbar = "%{%v:lua.require'nvim-navic'.get_location()%}"
    end,
  },

  -- Misc
  {
    'folke/snacks.nvim',
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      bigfile = { enabled = true },
      input = { enabled = true },
      picker = { enabled = true },
      statuscolumn = { enabled = true },
      words = { enabled = true },
    },

    config = function(_, opts)
      require('snacks').setup(opts)

      vim.keymap.set('n', '<leader>bd', function() require('snacks').bufdelete.delete() end, { desc = 'Delete current buffer' })
      vim.keymap.set('n', '<leader>gg', function() require('snacks').lazygit() end, { desc = 'Lazygit' })
    end,
  },

  -- autopairs
  {
    'windwp/nvim-autopairs',
    event = 'InsertEnter',
    config = true,
  },
}
