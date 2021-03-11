local config = {}
function config.compe()
  vim.cmd [[packadd lspkind-nvim]]
  vim.cmd [[packadd compe-tabnine]]
  require("lspkind").init(
    {
      with_text = true,
      symbol_map = {
        TN = "T",
        Text = "",
        Method = "ƒ",
        Function = "",
        Constructor = "",
        Variable = "",
        Class = "",
        Interface = "ﰮ",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "了",
        Keyword = "",
        Snippet = "﬌",
        Color = "",
        File = "",
        Folder = "",
        EnumMember = "",
        Constant = "",
        Struct = ""
      }
    }
  )
  vim.o.completeopt = "menu,menuone,noselect"
  require "compe".setup {
    enabled = true,
    debug = false,
    min_length = 1,
    preselect = "disable",
    allow_prefix_unmatch = false,
    source = {
      path = true,
      buffer = true,
      vsnip = true,
      nvim_lsp = true,
      nvim_lua = true,
      spell = true,
      tags = true,
      treesitter = true,
      tabnine = {
        priority = 99,
        max_num_results = 2
      },
      zsh = true
    }
  }
end

function config.flutter()
  require("flutter-tools").setup {
    closing_tags = {
      highlight = "FlutterCloseTag",
      prefix = "// "
    },
    dev_log = {
      open_cmd = "30vnew"
    },
    outline = {
      open_cmd = "botright 45vnew"
    },
    lsp = {
    }
  }
end

function config.vsnip()
  vim.g.vsnip_snippet_dir = os.getenv("HOME") .. "/.config/nvim/vsnip"
end
function config.lspsaga()
  -- ▊
  local lspsaga = require 'lspsaga'
  lspsaga.init_lsp_saga({
    error_sign = "▊",
    warn_sign = "▊",
    hint_sign = "▊",
    infor_sign = "▊",
    code_action_keys = { quit = "<ESC>",exec = "<CR>" },
    rename_action_keys = {quit = "<ESC>", exec = "<CR>"},
  })
end
return config


