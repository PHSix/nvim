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

function config.lsputils()
  vim.lsp.handlers["textDocument/codeAction"] = require "lsputil.codeAction".code_action_handler
  vim.lsp.handlers["textDocument/references"] = require "lsputil.locations".references_handler
  vim.lsp.handlers["textDocument/definition"] = require "lsputil.locations".definition_handler
  vim.lsp.handlers["textDocument/declaration"] = require "lsputil.locations".declaration_handler
  vim.lsp.handlers["textDocument/typeDefinition"] = require "lsputil.locations".typeDefinition_handler
  vim.lsp.handlers["textDocument/implementation"] = require "lsputil.locations".implementation_handler
  vim.lsp.handlers["textDocument/documentSymbol"] = require "lsputil.symbols".document_handler
  vim.lsp.handlers["workspace/symbol"] = require "lsputil.symbols".workspace_handler
  local map = vim.api.nvim_set_keymap
  map("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", {silent = true})
  map("n", "K", "<Cmd>lua vim.lsp.buf.hover()<CR>", {silent = true})
  map("n", "gd", "<Cmd>lua vim.lsp.buf.definition()<CR>", {silent = true})
  map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {silent = true})
  map("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", {silent = true})
  map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {silent = true})
  map("n", "<C-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", {silent = true})
  map("n", "gj", "<cmd>lua vim.lsp.diagnostic.goto_prev()<CR>", {silent = true})
  map("n", "gk", "<cmd>lua vim.lsp.diagnostic.goto_next()<CR>", {silent = true})
  map("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", {silent = true})
  local border_chars = {
    TOP_LEFT = "┌",
    TOP_RIGHT = "┐",
    MID_HORIZONTAL = "─",
    MID_VERTICAL = "│",
    BOTTOM_LEFT = "└",
    BOTTOM_RIGHT = "┘"
  }
  vim.g.lsp_utils_location_opts = {
    height = 24,
    mode = "editor",
    preview = {
      title = "Location Preview",
      border = true,
      border_chars = border_chars
    },
    keymaps = {
      n = {
        ["<C-n>"] = "j",
        ["<C-p>"] = "k"
      }
    }
  }
  vim.g.lsp_utils_symbols_opts = {
    height = 24,
    mode = "editor",
    preview = {
      title = "Symbols Preview",
      border = true,
      border_chars = border_chars
    },
    prompt = {}
  }
end
function config.rust()
  local opts = {
    tools = {
      -- rust-tools options
      -- automatically set inlay hints (type hints)
      -- There is an issue due to which the hints are not applied on the first
      -- opened file. For now, write to the file to trigger a reapplication of
      -- the hints or just run :RustSetInlayHints.
      -- default: true
      autoSetHints = true,
      -- whether to show hover actions inside the hover window
      -- this overrides the default hover handler so something like lspsaga.nvim's hover would be overriden by this
      -- default: true
      hover_with_actions = true,
      -- These apply to the default RustRunnables command
      runnables = {
        -- whether to use telescope for selection menu or not
        -- default: true
        use_telescope = true

        -- rest of the opts are forwarded to telescope
      },
      -- These apply to the default RustSetInlayHints command
      inlay_hints = {
        -- wheter to show parameter hints with the inlay hints or not
        -- default: true
        show_parameter_hints = true,
        -- prefix for parameter hints
        -- default: "<-"
        parameter_hints_prefix = "<- ",
        -- prefix for all the other hints (type, chaining)
        -- default: "=>"
        other_hints_prefix = "=> ",
        -- whether to align to the lenght of the longest line in the file
        max_len_align = false,
        -- padding from the left if max_len_align is true
        max_len_align_padding = 1,
        -- whether to align to the extreme right or not
        right_align = false,
        -- padding from the right if right_align is true
        right_align_padding = 7
      },
      hover_actions = {
        -- the border that is used for the hover window
        -- see vim.api.nvim_open_win()
        border = {
          {"╭", "FloatBorder"},
          {"─", "FloatBorder"},
          {"╮", "FloatBorder"},
          {"│", "FloatBorder"},
          {"╯", "FloatBorder"},
          {"─", "FloatBorder"},
          {"╰", "FloatBorder"},
          {"│", "FloatBorder"}
        },
        -- whether the hover action window gets automatically focused
        -- default: false
        auto_focus = false
      }
    },
    -- all the opts to send to nvim-lspconfig
    -- these override the defaults set by rust-tools.nvim
    -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
    server = {} -- rust-analyer options
  }

  require("rust-tools").setup(opts)
end
return config
