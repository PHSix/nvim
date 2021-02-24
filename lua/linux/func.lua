local vim = vim
local api = vim.api
function StartR()
  if vim.bo.filetype == "markdown"  or vim.bo.filetype == 'vimwiki' then
    vim.cmd(":Glow")
  else vim.cmd(":AsyncTask file-run")
  end
end


function Coc_tab()
  if vim.fn.pumvisible() ~= 0 then
    return vim.api.nvim_replace_termcodes('<C-n>', true, true,true)
  elseif (Check_back_space()) then
    return vim.api.nvim_replace_termcodes('<TAB>', true, true,true)
  end
  return vim.fn['coc#refresh']()
end

function Coc_shift_tab()
  if vim.fn.pumvisible() ~= 0 then
    return vim.api.nvim_replace_termcodes('<C-p>', true, true, true)
  else
    return vim.api.nvim_replace_termcodes('<C-h>', true, true, true)
  end
end

function Coc_enter()
  if vim.fn['complete_info']({"selected"})["selected"] ~= -1 then
    return vim.api.nvim_replace_termcodes('<C-y>', true, true, true)
  else
    return vim.api.nvim_replace_termcodes('<CR>', true, true, true)
  end
end

function Check_back_space()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  return (col == 0 or vim.api.nvim_get_current_line():sub(col, col):match('%s')) and true
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
  local bufname = api.nvim_buf_get_option(0, 'filetype')
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
  if vim.fn['bufname']() == 'qf' then
    vim.cmd [[q]]
    return
  end
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


function Select_buf(num)
  local buffers = api.nvim_list_bufs()
  local buf = {}
  for _, v in pairs(buffers) do
    if api.nvim_buf_is_loaded(v) and  api.nvim_buf_get_option(v,'modifiable') and api.nvim_buf_get_option(v, 'filetype') ~= "" then
      table.insert(buf, v)
    end
  end
  if num > #buf then
    return
  end
  vim.cmd('buffer ' .. buf[num])
end


function SetqfBind()
  api.nvim_buf_set_keymap('n', 'q', ':q<CR>', {noremap=true, silent=true})
  api.nvim_buf_set_keymap('n', 'Q', ':q<CR>', {noremap=true, silent=true})
end
