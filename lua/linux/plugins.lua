local execute = vim.api.nvim_command
local fn = vim.fn
local execu_install = false local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execu_install = true
end
vim.cmd [[packadd packer.nvim]]
local use = require("packer").use
require("packer").init(
{
  clone_timeout = 30,
  transitive_opt = true,
})
require("packer").startup(
function()
  use {
    "wbthomason/packer.nvim",
    opt = true
  }
  use {
    "lilydjwg/fcitx.vim",
    event= {"InsertEnter *"}
  }
  use {
    "tpope/vim-surround",
    keys = {'c', 'd', 'y'}
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    event = {"BufRead *"},
    run = "TSUpdate",
    config = function()
      require "nvim-treesitter.configs".setup {
        ensure_installed = "maintained",
        highlight = {
          enable = true,
          disable = {"rust"}
        }
      }
    end
  }
  use {
    "hardcoreplayers/dashboard-nvim",
    setup = function()
      local vim = vim
      vim.g.dashboard_default_executive = "telescope"
      vim.g.dashboard_preview_command = "cat"
      vim.g.dashboard_preview_pipeline = "lolcat"
      vim.g.dashboard_preview_file = vim.fn["getenv"]("HOME") .. "/.config/nvim/static/neovim.txt"
      vim.g.dashboard_preview_file_height = 8
      vim.g.dashboard_preview_file_width = 50
      -- vim.cmd("autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2")
      vim.api.nvim_set_keymap("n", "<C-f>s", ":<C-u>SessionSave<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<C-f>l", ":<C-u>SessionLoad<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<C-f>h", ":DashboardFindHistory<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<C-f>f", ":DashboardFindFile<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n","<C-f>c",":DashboardChangeColorscheme<CR>",{noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<C-f>m", ":DashboardJumpMark<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<C-f>w", ":DashboardFindWord<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "<C-f>n", ":DashboardNewFile<CR>", {noremap = true, silent = true})
      vim.g.dashboard_custom_shortcut = {
        last_session = "<Ctrl-f>l",
        find_history = "<Ctrl-f>h",
        find_file = "<Ctrl-f>f",
        new_file = "<Ctrl-f>n",
        change_colorscheme = "<Ctrl-f>c",
        find_word = "<Ctrl-f>w",
        book_marks = "<Ctrl-f>b"
      }
    end
  }
  use {
    "rhysd/accelerated-jk",
    keys = {{"n", "j"}, {"n", "k"}},
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap("n","j","<Plug>(accelerated_jk_gj_position)",{noremap = false, silent = true})
      vim.api.nvim_set_keymap("n","k","<Plug>(accelerated_jk_gk_position)",{noremap = false, silent = true})
    end
  }
  use {
    "gcmt/wildfire.vim",
    keys = {"n", "<CR>"}
  }
  use {
    "junegunn/vim-easy-align",
    keys = {{"v", "ga"}, {"n", "ga"}},
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {silent = true})
      vim.api.nvim_set_keymap("v", "ga", "<Plug>(EasyAlign)", {silent = true})
    end
  }
  use {
    "skywind3000/asynctasks.vim",
    requires = {"skywind3000/asyncrun.vim", keys={"R"}},
    opt=true,
    keys = {"R"},
    config = function()
      local vim = vim
      vim.g.asyncrun_open = 9
      vim.g.asynctasks_rtp_config = "asynctasks.ini"
      vim.api.nvim_set_keymap("n", "R", ":lua StartR()<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n", "B", ":AsyncTask file-build<CR>", {noremap = true, silent = true})
    end
  }
  use {
    "dart-lang/dart-vim-plugin",
    opt = true
  }
  use {
    "dhruvasagar/vim-table-mode",
    opt = true,
    ft = {"markdown"}
  }
  use {
    "p00f/nvim-ts-rainbow",
    event = "BufReadPost *",
    config = function()
      require "nvim-treesitter.configs".setup {
        rainbow = {
          enable = true
        }
      }
    end
  }

  use {
    "norcalli/nvim-colorizer.lua",
    config = function()
      vim.o.termguicolors = true
      require "colorizer".setup()
    end
  }
  use {
    "jreybert/vimagit",
    opt = true,
    cmd = {"Magit", "MagitOnly"}
  }
  use {
    "npxbr/glow.nvim",
    cmd = {"Glow"}
  }
  use {
    "liuchengxu/vista.vim",
    cmd = {"Vista"},
    config = function()
      local vim = vim
      vim.g.vista_icon_indent = {"╰─▸ ", "├─▸ "}
      vim.cmd("let g:vista#renderer#enable_icon = 1")
    end
  }
  use {
    "nvim-telescope/telescope.nvim",
    cmd = {"Telescope"},
    requires = {{"nvim-lua/popup.nvim", opt=true}, {"nvim-lua/plenary.nvim", opt=true}},
    config = function()
      vim.cmd [[packadd popup.nvim]]
      vim.cmd [[packadd plenary.nvim]]
      require('telescope').setup{
        defaults = {
          prompt_position = "top",
          prompt_prefix = " 🍭",
        }
      }
    end
  }
  use {
    "voldikss/vim-translator",
    keys = {{"v", "<leader>tt"}, {"n", "<leader>tt"}},
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap("n", "<leader>tt", "<Plug>TranslateW", {noremap = false, silent = true})
      vim.api.nvim_set_keymap("v", "<leader>tt", "<Plug>TranslateW", {noremap = false, silent = true})
    end
  }
  use {
    "windwp/nvim-autopairs",
    config = function()
      require("nvim-autopairs").setup()
    end
  }
  use {
    "lewis6991/gitsigns.nvim",
    event = {"BufReadPre *"},
    requires = {'nvim-lua/plenary.nvim', opt=true},
    config = function()
      vim.cmd [[packadd plenary.nvim]]
      require("gitsigns").setup {
        signs = {
          add = {hl = "DiffAdd", text = "▊"},
          change = {hl = "DiffChange", text = "▊"},
          delete = {hl = "DiffDelete", text = "▊"},
          topdelete = {hl = "DiffDelete", text = "▊"},
          changedelete = {hl = "DiffDelete", text = "▊"}
        }
      }
    end
  }
  use {
    "kyazdani42/nvim-tree.lua",
    opt=true,
    keys = {"<C-n>"},
    requires = {"kyazdani42/nvim-web-devicons"},
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", {noremap = true, silent = true})
      vim.g.nvim_tree_indet_markers = 1
      vim.g.nvim_tree_auto_close = 1
      vim.g.nvim_tree_git_hl = 1
      vim.g.nvim_tree_follow = 1
      vim.g.nvim_tree_bindings = {
        edit = {"o", "<CR>"},
        rename = {"r"},
        remove = {"dD"},
        cut = {"dd"},
        close = {"q"},
        paste = {"p"},
        dir_up = {"u"},
        preview = {"<TAB>"},
        copy = {"copy"},
        create = {"cn"}
      }
    end,
  }
  use {
    "tyru/caw.vim",
    keys = {",c"},
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap("n", ",c", "<Plug>(caw:prefix)", {noremap = false, silent = true})
      vim.api.nvim_set_keymap("x", ",c", "<Plug>(caw:prefix)", {noremap = false, silent = true})
    end
  }
  use {
    "/home/ph/Github/nvim-hybrid",
    requires = {'ms-jpq/neovim-async-tutorial'},
    config = function()
      vim.cmd("colorscheme nvim-hybrid")
    end
  }
  use {
    "glepnir/lspsaga.nvim",
    keys = {'K', "<leader>ca", "<leader>rn", "[g", "]g", "gd", "gp"},
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap("n","<leader>rn",":lua require('lspsaga.rename').rename()<CR>",{noremap = true, silent = true})
      vim.api.nvim_set_keymap("n","gp",":lua require'lspsaga.provider'.preview_definition()<CR>",{noremap = true, silent = true})
      vim.api.nvim_set_keymap("n","[g",":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>",{noremap = true, silent = true})
      vim.api.nvim_set_keymap("n","]g",":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>",{noremap = true, silent = true})
      vim.api.nvim_set_keymap("n","gd",":lua require'lspsaga.provider'.lsp_finder()<CR>",{noremap = true, silent = true}) 
      vim.api.nvim_set_keymap("n","<leader>ca",":lua require('lspsaga.codeaction').code_action()<CR>",{noremap = true, silent = true})
    end
  }
  use {
    "neovim/nvim-lspconfig",
    config = function()
      require("linux.lspconfig")
    end
  }
  use {
    "hrsh7th/nvim-compe",
    opt = true,
    event={"InsertEnter *"},
    requires = {{"hrsh7th/vim-vsnip-integ", opt=true}, {"hrsh7th/vim-vsnip", event={"BufReadPre *"}}},
    config = function()
      local vim = vim
      vim.o.completeopt = "menu,menuone,noselect"
      require "compe".setup {
        enabled = true,
        debug = false,
        min_length = 1,
        preselect = 'disable',
        allow_prefix_unmatch = false,
        source = {
          path = true,
          buffer = true,
          vsnip = true,
          nvim_lsp = true,
          nvim_lua = true,
          spell = true,
          tags = true,
          treesitter = true
        }
      }
      local t = function(str)
        return vim.api.nvim_replace_termcodes(str, true, true, true)
      end
      _G.tab_complete = function()
        if vim.fn.pumvisible() == 1 then
          return t "<C-n>"
        else
          return t "<Tab>"
        end
      end
      _G.s_tab_complete = function()
        if vim.fn.pumvisible() == 1 then
          return t "<C-p>"
        else
          return t "<S-Tab>"
        end
      end

      vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
      vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
      vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
      vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
      vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {expr = true, noremap = true})
    end
  }
  use {
    "ojroques/nvim-hardline",
    event = {'VimEnter *'},
    config = function()
      require("hardline").setup {
        bufferline = false,
        theme = "nord",
        sections = {
          {class = "mode", item = require("hardline.parts.mode").get_item},
          {class = "error", item = require("hardline.parts.lsp").get_error},
          {class = "warning", item = require("hardline.parts.lsp").get_warning},
          {class = "med", item = "%="},
          {class = "high", item = require("hardline.parts.cwd").get_item, hide = 80},
          {class = "high", item = require("hardline.parts.filename").get_item, hide = 80},
          {class = "low", item = require("hardline.parts.filetype").get_item, hide = 80},
          {class = "mode", item = require("hardline.parts.line").get_item}
        }
      }
    end
  }
  use {
    'akinsho/flutter-tools.nvim',
    ft={"dart"},
    config = function ()
    require("flutter-tools").setup {
      closing_tags = {
        highlight = "ErrorMsg",
        prefix = ">"
      },
      dev_log = {
        open_cmd = "tabedit",
      },
      outline = {
        open_cmd = "30vnew",
      },
    }
    end
  }
  use {
    'akinsho/nvim-bufferline.lua',
    event = {'VimEnter *'},
    requires = {'kyazdani42/nvim-web-devicons'},
    config = function ()
    require'bufferline'.setup{
      options = {
        numbers="ordinal",
        number_style="",
        mappings=true,
        buffer_close_icon = " ",
        separator_style = 'slant',
        always_show_bufferline=false
      }
    }
    end
  }
  use {
    'itchyny/vim-cursorword',
    event = {'BufReadPost *'}
  }
  use {
    'skywind3000/vim-rt-format',
    event = {'InsertEnter *'},
    config = function ()
      vim.g.rtf_on_insert_leave = 1
    end
  }
  use {
    'ttys3/nvim-blamer.lua'
  }
end)

if execu_install == true then
  vim.cmd(":PackerSync")
end
