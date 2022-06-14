local saga = require("lspsaga")
saga.init_lsp_saga({
	code_action_icon = "💡",
})

-- saga.init_lsp_saga()
-- saga.init_lsp_saga({
-- use_saga_diagnostic_sign = true,
-- error_sign = "",
-- warn_sign = "",
-- hint_sign = "",
-- infor_sign = "",
-- diagnostic_header_icon = "   ",
-- code_action_icon = " ",
-- code_action_prompt = {
-- 	enable = false,
-- 	sign = true,
-- 	sign_priority = 1000,
-- 	virtual_text = true,
-- },
-- finder_definition_icon = "  ",
-- finder_reference_icon = "  ",
-- max_preview_lines = 10,
-- finder_action_keys = {
-- 	open = "o",
-- 	vsplit = "s",
-- 	split = "i",
-- 	quit = "q",
-- 	scroll_down = "<C-f>",
-- 	scroll_up = "<C-b>",
-- },
-- code_action_keys = {
-- 	quit = "q",
-- 	exec = "<CR>",
-- },
-- rename_action_keys = {
-- 	quit = "<C-c>",
-- 	exec = "<CR>",
-- },
-- definition_preview_icon = "  ",
-- border_style = "single",
-- rename_prompt_prefix = "➤",
-- server_filetype_map = {},
-- })
local opts = { silent = true }
vim.keymap.set("n", "K", "<cmd>Lspsaga hover_doc<CR>", opts)
vim.keymap.set("n", "gd", "<cmd>Lspsaga preview_definition<CR>", opts)
vim.keymap.set("n", "gf", "<cmd>Lspsaga lsp_finder<CR>", opts)
vim.keymap.set("n", "<leader>ca", "<cmd>Lspsaga code_action<CR>", opts)
vim.keymap.set("n", "<F2>", "<cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "<leader>rn", "<cmd>Lspsaga rename<CR>", opts)
vim.keymap.set("n", "<leader>j", "<cmd>Lspsaga diagnostic_jump_next<CR>", opts)
vim.keymap.set("n", "<leader>k", "<cmd>Lspsaga diagnostic_jump_prev<CR>", opts)
