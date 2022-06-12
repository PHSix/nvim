vim.o.completeopt = vim.o.completeopt .. ",noinsert"
vim.g.vsnip_snippet_dir = vim.fn["stdpath"]("config") .. "/vsnip"
-- font link: https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf
vim.call("ddc#custom#patch_global", {
	sources = { "nvim-lsp", "around", "vsnip", "buffer", "yank", "file" },
	sourceOptions = {
		["_"] = {
			matchers = { "matcher_fuzzy" },
			sorters = { "sorter_fuzzy" },
			converters = { "converter_fuzzy" },
		},
		["nvim-lsp"] = {
			mark = "「LSP」",
			maxCandidates = 15,
			minAutoCompleteLength = 1,
			forceCompletionPattern = [[\.|:|->]],
			dup = true,
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
	},
	-- completionMenu = "pum.vim",
})
-- vim.call("popup_preview#enable")
vim.call("signature_help#enable")
vim.call("ddc#enable")
vim.call("pum#set_option", "setline_insert", false)

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
