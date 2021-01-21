local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'

if fn.empty(fn.glob(install_path)) > 0 then
  execute('!git clone https://github.com.cnpmjs.org/PHSix/packer.nvim '..install_path)
  execute(':PackerInstall')
end
vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}
  use {'lilydjwg/fcitx.vim'}
  use {'vimwiki/vimwiki', opt=true}
  use {
    'glepnir/galaxyline.nvim',
    branch = 'main',
    config = function() require'linux/eviline' end,
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }
  use {'tpope/vim-surround'}
  use {
    'hardcoreplayers/dashboard-nvim',
    setup = function()
      vim.g.dashboard_default_executive = 'fzf'
      vim.g.dashboard_custom_header = {
        "███╗   ██╗███████╗ ██████╗ ██╗   ██╗██╗███╗   ███╗",
        "████╗  ██║██╔════╝██╔═══██╗██║   ██║██║████╗ ████║",
        "██╔██╗ ██║█████╗  ██║   ██║██║   ██║██║██╔████╔██║",
        "██║╚██╗██║██╔══╝  ██║   ██║╚██╗ ██╔╝██║██║╚██╔╝██║",
        "██║ ╚████║███████╗╚██████╔╝ ╚████╔╝ ██║██║ ╚═╝ ██║",
        "╚═╝  ╚═══╝╚══════╝ ╚═════╝   ╚═══╝  ╚═╝╚═╝     ╚═╝",
      }
      vim.g.dashboard_preview_pipeline = "lolcat"
      vim.cmd("autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2")
      vim.api.nvim_set_keymap("n", "<C-f>s", ":<C-u>SessionSave<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>l", ":<C-u>SessionLoad<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>h", ":DashboardFindHistory<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>f", ":DashboardFindFile<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>c", ":DashboardChangeColorscheme<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>w", ":DashboardJumpMark<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>b", ":DashboardJumpMark<CR>", {noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "<C-f>n", ":DashboardNewFile<CR>", {noremap=true, silent=true})
    end,
  }
  use {
    'junegunn/fzf.vim',
    config = function()
    end
  }
  use {
    'rafi/awesome-vim-colorschemes',
    config = function()
      vim.cmd("colorscheme deus")
    end
  }
  use {
    'rhysd/accelerated-jk',
    config = function()
      vim.api.nvim_set_keymap("n", "j", "<Plug>(accelerated_jk_gj_position)", {noremap=false, silent=true})
      vim.api.nvim_set_keymap("n", "k", "<Plug>(accelerated_jk_gk_position)", {noremap=false, silent=true})
    end
  }
  use {
    'akinsho/nvim-bufferline.lua',
    config = function()
      require'bufferline'.setup()
    end,
    requires = {'kyazdani42/nvim-web-devicons', opt=true}
  }
  use {
    'preservim/nerdcommenter',
    config = function()
      vim.api.nvim_set_keymap("n", ",cc", "<leader>cc", {noremap=false, silent=true})
      vim.api.nvim_set_keymap("v", ",cc", "<leader>cc", {noremap=false, silent=true})
      vim.api.nvim_set_keymap("n", ",cu", "<leader>cu", {noremap=false, silent=true})
      vim.api.nvim_set_keymap("v", ",cu", "<leader>cu", {noremap=false, silent=true})
    end
  }
  use {'gcmt/wildfire.vim'}
  use {
    'francoiscabrol/ranger.vim',
    requires = {'rbgrouleff/bclose.vim', opt=true},
    config = function()
      vim.api.nvim_set_keymap("n", "<leader>f", ":Ranger<CR>", {noremap=false, silent=true})
    end,
  }
  use {'sheerun/vim-polyglot'}
  use {
    'junegunn/vim-easy-align',
    config = function()
      vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {silent=true})
      vim.api.nvim_set_keymap("v", "ga", "<Plug>(EasyAlign)", {silent=true})
    end
  }
  use {
    'Chiel92/vim-autoformat',
    config = function()
      vim.api.nvim_set_keymap("n", "F", ":Autoformat<CR>", {noremap=true, silent=true})
    end
  }
  use {
    'skywind3000/asynctasks.vim',
    requires = {'skywind3000/asyncrun.vim'},
    config = function()
      vim.g.asyncrun_open = 9
      vim.g.asynctasks_rtp_config = "asynctasks.ini"
      vim.api.nvim_set_keymap("n", "R", ":AsyncTask file-run<CR>",   { noremap=true, silent=true})
      vim.api.nvim_set_keymap("n", "B", ":AsyncTask file-build<CR>", { noremap=true, silent=true})
    end,
  }
  use {'dart-lang/dart-vim-plugin'}
  use {'dhruvasagar/vim-table-mode'}
  use {
    'numirias/semshi',
    opt=true
  }
  use {
    'kien/rainbow_parentheses.vim',
    config = function()
      vim.g.rbpt_max = 16
      vim.g.rbpt_loadcmd_toggle = 0
      vim.cmd("au VimEnter * RainbowParenthesesToggle")
      vim.cmd("au Syntax * RainbowParenthesesLoadRound")
      vim.cmd("au Syntax * RainbowParenthesesLoadSquare")
      vim.cmd("au Syntax * RainbowParenthesesLoadBraces")
    end
  }
  use {
    'mg979/vim-visual-multi',
    config = function()
      vim.api.nvim_exec(
        [[
        let g:VM_maps                       = {}
        let g:VM_maps['Find Under']         = '<C-d>'
        let g:VM_maps['Find Subword Under'] = '<C-d>'
        let g:VM_maps["Add Cursor Down"]    = '<C-Down>'
        let g:VM_maps["Add Cursor Up"]      = '<C-Up>'
        ]], true)
      end
    }
    use {
      "glepnir/lspsaga.nvim"
    }
    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        require'colorizer'.setup()
      end
    }
    use {
      'neoclide/coc.nvim',
      branch = 'release',
      config = function()
        vim.g.coc_global_extensions = {
          'coc-json',
          'coc-pairs',
          'coc-highlight',
          'coc-lists',
          'coc-yank',
          'coc-actions',
          'coc-marketplace',
          'coc-diagnostic',
          'coc-vimlsp',
          'coc-translator',
          'coc-git',
          'coc-snippets',

          'coc-emmet',
          'coc-html',
          'coc-css',
          'coc-tsserver',
          'coc-yaml',
          'coc-xml',
          'coc-sql',
          'coc-cmake',
          'coc-clangd',
          'coc-vetur',
          'coc-flutter-tools',
          'coc-template',
          'coc-sh',
          'coc-todolist',
          'coc-markdownlint',
          'coc-python',
          'coc-rainbow-fart'
        }
        vim.api.nvim_set_keymap("n", "gd", "<Plug>(coc-definition)", {noremap=false,silent=true})
        vim.api.nvim_set_keymap("n", "<leader>rn", "<Plug>(coc-rename)", {noremap=false, silent=true})
      end
    }
    use {
      'antoinemadec/coc-fzf',
      config = function()
        vim.g.coc_fzf_preview_toggle_key = '?'
        vim.g.coc_fzf_preview = ''
        vim.g.fzf_lazyout = {
          window = {
            width = 0.9,
            height = 0.6
          }
        }

        --vim.call.["coc_fzf#common#add_list_source"]({'fzf-buffers', 'display open buffers', 'Buffers'})
      end
    }
    use {
      'fatih/vim-go',
      config = function()
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
      'Shougo/defx.nvim',
      opt=true,
      requires = {'kristijanhusak/defx-icons', opt=true},
      cmd = {"Defx"}
    }
    use {
      'jreybert/vimagit',
      opt=true,
      cmd = {"Magit", "MagitOnly"}
    }
  end)


