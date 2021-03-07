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
  ["n|gk"] = map_key("%"),
  -- leader key
  ["n|<space>"] = map_key("<leader>"),
  ["v|<space>"] = map_key("<leader>"),
  -- window operators
  ["n|<leader>l"] = map_key("<C-w>l"),
  ["n|<leader>h"] = map_key("<C-w>h"),
  ["n|<leader>k"] = map_key("<C-w>k"),
  ["n|<leader>j"] = map_key("<C-w>j"),
  ["n|<leader>sl"] = map_cmd("set splitright<CR>:vsplit"),
  ["n|<leader>sh"] = map_cmd("set nosplitright<CR>:vsplit"):silent(),
  ["n|<leader>sk"] = map_cmd("set nosplitbelow<CR>:split"):silent(),
  ["n|<leader>sj"] = map_cmd("set splitbelow<CR>:split"):silent(),
  -- edit operations
  ["v|fy"] = map_key("\"+y"),
  ["n|S"] = map_cmd("w"):noremap():silent(),
  -- terminal operations
  ["t|<C-p>"] = map_key("<C-\\><C-n>"):noremap():silent(),
  --
  -- Plugins
  --
  -- dashboard
  ["n|<C-f>s"] = map_cmd("<C-u>SessionSave"):noremap():silent(),
  ["n|<C-f>l"] = map_cmd("<C-u>SessionLoad"):noremap():silent(),
  ["n|<C-f>u"] = map_cmd("DashboardFindHistory"):noremap():silent(),
  ["n|<C-f>f"] = map_cmd("DashboardFindFile"):noremap():silent(),
  ["n|<C-f>m"] = map_cmd("DashboardJumpMark"):noremap():silent(),
  ["n|<C-f>w"] = map_cmd("DashboardFindWord"):noremap():silent(),
  ["n|<C-f>n"] = map_cmd("DashboardNewFile"):noremap():silent(),
  ["n|<C-f>c"] = map_cmd("DashboardChangeColorscheme"):noremap():silent(),
  -- easy align
  ["v|ga"] = map_cmd("<Plug>(EasyAlign)"):silent(),
  -- nvim-tree.lua
  ["n|<C-n>"] = map_cmd("NvimTreeToggle"):noremap():silent(),
  -- faster.nvim
  ["n|j"] = map_key("v:lua.faster_jk('j')"):expr():silent(),
  ["n|k"] = map_key("v:lua.faster_jk('k')"):expr():silent(),
  -- chowcho.nvim
  ["n|;"] = map_key("v:lua.chowcho()"):expr():silent(),
  -- asynctasks
  ["n|R"] = map_key("v:lua.asynctasks_run()"):expr():silent(),
  -- ["n|B"]
  -- caw.vim
  ["n|,c"] = map_key("v:lua.caw_prefix()"):expr():silent(),
  ["v|,c"] = map_key("v:lua.caw_prefix()"):expr():silent(),
  -- lspsaga
  ["n|K"] = map_cmd("Lspsaga hover_doc"):noremap():silent(),
  ["n|]g"] = map_cmd("Lspsaga diagnostic_jump_next"):noremap():silent(),
  ["n|[g"] = map_cmd("Lspsaga diagnostic_jump_prev"):noremap():silent(),
  ["n|<leader>ca"] = map_cmd("Lspsaga code_action"):noremap():silent(),
  ["v|<leader>ca"] = map_cmd("Lspsaga range_code_action"):noremap():silent(),
  ["n|gf"] = map_cmd("Lspsaga lsp_finder"):noremap():silent(),
  ["n|<A-d>"] = map_cmd("Lspsaga open_floaterm"):noremap():silent(),
  ["t|<A-d>"] = map_key("<C-\\><C-n>:Lspsaga close_floaterm<CR>"):noremap():silent(),
  ["n|gd"] = map_cmd("Lspsaga preview_definition"):noremap():silent(),
  ["n|<leader>rn"] = map_cmd("Lspsaga rename"):noremap():silent(),
  -- nvim-compe
  ["i|<Tab>"] = map_key("v:lua.tab_complete()"):expr(),
  ["s|<Tab>"] = map_key("v:lua.tab_complete()"):expr(),
  ["i|<S-Tab>"] = map_key("v:lua.s_tab_complete()"):expr(),
  ["s|<S-Tab>"] = map_key("v:lua.s_tab_complete()"):expr(),
  ["i|<CR>"] = map_key("compe#confirm('<CR>')"):expr():noremap(),
  -- barbar.nvim
  ["n|<leader>1"] = map_cmd("BufferGoto 1"):noremap():silent(),
  ["n|<leader>2"] = map_cmd("BufferGoto 2"):noremap():silent(),
  ["n|<leader>3"] = map_cmd("BufferGoto 3"):noremap():silent(),
  ["n|<leader>4"] = map_cmd("BufferGoto 4"):noremap():silent(),
  ["n|<leader>5"] = map_cmd("BufferGoto 5"):noremap():silent(),
  ["n|<leader>6"] = map_cmd("BufferGoto 6"):noremap():silent(),
  ["n|<leader>7"] = map_cmd("BufferGoto 7"):noremap():silent(),
  ["n|<leader>8"] = map_cmd("BufferGoto 8"):noremap():silent(),
  ["n|<leader>9"] = map_cmd("BufferGoto 9"):noremap():silent(),
  -- vim-translator
  ["n|<leader>tt"] = map_cmd("TranslateW"):noremap():silent(),
  ["v|<leader>tt"] = map_cmd("TranslateW"):noremap():silent(),
  -- FTerm
  ["n|<A-f>"] = map_cmd("FTermOpen"):noremap():silent(),
  ["t|<A-f>"] = map_key("<C-\\><C-n><CMD>lua require'FTerm'.toggle()<CR>"):noremap():silent(),
}


local function load_mappings()
  for key, cmd in pairs(Mappings) do
    local mode = string.sub(key, 1, 1)
    local rhs = string.sub(key, 3)
    vim.api.nvim_set_keymap(mode, rhs, cmd.cmd, cmd.opts)
  end
end


load_mappings()



