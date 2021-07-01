local map = vim.api.nvim_set_keymap
local function map_normal(table)
	for _, value in pairs(table) do
		value[3] = value[3] or {}
		map("n", value[1], value[2], value[3])
	end
end
local function map_visual(table)
	for _, value in pairs(table) do
		value[3] = value[3] or {}
		map("v", value[1], value[2], value[3])
	end
end

local normal_maps = {
	{"<space>", "<leader>"};
	{"<C-j>", "5j"};
	{"<C-k>", "5k"};
	{"<C-h>", "5h"};
	{"<C-l>", "5l"};
	{"<leader>l", "<C-w>l"};
	{"<leader>k", "<C-w>k"};
	{"<leader>j", "<C-w>j"};
	{"<leader>h", "<C-w>h"};
  {"S", ":w<CR>"};
  {"<leader>nl", ":nohlsearch<CR>"};
}
local visual_maps = {
	{"<space>", "<leader>"};
	{"<C-j>", "5j", {}};
	{"<C-k>", "5k", {}};
	{"<C-h>", "5h", {}};
	{"<C-l>", "5l", {}};
}
map_normal(normal_maps)
map_visual(visual_maps)

return
