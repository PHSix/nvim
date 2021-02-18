local vim = vim
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true
local lspconfig = require'lspconfig'
require'lspconfig'.clangd.setup{
}
require'lspconfig'.clangd.setup{}
require'lspconfig'.cmake.setup{}

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
  cmd = {"lua-language-server", "-E", "/home/ph/.cache/yay/lua-language-server-git/src/lua-language-server-git/main.lua"},
}
require'lspconfig'.pyls.setup{
}
require'lspconfig'.cssls.setup{
}
require'lspconfig'.tsserver.setup{
  root_dir = vim.loop.cwd
}
require'lspconfig'.vimls.setup{
}
require'lspconfig'.dartls.setup{
  cmd = { "dart", "/opt/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" }
}
require'lspconfig'.jsonls.setup {
    commands = {
      Format = {
        function()
          vim.lsp.buf.range_formatting({},{0,0},{vim.fn.line("$"),0})
        end
      }
    }
}
require'lspconfig'.bashls.setup{}
