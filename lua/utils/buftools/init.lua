-- vim.cmd [[hi link NormalFloat Normal]]
vim.cmd [[autocmd FileType,WinLeave Buftools,* hi! CursorLine gui=NONE]]
local api = vim.api
local fn = vim.fn
local bufs_cacahe
-- update bufs_cacahe table
local refresh = function(id)
  -- print(vim.inspect(bufs_cacahe))
  api.nvim_buf_set_lines(id, 0, -1, false, bufs_cacahe["value"])
end

-- if bufs_cacahe length is one(that is means only one buf loaded), it will split buffer in normal.
local open_in_normal = function()
  if _G.do_split_dict == "rvsplit" then
    vim.cmd [[set splitright]]
    vim.cmd [[vsplit]]
  elseif _G.do_split_dict == "lvsplit" then
    vim.cmd [[set nosplitright]]
    vim.cmd [[vsplit]]
  elseif _G.do_split_dict == "tsplit" then
    vim.cmd [[set nosplitbelow]]
    vim.cmd [[split]]
  elseif _G.do_split_dict == "bsplit" then
    vim.cmd [[set splitbelow]]
    vim.cmd [[split]]
  end
end

-- main function
-- open a buf dashboard
local function bufs_ui(split)
  if split ~= nil then
    _G.do_split_dict = split
  end
  bufs_cacahe = require("utils.buftools.bufs")()
  if #bufs_cacahe.keys == 1 then
    open_in_normal()
    return
  end
  local float = require("utils.buftools.floatbuf")()
  require("utils.buftools.bufmap")(float["buf"])
  refresh(float["buf"])
  vim.cmd [[hi! CursorLine gui=inverse]]
end

-- open buffer in a new window
local function open()
  if _G.do_split_dict == nil then
    return
  end
  local buf_id = bufs_cacahe.keys[fn.line(".")]
  vim.cmd [[q]]
  if _G.do_split_dict == "rvsplit" then
    vim.cmd [[set splitright]]
    vim.cmd [[vsplit]]
  elseif _G.do_split_dict == "lvsplit" then
    vim.cmd [[set nosplitright]]
    vim.cmd [[vsplit]]
  elseif _G.do_split_dict == "tsplit" then
    vim.cmd [[set nosplitbelow]]
    vim.cmd [[split]]
  elseif _G.do_split_dict == "bsplit" then
    vim.cmd [[set splitbelow]]
    vim.cmd [[split]]
  end
  local win_id = api.nvim_get_current_win()
  api.nvim_win_set_buf(win_id, buf_id)
end

-- delete buffer in buf ui
local function delete()
  local cur_line = fn.line(".")
  api.nvim_buf_delete(bufs_cacahe.keys[cur_line], {force = true})
  bufs_cacahe = require("uti.buftools.bufs")()
  refresh()
end

return {
  bufs_ui = bufs_ui,
  delete = delete,
  open = open
}
