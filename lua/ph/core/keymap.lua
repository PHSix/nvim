local M = {
	normal = {
		{
			";",
			":",
			{},
		},
		{
			"S",
			":w<CR>",
		},
		{
			"fy",
			'"+y',
		},
		{
			"<space>",
			"<leader>",
		},
	},
	visual = {
		{
			"<C-j>",
			"5j",
		},
		{
			"<C-k>",
			"5k",
		},
		{
			"<C-h>",
			"5h",
		},
		{
			"<C-l>",
			"5l",
		},
		{
			"fy",
			'"+y',
		},
		{
			"<space>",
			"<leader>",
		},
	},
	insert = {
		{
			"<C-V>",
			"<ESC>\"+pa"
		},
	}
}

M.defult_opt = {
	silent = true,
}

M.setup = function()
	for _, map in pairs(M["normal"]) do
		if map[3] then
			vim.api.nvim_set_keymap("n", map[1], map[2], map[3])
		else
			vim.api.nvim_set_keymap("n", map[1], map[2], M.defult_opt)
		end
	end
	for _, map in pairs(M["visual"]) do
		if map[3] then
			vim.api.nvim_set_keymap("v", map[1], map[2], map[3])
		else
			vim.api.nvim_set_keymap("v", map[1], map[2], M.defult_opt)
		end
	end
	for _, map in pairs(M["insert"]) do
		if map[3] then
			vim.api.nvim_set_keymap("i", map[1], map[2], map[3])
		else
			vim.api.nvim_set_keymap("i", map[1], map[2], M.defult_opt)
		end
	end
end

return M
