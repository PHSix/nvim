local vim = vim
function StartR()
  if vim.bo.filetype == "markdown" then
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

function  is_quit_file(filetype)
  local type_list = { 'dashboard', 'vista', 'qf', 'help' ,nil}
  for k,v in ipairs(type_list) do
    if filetype == v then
      return true
    end
  end
  return false
end


function QuitOrClose()
  if string.len(vim.bo.filetype) == 0 or is_quit_file(vim.bo.filetype) then
    vim.cmd(":q")
  else
    if string.len(vim.bo.filetype) > 0 then
      vim.cmd(":BufferClose")
      if string.len(vim.bo.filetype) == 0 then
        vim.cmd("q")
      end
      return
    end
    vim.cmd(":q")
  end
end

function QuitSearch()
  work = vim.fn['expand']('<cword>')
  vim.cmd("/" .. work)
end


