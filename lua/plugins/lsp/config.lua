local config = {}

function config.compe()
  vim.cmd [[packadd lspkind-nvim]]
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
        Class = "",
        Interface = "ﰮ",
        Module = "",
        Property = "",
        Unit = "",
        Value = "",
        Enum = "E",
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
  local compe_config = {
    enabled = true,
    debug = false,
    min_length = 1,
    preselect = "always",
    allow_prefix_unmatch = false,
    documentation = {
      border = "single",
      winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
      max_width = 120,
      min_width = 60,
      max_height = math.floor(vim.o.lines * 0.3),
      min_height = 1
    },
    source = {
      vsnip = {
        priority = 6
      },
      emmet = {
        priority = 6
      },
      nvim_lsp = {
        priority = 5
      },
      path = {
        priority = 4
      },
      nvim_lua = {
        priority = 3
      },
      buffer = {
        priority = 2
      },
      treesitter = {
        priority = 1
      },
      zsh = true
    }
  }
  require "compe".setup(compe_config)
  function _G.Compe_toggle(sign)
    local compe = require("compe")
    if sign == 0 then
      compe.setup({enabled = false})
      return
    elseif sign == 1 then
      compe.setup(compe_config)
      return
    end
    if require("compe.config")._config.enabled then
      compe.setup({enabled = false})
    else
      compe.setup(compe_config)
    end
  end
  vim.cmd([[command! CompeToggle lua Compe_toggle()]])
end

function config.flutter()
  vim.cmd [[packadd plenary.nvim]]
  -- local capabilities = vim.lsp.protocol.make_client_capabilities()
  -- capabilities.textDocument.completion.completionItem.snippetSupport = true
  require("flutter-tools").setup {
    experimental = {
      -- map of feature flags
      lsp_derive_paths = true -- experimental: Attempt to find the user's flutter SDK
    },
    flutter_path = "/opt/flutter/bin/flutter",
    -- flutter_lookup_cmd = "dirname $(which flutter)",
    closing_tags = {
      highlight = "FlutterCloseTag",
      prefix = "// "
    },
    -- dev_log = {
    --   open_cmd = "30vnew"
    -- },
    outline = {
      open_cmd = "botright 45vnew"
    },
    lsp = {
      capabilities = {},
      enableSdkFormatter = true
    },
    widget_guides = {
      enabled = true
    }
  }
end

function config.vsnip()
  vim.g.vsnip_snippet_dir = os.getenv("HOME") .. "/.config/nvim/vsnip"
end
function config.lspsaga()
  -- ▊
  local lspsaga = require "lspsaga"
  lspsaga.init_lsp_saga(
    {
      error_sign = "▊",
      warn_sign = "▊",
      hint_sign = "▊",
      infor_sign = "▊",
      code_action_keys = {quit = "<ESC>", exec = "<CR>"},
      rename_action_keys = {quit = "<ESC>", exec = "<CR>"}
    }
  )
end
function config.lsp_signature()
end
function config.lsp_trouble()
  require("trouble").setup {
    auto_open = true,
    auto_close = true
  }
end
return config
