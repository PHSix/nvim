local vim = vim
local lspconfig = require'lspconfig'
require'lspconfig'.clangd.setup{
}
require'lspconfig'.gopls.setup{
  cmd = {"gopls","--remote=auto"},
  filetypes = { "go", "gomod" },
  root_dir = lspconfig.util.root_pattern("go.mod", ".git")
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
