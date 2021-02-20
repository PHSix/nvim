local vim = vim
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local lspconfig = require'lspconfig'
require'lspconfig'.clangd.setup{
  capabilities = capabilities,
}

require'lspconfig'.cmake.setup{
  capabilities = capabilities,
}

require'lspconfig'.gopls.setup{
  cmd = {"gopls","--remote=auto"},
  capabilities = capabilities,
  init_options = {
    usePlaceholders=true,
    completeUnimported=true,
  },
  root_dir = vim.loop.cwd
}
require'lspconfig'.sumneko_lua.setup{
  capabilities = capabilities,
  cmd = {"lua-language-server", "-E", "/home/ph/.cache/yay/lua-language-server-git/src/lua-language-server-git/main.lua"},
}
require'lspconfig'.pyls.setup{
  capabilities = capabilities,
}
require'lspconfig'.cssls.setup{
  capabilities = capabilities,
}
require'lspconfig'.tsserver.setup{
  capabilities = capabilities,
  root_dir = vim.loop.cwd
}
require'lspconfig'.vimls.setup{
  capabilities = capabilities,
}
require'lspconfig'.dartls.setup{
  capabilities = capabilities,
  cmd = { "dart", "/opt/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" }
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
require'lspconfig'.bashls.setup{
  capabilities = capabilities,
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
