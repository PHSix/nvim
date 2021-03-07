  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  local lspconfig = require "lspconfig"
  --
  -- c family
  --
  lspconfig.clangd.setup {
    capabilities = capabilities
  }

  lspconfig.cmake.setup {
    capabilities = capabilities
  }

  --
  -- golang
  --
  lspconfig.gopls.setup {
    cmd = {"gopls", "--remote=auto"},
    capabilities = capabilities,
    init_options = {
      usePlaceholders = true,
      completeUnimported = true
    },
    root_dir = vim.loop.cwd
  }

  --
  -- lua
  --
  local nvim_lua_cache_path = vim.fn["getenv"]("HOME") .. "/.cache/nvim/lua-language-server"
  lspconfig.sumneko_lua.setup {
    cmd = {nvim_lua_cache_path .. "/bin/Linux/lua-language-server", "-E", nvim_lua_cache_path .. "/main.lua"},
    settings = {
      Lua = {
        diagnostics = {
          enable = true,
          globals = {"vim", "packer_plugins"}
        },
        runtime = {version = "LuaJIT"},
        workspace = {
          library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true}, {})
        }
      }
    }
  }

  --
  -- python
  --
  lspconfig.pyright.setup {
    capabilities = capabilities
  }

  --
  -- web developer
  --
  lspconfig.cssls.setup {
    capabilities = capabilities
  }
  lspconfig.tsserver.setup {
    capabilities = capabilities,
    root_dir = vim.loop.cwd
  }
  lspconfig.jsonls.setup {
    capabilities = capabilities,
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({}, {0, 0}, {vim.fn.line("$"), 0})
        end
      }
    }
  }
  lspconfig.html.setup {
    capabilities = capabilities
  }

  local configs = require "lspconfig/configs"

  configs.emmet_ls = {
    default_config = {
      cmd = {"emmet-ls", "--stdio"},
      filetypes = {"html", "css", "scss"},
      root_dir = function()
        return vim.loop.cwd()
      end,
      settings = {}
    }
  }

  lspconfig.emmet_ls.setup {
    capabilities = capabilities
  }
  lspconfig.vuels.setup {}

  --
  -- vimL
  --
  lspconfig.vimls.setup {
    capabilities = capabilities
  }

  --
  -- bash shell
  --
  lspconfig.bashls.setup {
    capabilities = capabilities
  }

  --
  -- rust
  --
  lspconfig.rust_analyzer.setup {
    capabilities = capabilities
  }
  --
  -- dart  flutter
  --
  -- lsp.dartls.setup {
  --   cmd = {"dart", "/opt/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp"},
  --   closingLabels = true,
  --   outline = true,
  --   flutterOutline = true
  -- }
