vim.cmd [[
let g:tex_flavor='latex'
let g:vimtex_view_method='zathura'
let g:vimtex_quickfix_mode=0
set conceallevel=1
let g:tex_conceal='abdmg'
]]
vim.cmd [[
augroup latex_au
autocmd Filetype tex nmap <buffer><silent> R <Cmd>VimtexView<CR>
augroup END

]]

-- vim.api.nvim_create_user_command("TexPreview", function()
-- 	local fp = vim.fn.expand("#")
--
-- 	local pdf_file = string.format("%s.tex", string.sub(fp, 0, string.len(fp) - 4));
-- 	local uv = vim.loop
-- 	local isExist = type(uv.fs_stat(pdf_file)) == "table"
-- 	if not isExist then
-- 		vim.cmd [[VimtexComplie]]
-- 	end
-- end, { desc = "tex preview" })
