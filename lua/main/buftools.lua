local M = {}
local bufs_all
local split_direc = ""
local api = vim.api
vim.cmd [[hi link NormalFloat Normal]]
vim.cmd [[autocmd FileType,WinLeave Buftools,* hi! CursorLine gui=NONE]]

-- map operator keymap to floating window
local function map_buf(buf)
  api.nvim_buf_set_keymap(buf, "n", "q", ":q<CR>:hi! CursorLine gui=NONE<CR>", {noremap = true, silent = true})
  api.nvim_buf_set_keymap(buf, "n", "<ESC>", ":q<CR>:hi! CursorLine gui=NONE<CR>", {noremap = true, silent = true})
  api.nvim_buf_set_keymap(buf, "n", "o", ":lua require('main.buftools').buftools()<CR>", {silent = true})
  api.nvim_buf_set_keymap(buf, "n", "<C-m>", ":lua require('main.buftools').buftools()<cr>", {silent = true})
  api.nvim_buf_set_keymap(buf, "n", "d", ":lua require('main.buftools').delete_buf()<cr>", {silent = true})
end

-- get the all buffers
local function get_buf_list() bufs_all = {}
  local cur_bufs = api.nvim_list_bufs()
  local loaded_bufs = {}
  for _, buf in pairs(cur_bufs) do
    if api.nvim_buf_is_loaded(buf) and api.nvim_buf_get_option(buf, "modifiable") then
      if api.nvim_buf_get_name(buf) ~= "" and api.nvim_buf_get_option(buf, "filetype") ~= "" then
        table.insert(bufs_all, buf)
        table.insert(loaded_bufs, api.nvim_buf_get_name(buf))
      end
    end
  end
  return {
    bufs_name = loaded_bufs,
    bufs = cur_bufs
  }
end

local function refresh()
  
end
-- display all buf(loaded and modifiable) in a floating window
function M.show_bufs_list(direction)
  split_direc = direction
  local floating_window = M.create_window()
  map_buf(floating_window.buf)
  local cur_bufs = get_buf_list()
  api.nvim_buf_set_lines(floating_window["buf"], 0, -1, false, cur_bufs.bufs_name)
  vim.cmd [[hi! CursorLine gui=inverse]]
end

-- create a floating window and has a border
function M.create_window()
  local width = api.nvim_get_option("columns")
  local height = api.nvim_get_option("lines")
  local win_height = math.ceil(height * 0.6 - 4)
  local win_width = math.ceil(width * 0.3)
  local row = math.ceil((height - win_height) / 2 - 1)
  local col = math.ceil((width - win_width) / 2)
  -- BORDERS
  local border_buf = api.nvim_create_buf(false, true)
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
  local buf = api.nvim_create_buf(false, true)
  local win = api.nvim_open_win(buf, true, opts)
  api.nvim_win_set_option(win, "cursorline", true)
  api.nvim_buf_set_option(buf, "filetype", "Buftools")
  api.nvim_command("au BufWipeout <buffer> exe 'silent bwipeout! '" .. border_buf)
  -- set local options
  api.nvim_buf_set_option(buf, "bufhidden", "wipe")
  api.nvim_win_set_option(win, "winblend", 0)
  return {
    buf = buf,
    win = win
  }
end

function M.buftools()
  local buf_id = bufs_all[vim.fn.line(".")]
  vim.cmd [[q]]
  local win_id
  if split_direc == "rvsplit" then
    vim.cmd [[set splitright]]
    vim.cmd [[vsplit]]
  elseif split_direc == "lvsplit" then
    vim.cmd [[set nosplitright]]
    vim.cmd [[vsplit]]
  elseif split_direc == "tsplit" then
    vim.cmd [[set nosplitbelow]]
    vim.cmd [[split]]
  elseif split_direc == "bsplit" then
    vim.cmd [[set splitbelow]]
    vim.cmd [[split]]
  end
  win_id = api.nvim_get_current_win()
  api.nvim_win_set_buf(win_id, buf_id)
end
-- delete current line buffer

function M.delete_buf()
  local buf_id = bufs_all[vim.fn.line(".")]
end



return M
