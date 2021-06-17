require("mappings.func")
local map_cmd = require("mappings.bind").map_cmd
local map_key = require("mappings.bind").map_key

Mappings = {
  -- cursor move operations
  ["n|<C-j>"] = map_key("5j"),
  ["n|<C-h>"] = map_key("5h"),
  ["n|<C-l>"] = map_key("5l"),
  ["n|<C-k>"] = map_key("5k"),
  ["v|<C-j>"] = map_key("5j"),
  ["v|<C-h>"] = map_key("5h"),
  ["v|<C-l>"] = map_key("5l"),
  ["v|<C-k>"] = map_key("5k"),
  ["n|gh"] = map_key("^"),
  ["v|gh"] = map_key("^"),
  ["n|gl"] = map_key("$"),
  ["v|gl"] = map_key("$h"),
  ["n|gp"] = map_key("%"),
  -- leader key
  ["n|<space>"] = map_key("<leader>"),
  ["v|<space>"] = map_key("<leader>"),
  -- window operators
  ["n|<leader>l"] = map_key("<C-w>l"),
  ["n|<leader>h"] = map_key("<C-w>h"),
  ["n|<leader>k"] = map_key("<C-w>k"),
  ["n|<leader>j"] = map_key("<C-w>j"),
  ["n|<leader>sl"] = map_cmd("lua require('utils.buftools').bufs_ui('rvsplit')"):silent(),
  ["n|<leader>sh"] = map_cmd("lua require('utils.buftools').bufs_ui('lvsplit')"):silent(),
  ["n|<leader>sk"] = map_cmd("lua require('utils.buftools').bufs_ui('tsplit')"):silent(),
  ["n|<leader>sj"] = map_cmd("lua require('utils.buftools').bufs_ui('bsplit')"):silent(),
  -- ["n|<leader>sl"] = map_cmd("set splitright<CR>:vsplit"):silent(),
  -- ["n|<leader>sh"] = map_cmd("set nosplitright<CR>:vsplit"):silent(),
  -- ["n|<leader>sk"] = map_cmd("set nosplitbelow<CR>:split"):silent(),
  -- ["n|<leader>sj"] = map_cmd("set splitbelow<CR>:split"):silent(),
  ["n|<leader>o"] = map_cmd("call v:lua.switch_NvimTree()"):silent():noremap(),
  -- noremal operations
  ["v|fy"] = map_key('"+y'),
  ["n|S"] = map_cmd("w"):noremap():silent(),
  ["n|<leader>nl"] = map_cmd("nohlsearch"):noremap():silent(),
  ["n|<TAB>"] = map_cmd("bn"):silent(),
  ["n|;"] = map_key(":"),
  ["n|<A-x>"] = map_cmd("Telescope commands"):silent():noremap(),
  -- terminal operations
  ["t|<C-p>"] = map_key("<C-\\><C-n>"):noremap():silent(),
  -- command mode operations
  ["c|<C-h>"] = map_key("<left>"),
  ["c|<C-l>"] = map_key("<right>"),
  -- registers
  ["n|1y"] = map_key([["1yy]]),
  ["n|2y"] = map_key([["2yy]]),
  ["n|3y"] = map_key([["3yy]]),
  ["n|4y"] = map_key([["4yy]]),
  ["n|5y"] = map_key([["5yy]]),
  --
  -- Plugins
  --
  -- lsp
  -- ["n|<leader>ds"] = map_cmd("lua vim.lsp.buf.document_symbol()"):silent():noremap(),
  -- dashboard
  ["n|<C-f>u"] = map_cmd("Telescope oldfiles"):noremap():silent(),
  ["n|<C-f>f"] = map_cmd("Findr"):noremap():silent(),
  -- ["n|<C-f>f"] = map_cmd("Telescope find_files"):noremap():silent(),
  -- ["n|<C-f>w"] = map_cmd("Telescope live_grep"):noremap():silent(),
  ["n|<C-f>w"] = map_cmd("Telescope current_buffer_fuzzy_find"):noremap():silent(),
  ["n|<C-f>n"] = map_cmd("DashboardNewFile"):noremap():silent(),
  ["n|<C-f>c"] = map_cmd("DashboardChangeColorscheme"):noremap():silent(),
  ["n|<F1>"] = map_cmd("e ~/.config/nvim/lua/main/init.lua"):noremap():silent(),
  ["n|<F2>"] = map_cmd("PackerCompile"):noremap():silent(),
  -- telescope
  ["n|<c-f>b"] = map_cmd("Telescope file_browser"):silent():noremap(),
  -- nvim-tree.lua
  -- ["n|<C-n>"] = map_cmd("NvimTreeToggle"):noremap():silent(),
  -- chadtree
  ["n|<C-n>"] = map_cmd("CHADopen"):silent(),
  -- faster.nvim
  ["n|j"] = map_key("v:lua.faster_jk('j')"):expr():silent(),
  ["n|k"] = map_key("v:lua.faster_jk('k')"):expr():silent(),
  -- asynctasks
  ["n|R"] = map_key("v:lua.asynctasks_run()"):expr():silent(),
  -- ["n|B"]
  -- caw.vim
  ["n|,c"] = map_key("v:lua.caw_prefix()"):expr():silent(),
  ["v|,c"] = map_key("v:lua.caw_prefix()"):expr():silent(),
  -- lspsaga
  ["n|K"] = map_cmd("Lspsaga hover_doc"):noremap():silent(),
  ["n|gj"] = map_cmd("Lspsaga diagnostic_jump_next"):noremap():silent(),
  ["n|gk"] = map_cmd("Lspsaga diagnostic_jump_prev"):noremap():silent(),
  ["n|J"] = map_cmd("Lspsaga show_cursor_diagnostics"):noremap():silent(),
  ["n|<leader>ca"] = map_cmd("Lspsaga code_action"):noremap():silent(),
  ["v|<leader>ca"] = map_cmd("Lspsaga range_code_action"):noremap():silent(),
  ["n|gd"] = map_cmd("Lspsaga lsp_finder"):noremap():silent(),
  ["n|<A-d>"] = map_cmd("Lspsaga open_floaterm"):noremap():silent(),
  ["t|<A-d>"] = map_key("<C-\\><C-n>:Lspsaga close_floaterm<CR>"):noremap():silent(),
  ["n|gf"] = map_cmd("Lspsaga preview_definition"):noremap():silent(),
  ["n|<leader>rn"] = map_cmd("Lspsaga rename"):noremap():silent(),
  -- nvim-compe
  -- ["i|<Tab>"] = map_key("v:lua.tab_complete()"):expr(),
  -- ["s|<Tab>"] = map_key("v:lua.tab_complete()"):expr(),
  -- ["i|<S-Tab>"] = map_key("v:lua.s_tab_complete()"):expr(),
  -- ["s|<S-Tab>"] = map_key("v:lua.s_tab_complete()"):expr(),
  ["i|<CR>"] = map_key("compe#confirm('<CR>')"):expr():noremap(),
  -- vim-translator
  ["n|<leader>tt"] = map_cmd("TranslateW"):noremap():silent(),
  ["v|<leader>tt"] = map_cmd("TranslateW"):noremap():silent(),
  -- Vista
  ["n|<C-,>"] = map_cmd("call v:lua.open_tagbar()"):noremap():silent(),
  -- Format
  ["n|F"] = map_cmd("call v:lua.format()"):noremap():silent(),
  -- vim-eft
  ["n|f"] = map_key("v:lua.vim_eft('f')"):expr():silent(),
  ["n|t"] = map_key("v:lua.vim_eft('t')"):expr():silent(),
  ["n|'"] = map_key([[v:lua.vim_eft("'")]]):expr():silent(),
  -- hop.nvim
  ["n|s"] = map_cmd("HopChar2"):silent(),
  -- bufferline.nvim
  ["n|<C-s>u"] = map_cmd("call v:lua.switch_buf(1)"):silent(),
  ["n|<C-s>i"] = map_cmd("call v:lua.switch_buf(2)"):silent(),
  ["n|<C-s>o"] = map_cmd("call v:lua.switch_buf(3)"):silent(),
  ["n|<C-s>p"] = map_cmd("call v:lua.switch_buf(4)"):silent(),
  ["n|<C-s>h"] = map_cmd("call v:lua.switch_buf(5)"):silent(),
  ["n|<C-s>j"] = map_cmd("call v:lua.switch_buf(6)"):silent(),
  ["n|<C-s>k"] = map_cmd("call v:lua.switch_buf(7)"):silent(),
  ["n|<C-s>l"] = map_cmd("call v:lua.switch_buf(8)"):silent(),
  ["n|<leader>1"] = map_cmd("call v:lua.switch_buf(1)"):silent(),
  ["n|<leader>2"] = map_cmd("call v:lua.switch_buf(2)"):silent(),
  ["n|<leader>3"] = map_cmd("call v:lua.switch_buf(3)"):silent(),
  ["n|<leader>4"] = map_cmd("call v:lua.switch_buf(4)"):silent(),
  ["n|<leader>5"] = map_cmd("call v:lua.switch_buf(5)"):silent(),
  ["n|<leader>6"] = map_cmd("call v:lua.switch_buf(6)"):silent(),
  ["n|<leader>7"] = map_cmd("call v:lua.switch_buf(7)"):silent(),
  ["n|<leader>8"] = map_cmd("call v:lua.switch_buf(8)"):silent(),
  -- fzf-lsp
  ["n|<C-f>d"] = map_cmd("call v:lua.fzf_lsp_doc_symbols()"):silent(),
  -- toggle_term
  ["n|<C-t>"] = map_cmd("ToggleTerm"):silent(),
  ["t|<C-t>"] = map_key("<C-p>:ToggleTerm<CR>"):silent(),
  -- dial
  ["n|<C-a>"] = map_key("<Plug>(dial-increment)"):silent(),
  ["n|<C-x>"] = map_key("<Plug>(dial-decrement)"):silent(),
  ["v|<C-a>"] = map_key("<Plug>(dial-increment)"):silent(),
  ["v|<C-x>"] = map_key("<Plug>(dial-decrement)"):silent()
}

local function load_mappings()
  for key, cmd in pairs(Mappings) do
    local mode = string.sub(key, 1, 1)
    local rhs = string.sub(key, 3)
    vim.api.nvim_set_keymap(mode, rhs, cmd.cmd, cmd.opts)
  end
end

-- load_mappings()
local async
async =
  vim.loop.new_async(
  vim.schedule_wrap(
    function()
      load_mappings()
      async:close()
    end
  )
)
async:send()
