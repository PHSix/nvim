local api = vim.api
local function t(key)
  return api.nvim_replace_termcodes(key, true, true, true)
end
local check_back_space = function()
  local col = vim.fn.col(".") - 1
  if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
    return true
  else
    return false
  end
end

local plugin_exist = function(plugin)
  if packer_plugins[plugin] and not packer_plugins[plugin].loaded then
    return true
  else
    return false
  end
end

local plugin_complie = function(plugin)
  if plugin_exist(plugin) then
    vim.cmd("packadd " .. plugin)
  end
end

function _G.faster_jk(key)
  plugin_complie("faster.nvim")
  local map = key == "j" and "<Plug>(faster_move_j)" or "<Plug>(faster_move_k)"
  return t(map)
end

function _G.chowcho()
  plugin_complie("chowcho.nvim")
  require("plugins.operator-tools.config").chowcho()
  return t(":lua require('chowcho').run()<CR>")
end

function _G.StartR()
  if vim.bo.filetype == "markdown" or vim.bo.filetype == "vimwiki" then
    vim.cmd [[Glow]]
  elseif vim.bo.filetype == "dart" then
    vim.cmd [[FlutterRun]]
  else
    vim.cmd(":AsyncTask file-run")
  end
end

function _G.asynctasks_run()
  if plugin_exist("asynctasks.vim") then
    vim.cmd [[packadd asyncrun.vim]]
    vim.cmd [[packadd asynctasks.vim]]
  end
  require("plugins.dap.config").asynctasks()
  return t(":lua StartR()<CR>")
end

function _G.caw_prefix()
  plugin_complie("caw.vim")
  return t("<Plug>(caw:prefix)")
end

_G.tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-n>"
  elseif vim.fn.call("vsnip#available", {1}) == 1 then
    return t "<Plug>(vsnip-expand-or-jump)"
  elseif check_back_space() then
    return t "<Tab>"
  else
    return vim.fn["compe#complete"]()
  end
end
_G.s_tab_complete = function()
  if vim.fn.pumvisible() == 1 then
    return t "<C-p>"
  elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
    return t "<Plug>(vsnip-jump-prev)"
  else
    return t "<S-Tab>"
  end
end
function _G.neuron_leader()
  plugin_complie("neuron.nvim")
  require("plugins.operator-tools.config").neuron()
end

function _G.switch_NvimTree()
  local win_list = api.nvim_list_wins()
  for _, win_id in pairs(win_list) do
    local buf_id = api.nvim_win_get_buf(win_id)
    local buf_filetype = api.nvim_buf_get_option(buf_id, "filetype")
    if buf_filetype == "NvimTree" then
      -- api.nvim_win_set_cursor(win_id, api.nvim_win_get_cursor(win_id))
      api.nvim_set_current_win(win_id)
      return
    end
  end
end

function _G.open_tagbar()
  local buf_type = api.nvim_buf_get_option(0, "filetype")
  local filetype = ""
  local wins_list = api.nvim_list_wins()
  local tagbar = ""
  if buf_type == "dart" then
    tagbar = "FlutterOutline"
    filetype = "flutterToolsOutline"
  else
    tagbar = "Vista nvim_lsp"
    filetype = "vista"
  end
  if buf_type == filetype then
    vim.cmd [[q]]
    return
  end
  for _, win in pairs(wins_list) do
    local buf = api.nvim_win_get_buf(win)
    if api.nvim_buf_get_option(buf, "filetype") == filetype then
      api.nvim_set_current_win(win)
      return
    end
  end
  vim.cmd(tagbar)
end
