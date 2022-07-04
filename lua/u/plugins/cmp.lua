vim.cmd([[PackerLoad cmp-nvim-lsp]])
vim.cmd([[PackerLoad cmp-nvim-lua]])
vim.cmd([[PackerLoad cmp-path]])
-- vim.cmd([[PackerLoad cmp-treesitter]])
vim.cmd([[PackerLoad cmp-vsnip]])
vim.cmd([[PackerLoad cmp-under-comparator]])
vim.cmd([[PackerLoad vim-vsnip]])
-- vim.cmd([[PackerLoad cmp-buffer]])
vim.g.vsnip_snippet_dir = vim.fn["stdpath"]("config") .. "/vsnip"

vim.api.nvim_set_keymap("s", "<BS>", [[<c-g>"_c]], { silent = true })
vim.api.nvim_set_keymap("s", "a", [[<c-g>"_ca]], { silent = true })
vim.api.nvim_set_keymap("s", "b", [[<c-g>"_cb]], { silent = true })
vim.api.nvim_set_keymap("s", "c", [[<c-g>"_cc]], { silent = true })
vim.api.nvim_set_keymap("s", "d", [[<c-g>"_cd]], { silent = true })
vim.api.nvim_set_keymap("s", "e", [[<c-g>"_ce]], { silent = true })
vim.api.nvim_set_keymap("s", "f", [[<c-g>"_cf]], { silent = true })
vim.api.nvim_set_keymap("s", "g", [[<c-g>"_cg]], { silent = true })
vim.api.nvim_set_keymap("s", "h", [[<c-g>"_ch]], { silent = true })
vim.api.nvim_set_keymap("s", "i", [[<c-g>"_ci]], { silent = true })
vim.api.nvim_set_keymap("s", "j", [[<c-g>"_cj]], { silent = true })
vim.api.nvim_set_keymap("s", "k", [[<c-g>"_ck]], { silent = true })
vim.api.nvim_set_keymap("s", "l", [[<c-g>"_cl]], { silent = true })
vim.api.nvim_set_keymap("s", "m", [[<c-g>"_cm]], { silent = true })
vim.api.nvim_set_keymap("s", "n", [[<c-g>"_cn]], { silent = true })
vim.api.nvim_set_keymap("s", "o", [[<c-g>"_co]], { silent = true })
vim.api.nvim_set_keymap("s", "p", [[<c-g>"_cp]], { silent = true })
vim.api.nvim_set_keymap("s", "q", [[<c-g>"_cq]], { silent = true })
vim.api.nvim_set_keymap("s", "r", [[<c-g>"_cr]], { silent = true })
vim.api.nvim_set_keymap("s", "s", [[<c-g>"_cs]], { silent = true })
vim.api.nvim_set_keymap("s", "t", [[<c-g>"_ct]], { silent = true })
vim.api.nvim_set_keymap("s", "u", [[<c-g>"_cu]], { silent = true })
vim.api.nvim_set_keymap("s", "v", [[<c-g>"_cv]], { silent = true })
vim.api.nvim_set_keymap("s", "w", [[<c-g>"_cw]], { silent = true })
vim.api.nvim_set_keymap("s", "x", [[<c-g>"_cx]], { silent = true })
vim.api.nvim_set_keymap("s", "y", [[<c-g>"_cy]], { silent = true })
vim.api.nvim_set_keymap("s", "z", [[<c-g>"_cz]], { silent = true })

local cmp = require("cmp")
local types = require("cmp.types")
local cmp_kinds = {
	Text = "  ",
	Method = "  ",
	Function = "  ",
	Constructor = "  ",
	Field = "  ",
	Variable = "  ",
	Class = "  ",
	Interface = "  ",
	Module = "  ",
	Property = "  ",
	Unit = "  ",
	Value = "  ",
	Enum = "  ",
	Keyword = "  ",
	Snippet = "  ",
	Color = "  ",
	File = "  ",
	Reference = "  ",
	Folder = "  ",
	EnumMember = "  ",
	Constant = "  ",
	Struct = "  ",
	Event = "  ",
	Operator = "  ",
	TypeParameter = "  ",
}
local has_words_before = function()
	local line, col = unpack(vim.api.nvim_win_get_cursor(0))
	return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

local feedkey = function(key, mode)
	vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes(key, true, true, true), mode, true)
end

local disable_ft = { "nofile", "prompt", "clap_input" }

cmp.setup({
	enabled = function()
		local disabled = false
		disabled = disabled or (vim.api.nvim_buf_get_option(0, "buftype") == "prompt")
		disabled = disabled or (vim.fn.reg_recording() ~= "")
		disabled = disabled or (vim.fn.reg_executing() ~= "")
		disabled = disabled or vim.tbl_contains(disable_ft, vim.bo.filetype)
		-- disabled = disabled or cmp.config.context.in_syntax_group('Comment')
		return not disabled
	end,
	completion = { completeopt = "menu,menuone,noinsert" },
	formatting = {
		fields = { "abbr", "kind" },
		-- fields = { "kind", "abbr" },
		-- format = function(_, vim_item)
		-- 	vim_item.kind = cmp_kinds[vim_item.kind] or ""
		-- 	return vim_item
		-- end,
	},
	snippet = {
		expand = function(args)
			vim.fn["vsnip#anonymous"](args.body)
		end,
	},
	mapping = {
		["<C-n>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Insert }),
		["<C-p>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Insert }),
		["<Down>"] = cmp.mapping.select_next_item({ behavior = cmp.SelectBehavior.Select }),
		["<Up>"] = cmp.mapping.select_prev_item({ behavior = cmp.SelectBehavior.Select }),
		["<C-d>"] = cmp.mapping.scroll_docs(-4),
		["<C-f>"] = cmp.mapping.scroll_docs(4),
		["<C-Space>"] = cmp.mapping.complete(),
		["<C-e>"] = cmp.mapping.close(),
		["<CR>"] = cmp.mapping.confirm({
			behavior = cmp.ConfirmBehavior.Replace,
			select = true,
		}),
		["<Tab>"] = cmp.mapping(function(fallback)
			if cmp.visible() then
				cmp.select_next_item()
			elseif vim.fn["vsnip#available"](1) == 1 then
				feedkey("<Plug>(vsnip-expand-or-jump)", "")
			elseif has_words_before() then
				cmp.complete()
			else
				fallback() -- The fallback function sends a already mapped key. In this case, it's probably `<Tab>`.
			end
		end, { "i", "s" }),
		["<S-Tab>"] = cmp.mapping(function()
			if cmp.visible() then
				cmp.select_prev_item()
			elseif vim.fn["vsnip#jumpable"](-1) == 1 then
				feedkey("<Plug>(vsnip-jump-prev)", "")
			end
		end, { "i", "s" }),
	},
	sources = {
		{ name = "nvim_lsp", priority = 4 },
		-- For vsnip user.
		{ name = "vsnip", priority = 4 },
		{ name = "path", priority = 4 },
		-- For luasnip user.
		-- { name = 'luasnip' },

		-- For ultisnips user.
		-- { name = 'ultisnips' },
		-- { name = "atomic_css", priority = 3 },
		{ name = "nvim_lua", priority = 3 },

		-- { name = "buffer", priority = 2 },
		-- { name = "treesitter", priority = 1 },
	},
	sorting = {
		comparators = {
			function(entry1, entry2)
				local kind1 = entry1:get_kind() or 1
				local kind2 = entry2:get_kind() or 1
				if kind1 == 1 and kind2 == 1 then
					return false
				end
			end,
			function(entry1, entry2)
				local _, entry1_under = entry1.completion_item.label:find(" ")
				local _, entry2_under = entry2.completion_item.label:find(" ")
				entry1_under = entry1_under or 0
				entry2_under = entry2_under or 0
				if entry1_under > entry2_under then
					return false
				elseif entry1_under < entry2_under then
					return true
				end
			end,
			cmp.config.compare.offset,
			cmp.config.compare.exact,
			cmp.config.compare.score,
			cmp.config.compare.kind,
			cmp.config.compare.sort_text,
			cmp.config.compare.length,
			cmp.config.compare.order,
		},
	},
})
