local events = {
  ["cursorline_dispaly"] = {
    {"WinLeave", "*", "setlocal nocursorline"},
    {"WinEnter", "*", "setlocal cursorline"}
  },
  ["vimrc_help"] = {
    {"BufEnter", "*.txt","if &buftype == 'help' | wincmd L | endif"}
  },
  ["cursorline_set"] = {
    {"CursorMoved", "<buffer>", "set cursorline"}
  },
  ["todo_file"] = {
    {"filetype", "vim", "inoremap", '<buffer> <silent>  <C-t> " TODO:' },
    {"filetype", "go", "inoremap", "<buffer> <silent>  <C-t> // TODO:" },
    {"filetype", "python","inoremap", "<buffer> <silent>  <C-t> # TODO:"},
    {"filetype", "c","inoremap", "<buffer> <silent>  <C-t> // TODO:"},
    {"filetype", "cpp","inoremap", "<buffer> <silent>  <C-t> // TODO:"},
    {"filetype", "lua","inoremap", "<buffer> <silent>  <C-t> -- TODO:"},
  }
}

local function load_event()
  for group, event in pairs(events) do
    vim.cmd("augroup " .. group)
    vim.cmd [[autocmd!]]
    for _, def in pairs(event) do
      local command = "autocmd " .. table.concat(def, " ")
      vim.cmd(command)
    end
    vim.cmd [[augroup END]]
  end
end

load_event()
