local config = {}

function config.compe()
  vim.cmd [[packadd lspkind-nvim]]
  vim.cmd [[packadd compe-tabnine]]
  vim.g.compe_tabnine_max_line = 1000
  vim.g.compe_tabnine_max_num_results = 2
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
      tabnine = true
    }
  }
end

config.flutter = function()
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
      capabilities = capabilities
    }
  }
end

return config
