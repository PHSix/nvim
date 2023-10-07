vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = { '*' },
  callback = function()
    if vim.g.colors_name ~= 'habamax' then
      return
    end

    vim.cmd([[hi! FloatBorder guibg=NONE]])
    vim.cmd([[hi! VertSplit guibg=NONE]])
    vim.cmd([[hi! DiffChange guifg=#bcbcbc guibg=#5f5f5f gui=NONE cterm=NONE]])
  end,
})
