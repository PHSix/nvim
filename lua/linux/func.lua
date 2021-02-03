local vim = vim
local api = vim.api
function StartR()
  if vim.bo.filetype == "markdown"  or vim.bo.filetype == 'vimwiki' then
    vim.cmd(":Glow")
  else vim.cmd(":AsyncTask file-run")
  end
end

function Com_Tab()
  if vim.fn.pumvisible() ~= 0 then
    return vim.api.nvim_replace_termcodes('<C-n>', true, true,true)
  else
    return vim.api.nvim_replace_termcodes('<TAB>', true, true,true)
  end
end

function Com_STab()
  if vim.fn.pumvisible() ~= 0 then
    return vim.api.nvim_replace_termcodes('<C-p>', true, true,true)
  else
    return vim.api.nvim_replace_termcodes('<S-TAB>', true, true,true)
  end
end
local get_name = function ()
  return vim.fn['bufname']()
end

local win_get_list = function ()
  local M =  vim.fn['win_findbuf'](vim.fn['bufnr'](get_name()))
  return M
end

local win_list_length = function ()
  M = #win_get_list()
  return M
end

local buf_is_empty = function ()
  local bufname = vim.fn['bufname']()
  if bufname == "" then
    vim.cmd('q')
  end
end

local nvim_tree_exist = function ()
  local M =  vim.fn['win_findbuf'](vim.fn['bufnr']('NvimTree'))
  local len = #M
  if len ~= 0 then
    return true
  else
    return false
  end
end

function QuitOrClose()
  buf_is_empty()
  local len = win_list_length()
  if len == 1 then
    local exist = nvim_tree_exist()
    if exist == true then
      vim.cmd("NvimTreeToggle")
    end
    vim.cmd('bw')
    buf_is_empty()
  else
    vim.cmd('q')
  end
end


function QuitSearch()
  local work = vim.fn['expand']('<cword>')
  vim.cmd("/" .. work)
end
