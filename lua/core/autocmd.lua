vim.api.nvim_create_autocmd({ 'FileType' }, {
  pattern = { 'help', 'dashboard' },
  callback = function()
    vim.keymap.set('n', 'q', '<Cmd>q<CR>', { silent = true, buffer = true })
  end,
})

