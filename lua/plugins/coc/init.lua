require("plugins.coc.func")
local map = vim.api.nvim_set_keymap

map('i', '<Tab>', 'v:lua.smart_tab()', {expr = true, noremap = true})
map('i', '<cr>', 'v:lua.smart_enter()', {expr = true, noremap = true})

map("n", "<leader>rn", "<Plug>(coc-rename)", {})
map("n", "gj", "<Plug>(coc-diagnostic-next)", {})
map("n", "gk", "<Plug>(coc-diagnostic-prev)", {})
map("n", "gd", "<Plug>(coc-definition)", {})
map("n", "gy", "<Plug>(coc-type-definition)", {})

vim.g.coc_global_extensions = {
	"coc-json";
	"coc-lua";
	"coc-tsserver";
	"coc-flutter-tools";
	"coc-emmet";
	"coc-actions";
}

