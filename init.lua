require('core')

vim.keymap.set('n', '<f2>', function()
  vim.lsp.buf_request(0, 'textDocument/hover', vim.lsp.util.make_position_params(0, 'utf-8'), function(err, data)
    print(vim.inspect(err))
    print(vim.inspect(data))
  end)
end, {})
