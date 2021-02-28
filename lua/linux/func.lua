local vim = vim
local api = vim.api
function _G.StartR()
  if vim.bo.filetype == "markdown" or vim.bo.filetype == "vimwiki" then
    vim.cmd [[Glow]]
  elseif vim.bo.filetype == "dart" then
    vim.cmd [[FlutterRun]]
  else
    vim.cmd(":AsyncTask file-run")
  end
end

local get_name = function()
  return vim.fn["bufname"]()
end

local win_get_list = function()
  local M = vim.fn["win_findbuf"](vim.fn["bufnr"](get_name()))
  return M
end

local win_list_length = function()
  M = #win_get_list()
  return M
end

local buf_is_empty = function()
  local bufname = api.nvim_buf_get_option(0, "filetype")
  if bufname == "" then
    vim.cmd("q")
  end
end

local nvim_tree_exist = function()
  local M = vim.fn["win_findbuf"](vim.fn["bufnr"]("NvimTree"))
  local len = #M
  if len ~= 0 then
    return true
  else
    return false
  end
end

function _G.QuitOrClose()
  if vim.fn["bufname"]() == "qf" then
    vim.cmd [[q]]
    return
  end
  buf_is_empty()
  local len = win_list_length()
  if len == 1 then
    local exist = nvim_tree_exist()
    if exist == true then
      vim.cmd [[NvimTreeToggle]]
    end
    vim.cmd [[bw]]
    buf_is_empty()
  else
    vim.cmd [[q]]
  end
end

function _G.QuitSearch()
  local work = vim.fn["expand"]("<cword>")
  vim.cmd("/" .. work)
end

function _G.Select_buf(num)
  local buffers = api.nvim_list_bufs()
  local buf = {}
  for _, v in pairs(buffers) do
    if
      api.nvim_buf_is_loaded(v) and api.nvim_buf_get_option(v, "modifiable") and
        api.nvim_buf_get_option(v, "filetype") ~= ""
     then
      table.insert(buf, v)
    end
  end
  if num > #buf then
    return
  end
  vim.cmd("buffer " .. buf[num])
end

function _G.SetqfBind()
  api.nvim_buf_set_keymap("n", "q", ":q<CR>", {noremap = true, silent = true})
  api.nvim_buf_set_keymap("n", "Q", ":q<CR>", {noremap = true, silent = true})
end
