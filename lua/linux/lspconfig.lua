local vim = vim
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local lspconfig = require'lspconfig'
--
-- c family
--
require'lspconfig'.clangd.setup{

  capabilities = capabilities,
}

require'lspconfig'.cmake.setup{
  capabilities = capabilities,
}

--
-- golang
--
require'lspconfig'.gopls.setup{
  cmd = {"gopls","--remote=auto"},
  capabilities = capabilities,
  init_options = {
    usePlaceholders=true,
    completeUnimported=true,
  },
  root_dir = vim.loop.cwd
}

--
-- lua
--
require'lspconfig'.sumneko_lua.setup{
  capabilities = capabilities,
  cmd = {"lua-language-server", "-E", "/home/ph/.cache/yay/lua-language-server-git/src/lua-language-server-git/main.lua"},
}


--
-- python
--
require'lspconfig'.pyls.setup{
  capabilities = capabilities,
}


-- 
-- web developer
--
require'lspconfig'.cssls.setup{
  capabilities = capabilities,
}
require'lspconfig'.tsserver.setup{
  capabilities = capabilities,
  root_dir = vim.loop.cwd
}
require'lspconfig'.jsonls.setup {
  capabilities = capabilities,
  commands = {
    Format = {
      function()
        vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
      end
    }
  }
}
require'lspconfig'.html.setup{
  capabilities = capabilities,
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
require'lspconfig'.vuels.setup{}

--
-- vimL
--
require'lspconfig'.vimls.setup{
  capabilities = capabilities,
}

--
-- bash shell
--
require'lspconfig'.bashls.setup{
  capabilities = capabilities,
}

--
-- rust
--
require'lspconfig'.rust_analyzer.setup{}


--
-- dart  flutter
--
require'lspconfig'.dartls.setup{
  cmd = { "dart", "/opt/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" },
  closingLabels = true,
  outline = true,
  flutterOutline = true,
}
