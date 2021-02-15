local execute = vim.api.nvim_command
local fn = vim.fn
local http_prefix = "https://github.com.cnpmjs.org/"
local execu_install = false
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execu_install = true
end
vim.cmd [[packadd packer.nvim]]
local use = require("packer").use
local useb = function(list)
  if type(list) == "string" then
    list = http_prefix .. list
    return usep(list)
  elseif type(list) == "table" then
    list[1] = http_prefix .. list[1]
    if type(list["requires"]) == "string" then
      list["requires"] = http_prefix .. list["requires"]
    elseif type(list["requires"]) == "table" then
      if type(list["requires"][1]) == "string" then
        list["requires"][1] = http_prefix .. list["requires"][1]
      elseif list["requires"][1] == "table" then
        for k, _ in pairs(list["requires"]) do
          list["requires"][k][1] = http_prefix .. list["requires"][k][1]
        end
      end
    end
    return usep(list)
  end
end
require("packer").init(
{
  clone_timeout = 30
}
)
require("packer").startup(
function()
  use {
    "PHSix/packer.nvim",
    opt = true
  }
  use {
    "lilydjwg/fcitx.vim"
  }
  use {
    "tpope/vim-surround"
  }
  use {
    "nvim-treesitter/nvim-treesitter",
    run = "TSUpdate",
    config = function()
      require "nvim-treesitter.configs".setup {
        ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = {"rust"} -- list of language that will be disabled
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
      vim.api.nvim_set_keymap(
      "n",
      "<C-f>c",
      ":DashboardChangeColorscheme<CR>",
      {noremap = true, silent = true}
      )
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
      vim.api.nvim_set_keymap(
      "n",
      "j",
      "<Plug>(accelerated_jk_gj_position)",
      {noremap = false, silent = true}
      )
      vim.api.nvim_set_keymap(
      "n",
      "k",
      "<Plug>(accelerated_jk_gk_position)",
      {noremap = false, silent = true}
      )
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
    requires = {"skywind3000/asyncrun.vim", opt = true},
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
    requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap("n", "<A-d>j", ":Buffers<CR>", {noremap = true, silent = true})
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
    requires = {
      "nvim-lua/plenary.nvim"
    },
    config = function()
      require("gitsigns").setup {
        signs = {
          delete = {hl = "DiffDelete", text = "│"},
          topdelete = {hl = "DiffDelete", text = "│"},
          changedelete = {hl = "DiffDelete", text = "│"}
        }
      }
    end
  }
  use {
    "kyazdani42/nvim-tree.lua",
    key = {{"<C-n>"}},
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
    requires = {"kyazdani42/nvim-web-devicons", opt = true}
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
    "mg979/vim-visual-multi",
    keys = {"<C-d>", "<C-d>", "<C-Down>", "<C-Up>"},
    config = function()
      vim.api.nvim_exec(
      [[
      let g:VM_maps                       = {}
      let g:VM_maps['Find Under']         = '<C-d>'
      let g:VM_maps['Find Subword Under'] = '<C-d>'
      let g:VM_maps["Add Cursor Down"]    = '<C-Down>'
      let g:VM_maps["Add Cursor Up"]      = '<C-Up>'
      ]],
      true
      )
    end
  }
  use {
    "/home/ph/Github/nvim-hybrid",
    config = function()
      vim.cmd("colorscheme nvim-hybrid")
    end
  }
  use {
    "glepnir/lspsaga.nvim",
    config = function()
      local vim = vim
      vim.api.nvim_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
      vim.api.nvim_set_keymap(
      "n",
      "<leader>rn",
      ":lua require('lspsaga.rename').rename()<CR>",
      {noremap = true, silent = true}
      )
      vim.api.nvim_set_keymap(
      "n",
      "gp",
      ":lua require'lspsaga.provider'.preview_definition()<CR>",
      {noremap = true, silent = true}
      )
      vim.api.nvim_set_keymap(
      "n",
      "[g",
      ":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>",
      {noremap = true, silent = true}
      )
      vim.api.nvim_set_keymap(
      "n",
      "]g",
      ":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>",
      {noremap = true, silent = true}
      )
      vim.api.nvim_set_keymap(
      "n",
      "gd",
      ":lua require'lspsaga.provider'.lsp_finder()<CR>",
      {noremap = true, silent = true}
      )
      vim.api.nvim_set_keymap(
      "n",
      "<leader>ca",
      ":lua require('lspsaga.codeaction').code_action()<CR>",
      {noremap = true, silent = true}
      )
    end
  }
  use {
    "neovim/nvim-lspconfig",
    config = function()
      local vim = vim
      vim.fn["sign_define"](
      "LspDiagnosticsSignError",
      {
        text = " ▊",
        texthl = "LspDiagnosticsSignError",
        numhl = "LspDiagnosticsSignError"
      }
      )
      vim.fn["sign_define"](
      "LspDiagnosticsSignWarning",
      {
        text = " ▊",
        texthl = "LspDiagnosticsSignWarning",
        numhl = "LspDiagnosticsSignWarning"
      }
      )
      vim.fn["sign_define"](
      "LspDiagnosticsSignHint",
      {
        text = " ▊",
        texthl = "LspDiagnosticsSignHint",
        numhl = "LspDiagnosticsSignHint"
      }
      )
      vim.fn["sign_define"](
      "LspDiagnosticsSignInformation",
      {
        text = " ▊",
        texthl = "LspDiagnosticsSignInformation",
        numhl = "LspDiagnosticsSignInformation"
      }
      )
      require("linux.lspconfig")
    end
  }
  use {
    "hrsh7th/nvim-compe",
    requires = {{"SirVer/ultisnips", opt = true}, {"hrsh7th/vim-vsnip-integ"}, {"hrsh7th/vim-vsnip"}},
    config = function()
      local vim = vim
      vim.o.completeopt = "menu,menuone,noselect"
      require "compe".setup {
        enabled = true,
        debug = false,
        min_length = 1,
        -- preselect = 'always';
        allow_prefix_unmatch = false,
        source = {
          path = true,
          buffer = true,
          calc = true,
          vsnip = true,
          nvim_lsp = true,
          nvim_lua = true,
          spell = true,
          tags = true,
          snippets_nvim = true
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
    "glacambre/firenvim",
    run = "call firenvim#install(0)"
  }
  use {
    "ojroques/nvim-hardline",
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
    "/home/ph/Desktop/Project/simple-tabline"
  }
end)

if execu_install == true then
  vim.cmd(":PackerInstall")
end
