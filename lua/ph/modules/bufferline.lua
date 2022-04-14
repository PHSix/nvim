local M = {}
vim.cmd([[packadd nvim-web-devicons]])
if packer_plugins and packer_plugins["nvim-bufferline.lua"].loaded then
	require("bufferline").setup({
		options = {
			numbers = function(opts)
				return string.format("%s.", opts.ordinal)
			end,
			show_buffer_close_icons = false,
			modified_icon = "✥",
			buffer_close_icon = "",
			always_show_bufferline = false,
			show_close_icon = false,
			show_tab_indicators = true,
			enforce_regular_tabs = true,
			offsets = { { filetype = "NvimTree", text = "File Explorer", text_align = "center" } },
		},
	})
end

vim.cmd([[
nnoremap <silent><leader>1 <Cmd>BufferLineGoToBuffer 1<CR>
nnoremap <silent><leader>2 <Cmd>BufferLineGoToBuffer 2<CR>
nnoremap <silent><leader>3 <Cmd>BufferLineGoToBuffer 3<CR>
nnoremap <silent><leader>4 <Cmd>BufferLineGoToBuffer 4<CR>
nnoremap <silent><leader>5 <Cmd>BufferLineGoToBuffer 5<CR>
nnoremap <silent><leader>6 <Cmd>BufferLineGoToBuffer 6<CR>
nnoremap <silent><leader>7 <Cmd>BufferLineGoToBuffer 7<CR>
nnoremap <silent><leader>8 <Cmd>BufferLineGoToBuffer 8<CR>
nnoremap <silent><leader>9 <Cmd>BufferLineGoToBuffer 9<CR>
]])

function M.toggle()
	if vim.o.showtabline == 2 then
		vim.o.showtabline = 0
	else
		vim.o.showtabline = 2
	end
end

vim.cmd([[command! ToggleBuffeerline lua require(_G.p("modules.bufferline")).toggle()]])

return M
