local do_map = vim.api.nvim_buf_set_keymap
local function bufmap(buf_id)
  local maps = {
    {key = "q", command = ":q<CR>:hi! CursorLine gui=NONE<CR>"},
    {key = "<ESC>", command = ":q<CR>:hi! CursorLine gui=NONE<CR>"},
    {key = "<C-m>", command = ":lua require('main.buftools').open()<cr>"},
    {key = "o", command = ":lua require('main.buftools').open()<cr>"},
    {key = "d", command = ":lua require('main.buftools').delete()<cr>"},
    -- {key = "d", command = ":lua require('main.buftools').delete_buf()<cr>"}
  }
  for _, map in pairs(maps) do
    do_map(buf_id,'n', map["key"], map["command"], {silent = true, nowait = true})
  end
end
return bufmap
