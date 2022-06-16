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

require("coq_3p")({
	{ src = "nvimlua", short_name = "nLUA" },
})

vim.g.coq_settings = {
	["auto_start"] = true,
	["keymap.recommended"] = true,
	["keymap.pre_select"] = true,
	["keymap.jump_to_mark"] = "",
	["completion.always"] = true,
	["display.pum.fast_close"] = false,
	["display.preview.border"] = "single",
	["display.preview.positions"] = nil,
	["display.ghost_text.enabled"] = false,
	["match.fuzzy_cutoff"] = 0.8,
}

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
