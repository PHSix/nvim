local M = {}
local border_buf
local c_buf
local split_operator = ""
local bufs_all
local api = vim.api
vim.cmd [[hi link NormalFloat Normal]]
vim.cmd [[autocmd FileType,WinLeave Buftools,* hi! CursorLine gui=NONE]]

function M.show_buf_list(operator)
  split_operator = operator
  local buf_win = M.create_window()
  local bufs = M.get_buf_list()
  api.nvim_buf_set_lines(buf_win["buf"], 0, -1, false, bufs)
  vim.cmd [[hi! CursorLine gui=inverse]]
end

function M.get_buf_list()
  bufs_all = {}
  local bufs = api.nvim_list_bufs()
  local loaded_bufs = {}
  for _, buf in pairs(bufs) do
    if api.nvim_buf_is_loaded(buf) and api.nvim_buf_get_option(buf, "modifiable") then
      table.insert(bufs_all, buf)
      if api.nvim_buf_get_name(buf) ~= "" then
        table.insert(loaded_bufs, api.nvim_buf_get_name(buf))
      end
    end
  end
  print(vim.inspect(loaded_bufs))
  return loaded_bufs
end

function M.create_window()
  -- window size
  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")
  local win_height = math.ceil(height * 0.6 - 4)
  local win_width = math.ceil(width * 0.3)
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)
  -- BORDERS
  border_buf = api.nvim_create_buf(false, true)
  local title = "buftools"
  local border_opts = {
    style = "minimal",
    relative = "editor",
    width = win_width + 2,
    height = win_height + 2,
    row = row - 1,
    col = col - 1
  }
  local border_lines = {
    "┌" .. title .. string.rep("─", win_width - #title) .. "┐"
  }
  local middle_line = "│" .. string.rep(" ", win_width) .. "│"
  for _ = 1, win_height do
    table.insert(border_lines, middle_line)
  end
  table.insert(border_lines, "└" .. string.rep("─", win_width) .. "┘")
  api.nvim_buf_set_lines(border_buf, 0, -1, false, border_lines)
  api.nvim_open_win(border_buf, true, border_opts)

  local opts = {
    style = "minimal",
    relative = "editor",
    width = win_width,
    height = win_height,
    row = row,
    col = col
  }
  -- create preview buffer and set local options
  c_buf = api.nvim_create_buf(false, true)
  local win = api.nvim_open_win(c_buf, true, opts)
  api.nvim_win_set_option(win, "cursorline", true)
  api.nvim_buf_set_option(c_buf, "filetype", "Buftools")
  api.nvim_command("au BufWipeout <buffer> exe 'silent bwipeout! '" .. border_buf)
  api.nvim_buf_set_keymap(c_buf, "n", "q", ":q<CR>:hi! CursorLine gui=NONE<CR>", {noremap = true, silent = true})
  api.nvim_buf_set_keymap(c_buf, "n", "<ESC>", ":q<CR>:hi! CursorLine gui=NONE<CR>", {noremap = true, silent = true})
  api.nvim_buf_set_keymap(
    c_buf,
    "n",
    "o",
    ":lua require('main.buftools').split_window_enter()<CR>",
    {noremap = true, silent = true}
  )
  api.nvim_buf_set_keymap(
    c_buf,
    "n",
    "<C-m>",
    ":lua require('main.buftools').split_window_enter()<CR>",
    {noremap = true, silent = true}
  )
  -- set local options
  api.nvim_buf_set_option(c_buf, "bufhidden", "wipe")
  api.nvim_win_set_option(win, "winblend", 0)
  return {
    buf = c_buf,
    win = win
  }
end

function M.split_window_enter()
  local buf_id = bufs_all[vim.fn.line(".")]
  vim.cmd [[q]]
  local prev_wins = api.nvim_list_wins()
  local win_id
  if split_operator == "rvsplit" then
    vim.cmd [[set splitright]]
    vim.cmd [[vsplit]]
  elseif split_operator == "lvsplit" then
    vim.cmd [[set nosplitright]]
    vim.cmd [[vsplit]]
  elseif split_operator == "tsplit" then
    vim.cmd [[set nosplitbelow]]
    vim.cmd [[split]]
  elseif split_operator == "bsplit" then
    vim.cmd [[set splitbelow]]
    vim.cmd [[split]]
  end
  local pres_wins = api.nvim_list_wins()
  for id, _ in pairs(pres_wins) do
    if pres_wins[id] ~= prev_wins[id] then
      win_id = pres_wins[id]
      break
    end
  end
  -- vim.cmd [[hi CursorLine gui=NONE]]
  print(api.nvim_buf_get_name(buf_id))
  api.nvim_win_set_buf(win_id, buf_id)
end

return M
