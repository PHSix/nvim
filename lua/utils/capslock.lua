local status = 0

function _G.input_change()
  if status == 1 then
    vim.v.char = vim.fn.toupper(vim.v.char)
  end
end

function _G.change_capslock()
  if status == 0 then
    status = 1
  else
    status = 0
  end
end

vim.cmd [[command! CapsMode lua change_capslock()]]
vim.cmd [[augroup capslock]]
vim.cmd [[autocmd InsertCharPre * lua input_change()]]
vim.cmd [[augroup END]]

