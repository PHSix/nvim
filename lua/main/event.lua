local events = {
  ["cursorline_dispaly"] = {
    {"WinLeave", "*", "setlocal nocursorline"},
    {"WinEnter", "*", "setlocal cursorline"}
  },
  ["vimrc_help"] = {
    {"BufEnter", "*.txt", "if &buftype == 'help' | wincmd L | endif"},
    {"FileType", "help", "lua vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<CR>', {noremap=true, silent=true})"}
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
    -- {"FileType", "markdown", "inoremap", '<buffer> ,e <Esc>/<++><CR>:nohlsearch<CR>"_c4l'},
    -- {"FileType", "markdown", "inoremap", "<buffer> ,c ```<Enter><++><Enter>```<Enter><Enter><++><Esc>4kA"},
    -- {"FileType", "markdown", "inoremap", "<buffer> ,i ![](<++>) <++><Esc>F[a"},
    -- {"FileType", "markdown", "inoremap", "<buffer> ,l [](<++>) <++><Esc>F[a"},
    -- {"FileType", "markdown", "inoremap", "<buffer> ,s `` <++><Esc>F`i"}
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

vim.cmd [[
augroup markdown_snippets_all
  autocmd!
  autocmd filetype markdown inoremap <buffer> <silent> ,, <++>
  autocmd filetype markdown inoremap <buffer> <silent> ,e <esc>/<++><cr>:nohlsearch<cr>c4l
  autocmd Filetype markdown inoremap <buffer> <silent> ,f <Esc>/<++><CR>:nohlsearch<CR>c4l
  autocmd filetype markdown inoremap <buffer> <silent> ,s <esc>/ <++><cr>:nohlsearch<cr>c5l
  autocmd filetype markdown inoremap <buffer> <silent> ,- ---<enter><enter>
  autocmd filetype markdown inoremap <buffer> <silent> ,b **** <++><esc>F*hi
  autocmd filetype markdown inoremap <buffer> <silent> ,x ~~~~ <++><esc>F~hi
  autocmd filetype markdown inoremap <buffer> <silent> ,q `` <++><esc>F`i
  autocmd filetype markdown inoremap <buffer> <silent> ,c ```<enter><++><enter>```<enter><enter><++><esc>4ka
  autocmd filetype markdown inoremap <buffer> <silent> ,w - [ ] <enter><++><esc>kA
  autocmd filetype markdown inoremap <buffer> <silent> ,u <u></u><++><esc>F/hi
  autocmd filetype markdown inoremap <buffer> <silent> ,p ![](<++>) <enter><++><esc>kF[a
  autocmd filetype markdown inoremap <buffer> <silent> ,l [](<++>) <++><esc>F[a
  autocmd filetype markdown inoremap <buffer> <silent> ,1 #<space><enter><++><esc>kA
  autocmd filetype markdown inoremap <buffer> <silent> ,2 ##<space><enter><++><esc>kA
  autocmd filetype markdown inoremap <buffer> <silent> ,3 ###<space><enter><++><esc>kA
  autocmd filetype markdown inoremap <buffer> <silent> ,4 ####<space><enter><++><esc>kA
  autocmd filetype markdown inoremap <buffer> <silent> ,t <c-r>=strftime("%y-%m-%d %h:%m:%s")<cr>
  autocmd filetype markdown inoremap <buffer> <silent> ,g {% web  <++> %} <++><esc>fb2li
  autocmd filetype markdown inoremap <buffer> <silent> ,d {% download  <++> %} <++><esc>fd2li
augroup END
]]


load_event()

-- local async
-- async =
--   vim.loop.new_async(
--   vim.schedule_wrap(
--     function()
--       load_event()
--       async:close()
--     end
--   )
-- )
-- async:send()
