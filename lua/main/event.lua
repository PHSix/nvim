local events = {
  ["cursorline_dispaly"] = {
    {"WinLeave", "*", "setlocal nocursorline"},
    {"WinEnter", "*", "setlocal cursorline"}
  },
  ["vimrc_help"] = {
    {"BufEnter", "*.txt", "if &buftype == 'help' | wincmd L | endif"}
  },
  ["cursorline_set"] = {
    {"CursorMoved", "<buffer>", "set cursorline"}
  },
  ["todo_file"] = {
    {"filetype", "vim", "inoremap", '<buffer> <silent>  <C-t> " TODO:'},
    {"filetype", "go", "inoremap", "<buffer> <silent>  <C-t> // TODO:"},
    {"filetype", "python", "inoremap", "<buffer> <silent>  <C-t> # TODO:"},
    {"filetype", "c", "inoremap", "<buffer> <silent>  <C-t> // TODO:"},
    {"filetype", "cpp", "inoremap", "<buffer> <silent>  <C-t> // TODO:"},
    {"filetype", "lua", "inoremap", "<buffer> <silent>  <C-t> -- TODO:"}
  },
  ["markdown_snippets"] = {
    {"FileType", "markdown", "inoremap", '<buffer> ,e <Esc>/<++><CR>:nohlsearch<CR>"_c4l'},
    {"FileType", "markdown", "inoremap", "<buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA"},
    {"FileType", "markdown", "inoremap", "<buffer> ,i ![](<++>) <++><Esc>F[a"},
    {"FileType", "markdown", "inoremap", "<buffer> ,l [](<++>) <++><Esc>F[a"},
    {"FileType", "markdown", "inoremap", "<buffer> ,s `` <++><Esc>F`i"}
    -- {"filetype", "markdown", "inoremap", "<buffer> ,"},
    -- {"filetype", "markdown", "inoremap", "<buffer> ,"}
  },
  -- ["lang"] = {
  --   {"filetype", "dart", "packadd", "dart-vim-plugin"},
  --   {"filetype", "vue", "packadd", "vim-vue-plugin"},
  -- }
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

local async
async =
  vim.loop.new_async(
  vim.schedule_wrap(
    function()
      load_event()
      async:close()
    end
  )
)
async:send()
