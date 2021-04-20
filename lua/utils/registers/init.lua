local api = vim.api

function _G.create_float_window()
  local buf = api.nvim_create_buf(false, true)
  local buf_opts = {
    style = "relativenumber",
    width = 50,
    height = 20,
    row = 5,
    col = 20,
    relative = "editor",
    border="double"
  }
  api.nvim_open_win(buf, true, buf_opts)
end
