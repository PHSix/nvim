--- function that create a floating windows
--- parmas: buf_id, win_id (which can be edit)
local api = vim.api
local function create_window()
  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")
  local win_height = math.ceil(height * 0.6 - 4)
  local win_width = math.ceil(width * 0.3)
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col,
    border = "single",
  }
  -- create preview buffer and set local options
  local buf = api.nvim_create_buf(false, true)
  local win = api.nvim_open_win(buf, true, opts)
  api.nvim_win_set_option(win, "cursorline", true)
  api.nvim_buf_set_option(buf, "filetype", "Buftools")
  -- api.nvim_command("au BufWipeout <buffer> exe 'silent bwipeout! '" .. border_buf)
  -- set local options
  api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  api.nvim_win_set_option(win, "winblend", 0)
  return {
    buf = buf,
    win = win
  }
end

return create_window
