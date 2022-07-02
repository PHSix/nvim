local ks = function(k, c)
	vim.keymap.set("n", k, "<Cmd>" .. c .. "<CR>", { silent = true })
end

-- ks("<leader>ff", "Clap files")
-- ks("<leader>fw", "Clap grep2")
-- ks("<leader>fu", "Clap history")
-- ks("<leader>fp", "Clap filer")
-- ks("<leader>fb", "Clap buffer")
-- ks("<leader>fl", "Clap lines")
-- ks("<leader>fr", "Clap registers")
-- ks("<leader>fy", "Clap yanks")
-- ks("<leader>fm", "Clap maps")

vim.keymap.set("n", "<leader>fr", function()
	ClapTasks()
end, { silent = true })

vim.g.clap_layout = { relative = "editor" }
vim.g.clap_popup_border = "single"
vim.g.clap_spinner_frames = {
	"🌍 ",
	"🌎 ",
	"🌏 ",
	-- "▹▹▹▹▹",
	-- "▸▹▹▹▹",
	-- "▹▸▹▹▹",
	-- "▹▹▸▹▹",
	-- "▹▹▹▸▹",
	-- "▹▹▹▹▸",
	-- "[    ]",
	-- "[=   ]",
	-- "[==  ]",
	-- "[=== ]",
	-- "[ ===]",
	-- "[  ==]",
	-- "[   =]",
	-- "[    ]",
	-- "[   =]",
	-- "[  ==]",
	-- "[ ===]",
	-- "[====]",
	-- "[=== ]",
	-- "[==  ]",
	-- "[=   ]",
}

vim.g.clap_popup_move_manager = {
	["<C-N>"] = "<Down>",
	["<C-P>"] = "<Up>",
}
vim.g.clap_prompt_format = " %spinner%%forerunner_status%%provider_id%: "
vim.g.clap_enable_icon = 1
vim.g.clap_theme = "onehalfdark"

vim.cmd([[
	hi ClapSpinner guibg=NONE guifg=#FF7396 gui=bold
	hi ClapInput guibg=NONE guifg=#76BA99
	hi ClapSearchText guibg=none guifg=#76BA99
	hi Title guifg=#FF6363
]])

function ClapTasks()
	vim.cmd([[packadd asynctasks.vim]])
	vim.cmd([[packadd asyncrun.vim]])
end
