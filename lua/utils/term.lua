local api = vim.api
local term
local win

local opts = {
  style = "minimal",
  relative = "editor",
  width = 100,
  height = 40,
  row = 3,
  col = 3,
  border = "single"
}

local function create_term()
  local buf_id = api.nvim_create_buf(false, true)
  api.nvim_buf_set_option(buf_id, 'filetype', 'FloatTerminal')
  api.nvim_buf_set_option(buf_id, 'modifiable', false)
  api.nvim_buf_set_option(buf_id, 'modified', false)
  -- api.nvim_buf_set_option(buf_id, 'hidden', true)
  api.nvim_buf_set_option(buf_id, "filetype", "Buftools")
  term = buf_id
end

local function open_term()
  win = api.nvim_open_win(term, true, opts)
  api.nvim_command("term")
  api.nvim_command("normal! A")
end

local function close_term()
  api.nvim_win_close(win, true)
  -- api.nvim_buf_delete(term, {force = true})
  win = nil
end

local function toggle_term()
  if term == nil then
    create_term()
  end
  if win == nil then
    open_term()
  else
    close_term()
  end
end

return toggle_term
