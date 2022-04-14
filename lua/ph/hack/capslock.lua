local M = {}
local status = 0

function M.input_change()
  if status == 1 then
    vim.v.char = vim.fn.toupper(vim.v.char)
  end
end

function M.change_capslock()
  if status == 0 then
    status = 1
    vim.cmd [[augroup capslock]]
    vim.cmd [[autocmd InsertCharPre * lua require(_G.p('hack.capslock')).input_change()]]
    vim.cmd [[augroup END]]
  else
    status = 0
    vim.cmd [[augroup capslock]]
    vim.cmd [[autocmd! ]]
    vim.cmd [[augroup END]]
  end
end

function M.setup()
  vim.cmd [[command! CapsMode lua require(_G.p('hack.capslock')).change_capslock()]]
end

return M
