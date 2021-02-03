local execute = vim.api.nvim_command
local fn = vim.fn
vim.g.github_mirror = "fastgit"
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com.cnpmjs.org/PHSix/packer.nvim '..install_path)
end
vim.cmd [[packadd packer.nvim]]
require('packer').init({
  clone_timeout = 30,
})
return require('packer').startup(function()
  use {
    'PHSix/packer.nvim',
    opt = true
  }
  use {
    'lilydjwg/fcitx.vim'
  }
  use {
    'vimwiki/vimwiki',
    opt=true,
    ft={'markdown', 'vimwiki'}
  }
  use {
    'tpope/vim-surround',
  }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = 'TSUpdate',
    config = function()
      require'nvim-treesitter.configs'.setup {
        ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        highlight = {
          enable = true,              -- false will disable the whole extension
          disable = {"rust" },  -- list of language that will be disabled
        },
      }
    end
  }
  use {
    'hardcoreplayers/dashboard-nvim',
    setup = function()
      local vim = vim
      vim.g.dashboard_default_executive = 'fzf'
      vim.g.dashboard_preview_command = 'cat'
      vim.g.dashboard_preview_pipeline = "lolcat"
      vim.g.dashboard_preview_file = vim.fn['getenv']('HOME') .. '/.config/nvim/static/neovim.txt'
      vim.g.dashboard_preview_file_height = 8
      vim.g.dashboard_preview_file_width = 50
      vim.cmd("autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2")
      vim.api.nvim_set_keymap("n", "<C-f>s", ":<C-u>SessionSave<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>l", ":<C-u>SessionLoad<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>h", ":DashboardFindHistory<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>f", ":DashboardFindFile<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>c", ":DashboardChangeColorscheme<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>b", ":DashboardJumpMark<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>w", ":DashboardFindWord<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>n", ":DashboardNewFile<CR>", {noremap=true, silent=true})
      vim.g.dashboard_custom_shortcut = {
        last_session="<Ctrl-f>l",
        find_history="<Ctrl-f>h",
        find_file="<Ctrl-f>f",
        new_file="<Ctrl-f>n",
        change_colorscheme="<Ctrl-f>c",
        find_word="<Ctrl-f>w",
        book_marks="<Ctrl-f>b"
      }
    end,
  }
  use {
    'junegunn/fzf.vim',
    config = function()
    end
  }
  use {
    'rhysd/accelerated-jk',
    keys = {{'n','j'}, {'n','k'}},
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj_position)", {noremap=false, silent=true})
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk_position)", {noremap=false, silent=true})
    end
  }
  use {
    'gcmt/wildfire.vim',
    keys = {'n', '<CR>'}
  }
  use {
    'junegunn/vim-easy-align',
    keys = {{'v','ga'}, {'n', 'ga'}},
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {silent=true})
      vim.api.nvim_set_keymap("v", "ga", "<Plug>(EasyAlign)", {silent=true})
    end
  }
  use {
    'Chiel92/vim-autoformat',
    keys={'F'},
    config = function()
      local vim = vim

      vim.api.nvim_set_keymap("n", "F", ":Autoformat<CR>", {noremap=true, silent=true})
    end
  }
  use {
    'skywind3000/asynctasks.vim',
    requires = {'skywind3000/asyncrun.vim', opt=true},
    keys = {'R'},
    config = function()
      local vim = vim
      vim.g.asyncrun_open = 9
      vim.g.asynctasks_rtp_config = "asynctasks.ini"
      vim.api.nvim_set_keymap("n", "R", ":lua StartR()<CR>",   { noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "B", ":AsyncTask file-build<CR>", { noremap=true, silent=true})
    end,
  }
  use {
    'dart-lang/dart-vim-plugin',
    opt=true
  }
  use {
    'dhruvasagar/vim-table-mode',
    opt=true,
    ft={'markdown'}
  }
  use {
    'kien/rainbow_parentheses.vim',
    event='BufReadPost *',
    config = function()
      local vim = vim
      vim.g.rbpt_max = 16
      vim.g.rbpt_loadcmd_toggle = 0
      vim.cmd("au VimEnter * RainbowParenthesesToggle")
      vim.cmd("au Syntax * RainbowParenthesesLoadRound")
      vim.cmd("au Syntax * RainbowParenthesesLoadSquare")
      vim.cmd("au Syntax * RainbowParenthesesLoadBraces")
    end
  }

  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      vim.o.termguicolors = true
      require'colorizer'.setup()
    end
  }
  use {
    'fatih/vim-go',
    ft = {'go', 'gomod'},
    config = function()
      local vim = vim
      vim.g.go_version_warning = 0
      vim.g.go_echo_go_info = 0
      vim.g.go_fmt_autosave = 0
      vim.g.go_doc_popup_window = 1
      vim.g.go_def_mapping_enabled = 0
      vim.g.go_template_autocreate = 0
      vim.g.go_textobj_enabled = 0
      vim.g.go_auto_type_info = 1
      vim.g.go_def_mapping_enabled = 0
      vim.g.go_doc_keywordprg_enabled = 0
      vim.g.go_statusline_duration = 0
    end
  }
  use {
    'jreybert/vimagit',
    opt=true,
    cmd = {"Magit", "MagitOnly"}
  }
  use {
    'npxbr/glow.nvim',
    cmd = {"Glow"}
  }
  use {
    'liuchengxu/vista.vim',
    cmd={'Vista'},
    config = function ()
      local vim = vim
      vim.g.vista_icon_indent = { "╰─▸ ", "├─▸ " }
      vim.cmd("let g:vista#renderer#enable_icon = 1")
    end
  }
  use {
    'nvim-telescope/telescope.nvim',
    keys = {'<leader>tf', '<leader>tg', '<leader>tl'},
    requires = {{'nvim-lua/popup.nvim', opt=true}, {'nvim-lua/plenary.nvim', opt=true}},
    config = function ()
      local vim = vim
      vim.api.nvim_set_keymap("n", '<leader>tf',':Telescope find_files<CR>', {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", '<leader>tl',':Telescope live_grep<CR>', {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", '<leader>tg',':Telescope help_tags<CR>', {noremap=true, silent=true})
    end
  }
  use {
    'akinsho/nvim-bufferline.lua',
    requires = {'kyazdani42/nvim-web-devicons', opt=true},
    config = function ()
      require'bufferline'.setup{
        options = {
          modified_icon = '✥',
          mappings = true,
          buffer_close_icon = "",
          always_show_bufferline = false,
        }
      }
    end
  }
  use {
    "glepnir/lspsaga.nvim",
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap('n', "K",          ":lua vim.lsp.buf.hover()<CR>",                                    {noremap=true, silent=true})
      vim.api.nvim_set_keymap('n', "<leader>rn", ":lua require('lspsaga.rename').rename()<CR>",                     {noremap=true, silent=true})
      vim.api.nvim_set_keymap('v', "<leader>rn", ":lua require('lspsaga.rename').rename()<CR>",                     {noremap=true, silent=true})
      vim.api.nvim_set_keymap('n', "gp",         ":lua require'lspsaga.provider'.preview_definition()<CR>",         {noremap=true, silent=true})
      vim.api.nvim_set_keymap('n', "[g",         ":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap('n', "]g",         ":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap('n', "<leader>gf", ":lua require'lspsaga.provider'.lsp_finder()<CR>",                 {noremap=true, silent=true})
      vim.api.nvim_set_keymap('n', "<leader>ca", ":lua require('lspsaga.codeaction').code_action()<CR>",                {noremap=true, silent=true})

    end
  }
  use {
    'voldikss/vim-translator',
    keys = {{"v", '<leader>tt'},{'n', '<leader>tt'}},
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap('n', '<leader>tt', '<Plug>TranslateW', {noremap=false, silent=true})
      vim.api.nvim_set_keymap('v', '<leader>tt', '<Plug>TranslateW', {noremap=false, silent=true})
    end
  }
  use {
    'jiangmiao/auto-pairs'
  }
  use {
    'airblade/vim-gitgutter',
    event={'BufReadPost *'},
    config = function()
    end
  }
  use {
    'kyazdani42/nvim-tree.lua',
    key={{'n', '<C-n>'}},
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap('n', '<C-n>', ':NvimTreeToggle<CR>', {noremap=true, silent=true})
      vim.g.nvim_tree_indet_markers = 1
      vim.g.nvim_tree_auto_close = 1
      vim.g.nvim_tree_git_hl     = 1
      vim.g.nvim_tree_follow     = 1
      vim.g.nvim_tree_bindings   = {
        edit={'o', '<CR>'},
        rename={'r'},
        remove={'dD'},
        cut={'dd'},
        close={'q'},
        paste={'p'},
        dir_up={'u'},
        preview={'<TAB>'},
        copy={'copy'},
        create={'cn'},
      }
    end,
    requires = {'kyazdani42/nvim-web-devicons', opt=true}
  }
  use{
    'neovim/nvim-lspconfig',
    config = function()
      local vim = vim
      vim.fn['sign_define']('LspDiagnosticsSignError',{
        text=' ▊',
        texthl='LspDiagnosticsSignError',
        numhl='LspDiagnosticsSignError',
      })
      vim.fn['sign_define']('LspDiagnosticsSignWarning', {
        text=' ▊',
        texthl='LspDiagnosticsSignWarning',
        numhl='LspDiagnosticsSignWarning',
      })
      vim.fn['sign_define']('LspDiagnosticsSignHint', {
        text=' ▊',
        texthl='LspDiagnosticsSignHint',
        numhl='LspDiagnosticsSignHint',
      })
      vim.fn['sign_define']('LspDiagnosticsSignInformation', {
        text=' ▊',
        texthl='LspDiagnosticsSignInformation',
        numhl='LspDiagnosticsSignInformation',
      })
    end
  }
  use {
    'nvim-lua/completion-nvim',
    config = function()
      local vim = vim
      vim.o.completeopt = "menu,menuone,noselect"
      vim.g.updatetime = 100
      vim.g.completion_timer_cycle = 150
      vim.g.completion_enable_auto_signature = 0
      vim.g.completion_enable_snippet = "vim-vsnip"
      vim.g.vsnip_snippet_dir = "/home/ph/.config/nvim/vsnip"
      vim.cmd("autocmd BufEnter * lua require'completion'.on_attach()")
      vim.api.nvim_set_keymap('i', "<Tab>", "v:lua.Com_Tab()" , {noremap=true, silent=true, expr=true})
      vim.api.nvim_set_keymap('i', "<S-Tab>", "v:lua.Com_STab()" , {noremap=true, silent=true, expr=true})
      local lspconfig = require'lspconfig'
      require'lspconfig'.clangd.setup{
        on_attach = require'completion'.on_attach,
      }
      require'lspconfig'.gopls.setup{
        cmd = {"gopls","--remote=auto"},
        on_attach = require'completion'.on_attach,
        filetypes = { "go", "gomod" },
        root_dir = lspconfig.util.root_pattern("go.mod", ".git")
      }
      require'lspconfig'.sumneko_lua.setup{
        cmd = {"lua-language-server", "-E", "/home/ph/.cache/yay/lua-language-server-git/src/lua-language-server-git/main.lua"},
        on_attach = require'completion'.on_attach
      }
      require'lspconfig'.pyls.setup{
        on_attach=require'completion'.on_attach
      }
      require'lspconfig'.cssls.setup{
        on_attach=require'completion'.on_attach
      }
      require'lspconfig'.tsserver.setup{
        on_attach=require'completion'.on_attach,
        root_dir = vim.loop.cwd
      }
      require'lspconfig'.vimls.setup{
        on_attach=require'completion'.on_attach,
      }
      vim.g.completion_chain_complete_list = {
        default ={
          {complete_items={'snippet',  'path', 'lsp', 'buffers'}},
          {mode='<c-p>'},
          {mode='<c-n>'}
        }
      }
    end,
    requires = {
      {'steelsojka/completion-buffers', opt=true},
      {'hrsh7th/vim-vsnip', opt=true,requires = {'hrsh7th/vim-vsnip-integ', opt=true}}
    },
  }

  use{
    'tyru/caw.vim',
    keys = {',c'},
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap('n', ',c', '<Plug>(caw:prefix)', {noremap=false, silent=true})
      vim.api.nvim_set_keymap('x', ',c', '<Plug>(caw:prefix)', {noremap=false, silent=true})
    end,
  }
  use {
    'mg979/vim-visual-multi',
    keys = {"<C-d>", "<C-d>", "<C-Down>", "<C-Up>"},
    config = function()
      vim.api.nvim_exec(
      [[
      let g:VM_maps                       = {}
      let g:VM_maps['Find Under']         = '<C-d>'
      let g:VM_maps['Find Subword Under'] = '<C-d>'
      let g:VM_maps["Add Cursor Down"]    = '<C-Down>'
      let g:VM_maps["Add Cursor Up"]      = '<C-Up>'
      ]], true
      )
    end,
  }
  use {
    '/home/ph/Github/nvim-hybrid',
    config = function()
      vim.cmd('colorscheme nvim-hybrid')
    end
  }
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    -- your statusline
    config = function()
      require('linux.statusline')
    end,
    -- some optional icons
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {
    '/home/ph/Github/rim.nvim',
  }
end)
