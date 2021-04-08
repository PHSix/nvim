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
    vim.fn["compe#complete"]()
    return t "<C-n>"
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
  local wins_list = api.nvim_list_wins()
  local filetype = ""
  local tagbar = ""
  -- set variables
  if buf_type == "dart" then
    tagbar = "FlutterOutline"
    filetype = "flutterToolsOutline"
  else
    tagbar = "Vista nvim_lsp"
    filetype = "vista_kind"
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

function _G.format()
  local buf_type = vim.bo.filetype
  if buf_type == "dart" then
    vim.cmd [[DartFmt]]
  elseif packer_plugins["formatter.nvim"].loaded then
    vim.cmd [[Format]]
  else
    -- vim.cmd()
    local cur_line = vim.fn.line(".")
    local cur_col = vim.fn.col(".")
    vim.cmd("normal!gg")
    vim.cmd("normal!V")
    vim.cmd("normal!G")
    vim.cmd("normal!=")
    api.nvim_win_set_cursor(0, {cur_line, cur_col})
  end
end

function _G.vim_eft(opertion)
  plugin_complie("vim-eft")
  require("plugins.operator-tools.config").vim_eft()
  local map = {
    f = "<Plug>(eft-f)",
    t = "<Plug>(eft-F)",
    ["'"] = "<Plug>(eft-repeat)"
  }
  return t(map[opertion])
end

function _G.easymotion()
  plugin_complie("vim-easymotion")
  vim.g.EasyMotion_do_mapping = 0
  vim.g.EasyMotion_smartcase = 1
  return t("<Plug>(easymotion-s2)")
end

function _G.switch_buf(index)
  if packer_plugins["nvim-bufferline.lua"] then
    require("bufferline").go_to_buffer(index)
  elseif packer_plugins["barbar.nvim"] then
    vim.cmd("BufferGoto " .. index)
  else
  end
end

function _G.fzf_lsp_doc_symbols()
  vim.cmd [[packadd fzf-lsp.nvim]]
  require'fzf_lsp'.document_symbol_call()
end
