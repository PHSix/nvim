local deps = {
	"denops.vim",
	"ddc-nvim-lsp",
	"ddc-nvim-lsp-sort",
	"ddc-matcher_head",
	"ddc-sorter_rank",
	"ddc-around",
	"denops-popup-preview.vim",
	"denops-signature_help",
	"pum.vim",
	"ddc-fuzzy",
	"vim-vsnip-integ",
	"vim-vsnip",
	"ddc-treesitter",
	"ddc-buffer",
	"ddc-yank",
	"ddc-file",
	"nvim-autopairs",
	"ddc-onp",
}

for _, dep in ipairs(deps) do
	vim.cmd("PackerLoad " .. dep)
end

vim.o.completeopt = "menu,noinsert"
vim.g.vsnip_snippet_dir = vim.fn["stdpath"]("config") .. "/vsnip"
-- font link: https://github.com/microsoft/vscode-codicons/raw/main/dist/codicon.ttf
vim.call("ddc#custom#patch_global", {
	sources = { "file", "vsnip", "nvim-lsp", "around", "buffer", "yank" },
	sourceOptions = {
		["_"] = {
			matchers = { "matcher_fuzzy" },
			sorters = { "sorter_fuzzy", "sorter_lsp" },
			converters = { "converter_fuzzy" },
			-- matchers = { "matcher_head" },
			-- sorters = { "sorter_rank", "sorter_onp", "sorter_lsp" },
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
	completionMenu = "pum.vim",
	backspaceCompletion = true,
})

vim.call("popup_preview#enable")
vim.call("signature_help#enable")
vim.call("ddc#enable")
vim.call("pum#set_option", "setline_insert", false)
vim.call("pum#set_option", "padding", true)
vim.call("pum#set_option", "border", "solid") -- solid/double/single/none/shadow/rounded

local npairs = require("nvim-autopairs")
npairs.setup({ map_bs = false, map_cr = false })
vim.keymap.set("i", "<tab>", function()
	if vim.fn["pum#visible"]() ~= 0 then
		vim.call("pum#map#insert_relative", 1)
		return
	elseif vim.fn["vsnip#available"](1) == 1 then
		return "<Plug>(vsnip-expand-or-jump)"
	else
		return "<TAB>"
	end
end, { expr = true, noremap = true })

vim.keymap.set("i", "<CR>", function()
	if vim.fn["pum#visible"]() ~= 0 then
		vim.call("pum#map#confirm")
		return
	else
		-- return "<CR>"
		return npairs.autopairs_cr()
	end
end, { expr = true })

vim.cmd([[
  inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
  inoremap <C-n>   <Cmd>call pum#map#select_relative(+1)<CR>
  inoremap <C-p>   <Cmd>call pum#map#select_relative(-1)<CR>
  inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
]])

vim.cmd([[autocmd User PumCompleteDone call vsnip_integ#on_complete_done(g:pum#completed_item)]])

-- vim.cmd([[autocmd TextChanged,TextChangedI * lua print(vim.fn["pum#_get"]().buf)]])
