local M = {}

function M.align()
  local top, bot = vim.fn.getpos("'<"), vim.fn.getpos("'>")
  print(top, bot)
end

return M
