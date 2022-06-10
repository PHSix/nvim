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
