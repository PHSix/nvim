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
  require "compe".setup {
    enabled = true,
    debug = false,
    min_length = 1,
    preselect = "disable",
    allow_prefix_unmatch = false,
    source = {
      path = {
        priority = 7,
      },
      vsnip = {
        priority = 6,
      },
      nvim_lsp = {
        priority = 5,
      },
      buffer = {
        priority = 2,
      },
      nvim_lua = {
        priority = 3,
      },
      spell = {
        priority = 2,
      },
      treesitter = {
        priority = 1,
      },
      zsh = true
    }
  }
end

function config.flutter()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
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
      capabilities = capabilities,
      enableSdkFormatter = true
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
      code_action_keys = {quit = "<ESC>", exec = "o"},
      rename_action_keys = {quit = "<ESC>", exec = "<CR>"}
    }
  )
end
-- function config.lsputils()
--   vim.cmd [[packadd popfix]]
--   vim.lsp.handlers['textDocument/documentSymbol'] = require'lsputil.symbols'.document_handler
--   vim.g.lsp_utils_symbols_opts = {
-- 	height = 24,
-- 	mode = 'editor',
-- 	preview = {
-- 		title = 'Symbols Preview',
-- 		border = true,
--     border_chars = {
--  	TOP_LEFT = '┌',
--  	TOP_RIGHT = '┐',
--  	MID_HORIZONTAL = '─',
--  	MID_VERTICAL = '│',
--  	BOTTOM_LEFT = '└',
--  	BOTTOM_RIGHT = '┘',
--  }
-- 	},
-- 	prompt = {},
-- }
-- end
return config
