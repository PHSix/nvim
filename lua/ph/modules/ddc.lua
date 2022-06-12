vim.o.completeopt = "menu,noinsert"
vim.g.vsnip_snippet_dir = vim.fn["stdpath"]("config") .. "/vsnip"
-- font link: https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf
vim.call("ddc#custom#patch_global", {
	sources = { "file", "vsnip", "nvim-lsp", "around", "buffer", "yank" },
	sourceOptions = {
		["_"] = {
			-- matchers = { "matcher_fuzzy" },
			-- sorters = { "sorter_fuzzy" },
			-- converters = { "converter_fuzzy" },
			matchers = { "matcher_head" },
			sorters = { "sorter_rank" },
		},
		["nvim-lsp"] = {
			mark = "「LSP」",
			maxCandidates = 15,
			minAutoCompleteLength = 1,
			forceCompletionPattern = [[\.|:|->]],
			dup = true,
			ignoreCase = true,
		},
		around = {
			mark = "「AROUND」",
		},
		buffer = {
			mark = "「BUFFER」",
			-- limitBytes = 50,
		},
		vsnip = {
			mark = "「VSNIP」",
		},
		file = {
			mark = "「FILE」",
			forceCompletionPattern = "\\S/\\S*",
		},
		yank = {
			mark = "「YANK」",
		},
	},
	sourceParams = {
		["nvim-lsp"] = {
			kindLabels = {
				-- Text = "  ",
				-- Method = "  ",
				-- Function = "  ",
				-- Constructor = "  ",
				-- Field = "  ",
				-- Variable = "  ",
				-- Class = "  ",
				-- Interface = "  ",
				-- Module = "  ",
				-- Property = "  ",
				-- Unit = "  ",
				-- Value = "  ",
				-- Enum = "  ",
				-- Keyword = "  ",
				-- Snippet = "  ",
				-- Color = "  ",
				-- File = "  ",
				-- Reference = "  ",
				-- Folder = "  ",
				-- EnumMember = "  ",
				-- Constant = "  ",
				-- Struct = "  ",
				-- Event = "  ",
				-- Operator = "  ",
				-- TypeParameter = "  ",
			},
		},
		file = {
			displayFile = "  ",
			displayDir = "  ",
		},
	},
	-- completionMenu = "pum.vim",
	backspaceCompletion = true,
})

-- vim.call("popup_preview#enable")
vim.call("signature_help#enable")
vim.call("ddc#enable")
vim.call("pum#set_option", "setline_insert", false)

local npairs = require("nvim-autopairs")
npairs.setup({ map_bs = false, map_cr = false })
vim.keymap.set("i", "<tab>", function()
	if vim.fn.pumvisible() ~= 0 then
		return "<C-n>"
	elseif vim.fn["vsnip#available"](1) == 1 then
		return "<Plug>(vsnip-expand-or-jump)"
	else
		return "<TAB>"
	end
end, { expr = true, noremap = true })
vim.api.nvim_set_keymap("i", "<s-tab>", [[pumvisible() ? "<c-p>" : "<bs>"]], { expr = true, noremap = true })
vim.keymap.set("i", "<CR>", function()
	if vim.fn.pumvisible() ~= 0 then
		return "<c-y>"
	else
		return "<CR>"
		-- return npairs.autopairs_cr()
	end
	-- if vim.fn.pumvisible() ~= 0 then
	-- 	if vim.fn.complete_info({ "selected" }).selected ~= -1 then
	-- 		return npairs.esc("<c-y>")
	-- 	else
	-- 		return "<CR>"
	-- 	end
	-- else
	-- 	return npairs.autopairs_cr()
	-- end
end, { expr = true })

-- BUG: pum.vim map
-- vim.cmd([[
-- 	inoremap <silent><expr> <TAB>
--         \ pum#visible() ? '<Cmd>call pum#map#insert_relative(+1)<CR>' :
--         \ (col('.') <= 1 <Bar><Bar> getline('.')[col('.') - 2] =~# '\s') ?
--         \ '<TAB>' : ddc#manual_complete()
--   inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
--   inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
--   inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
--   inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
--   inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
-- 	inoremap <expr> <CR>   pum#visible() ? '<Cmd>call pum#map#confirm()<CR>' : '<CR>'
-- ]])
