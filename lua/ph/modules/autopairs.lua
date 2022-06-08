if packer_plugins["nvim-cmp"] and packer_plugins["nvim-cmp"].load == true then
	require("nvim-autopairs.completion.cmp").setup({
		map_cr = true, --  map <CR> on insert mode
		map_complete = true, -- it will auto insert `(` (map_char) after select function or method item
		auto_select = true, -- automatically select the first item
		insert = false, -- use insert confirm behavior instead of replace
		map_char = {
			-- modifies the function or method delimiter by filetypes
			all = "(",
			tex = "{",
		},
	})
else
	local remap = vim.api.nvim_set_keymap
	local npairs = require("nvim-autopairs")

	npairs.setup({ map_bs = false })

	vim.g.coq_settings = { keymap = { recommended = false } }

	-- these mappings are coq recommended mappings unrelated to nvim-autopairs
	remap("i", "<esc>", [[pumvisible() ? "<c-e><esc>" : "<esc>"]], { expr = true, noremap = true })
	remap("i", "<c-c>", [[pumvisible() ? "<c-e><c-c>" : "<c-c>"]], { expr = true, noremap = true })
	remap("i", "<tab>", [[pumvisible() ? "<c-n>" : "<tab>"]], { expr = true, noremap = true })
	remap("i", "<s-tab>", [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })

	-- skip it, if you use another global object
	_G.MUtils = {}

	MUtils.CR = function()
		if vim.fn.pumvisible() ~= 0 then
			if vim.fn.complete_info({ "selected" }).selected ~= -1 then
				return npairs.esc("<c-y>")
			else
				return npairs.esc("<c-e>") .. npairs.autopairs_cr()
			end
		else
			return npairs.autopairs_cr()
		end
	end
	remap("i", "<cr>", "v:lua.MUtils.CR()", { expr = true, noremap = true })

	MUtils.BS = function()
		if vim.fn.pumvisible() ~= 0 and vim.fn.complete_info({ "mode" }).mode == "eval" then
			return npairs.esc("<c-e>") .. npairs.autopairs_bs()
		else
			return npairs.autopairs_bs()
		end
	end
	remap("i", "<bs>", "v:lua.MUtils.BS()", { expr = true, noremap = true })
end
