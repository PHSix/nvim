local api = vim.api
local lspconfig = require "lspconfig"

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

function _G.reload_lsp()
  vim.lsp.stop_client(vim.lsp.get_active_clients())
  vim.cmd [[edit]]
end

function _G.open_lsp_log()
  local path = vim.lsp.get_log_path()
  vim.cmd("edit " .. path)
end
vim.cmd("command! -nargs=0 LspLog call v:lua.open_lsp_log()")
vim.cmd("command! -nargs=0 LspRestart call v:lua.reload_lsp()")

vim.lsp.handlers["textDocument/publishDiagnostics"] =
  vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics,
  {
    -- Enable underline, use default values
    underline = true,
    -- Enable virtual text, override spacing to 4
    virtual_text = {
      spacing = 2,
      severity_limit = "Warning"
      -- prefix = "<<",
    },
    signs = {
      enable = true,
      priority = 20
    },
    -- Disable a feature
    update_in_insert = false
  }
)

local enhance_attach = function(_, bufnr)
  api.nvim_buf_set_option(bufnr, "omnifunc", "v:lua.vim.lsp.omnifunc")
  vim.cmd [[packadd lsp_signature.nvim]]
  require "lsp_signature".on_attach()
end

lspconfig.gopls.setup {
  cmd = {"gopls", "--remote=auto"},
  on_attach = enhance_attach,
  capabilities = capabilities,
  init_options = {
    usePlaceholders = true,
    completeUnimported = true
  }
}

lspconfig.tsserver.setup {
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = false
    enhance_attach(client)
  end
}

lspconfig.clangd.setup {
  cmd = {
    "clangd",
    "--background-index",
    "--suggest-missing-includes",
    "--clang-tidy",
    "--header-insertion=iwyu"
  }
}

lspconfig.rust_analyzer.setup {
  capabilities = capabilities
}

lspconfig.sumneko_lua.setup {
  -- cmd = {nvim_lua_cache_path .. "/bin/Linux/lua-language-server", "-E", nvim_lua_cache_path .. "/main.lua"},
  cmd = {"lua-language-server", "-E", "/usr/share/lua-language-server/main.lua"},
  on_attach = enhance_attach,
  settings = {
    Lua = {
      diagnostics = {
        enable = true,
        globals = {"vim", "packer_plugins", "awesome"}
      },
      runtime = {version = "LuaJIT"},
      workspace = {
        -- library = vim.list_extend({[vim.fn.expand("$VIMRUNTIME/lua")] = true}, {})
        library = {
          ["/usr/share/awesome/lib"] = true,
          [vim.fn.expand("$VIMRUNTIME/lua")] = true
        }
      }
    }
  }
}
lspconfig.pyright.setup {
  capabilities = capabilities,
  settings = {
    python = {
      disableLanguageServices = false,
      disableOrganizeImports = false,
      analysis = {
        autoImportCompletions = true,
        autoSearchPaths = true,
        diagnosticMode = "openFilesOnly",
        stubPath = "typings",
        typeshedPaths = {},
        diagnosticSeverityOverrides = vim.empty_dict(),
        typeCheckingMode = "basic",
        useLibraryCodeForTypes = true,
        pythonPath = "python3"
      }
    }
  }
}
lspconfig.vuels.setup {
  capabilities = capabilities,
  filetypes = {"vue", "javascriptreact"},
  on_attach = function(client)
    client.resolved_capabilities.document_formatting = true
  end
  -- root_dir = vim.loop.cwd,
}
lspconfig.vimls.setup {
  capabilities = capabilities
}

lspconfig.bashls.setup {
  capabilities = capabilities
}

lspconfig.sqls.setup {
  on_attach = function(client)
    client.resolved_capabilities.execute_command = true

    require "sqls".setup {}
  end
}
