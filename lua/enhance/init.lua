require('enhance.habamax')
require('enhance.stsline')

vim.cmd([[
  hi WinBar guibg=NONE
  hi WinBarNC guibg=NONE
]])

-- local group = vim.api.nvim_create_augroup('mini-dashboard', { clear = true })
--
-- vim.api.nvim_create_autocmd('VimEnter', {
--   pattern = '*',
--   group = group,
--   callback = function()
--     local path = vim.fn.expand('%:p')
--
--     if path ~= '' then
--       return
--     end
--
--     local bufnr = vim.api.nvim_create_buf(false, true)
--     vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { 'dashboard' })
--     vim.api.nvim_buf_set_option(bufnr, 'filetype', 'dashboard')
--     vim.api.nvim_win_set_buf(0, bufnr)
--
--     -- vim.api.nvim_create_autocmd('BufLeave', {
--     --   pattern = '*',
--     --   group = group,
--     --   callback = function() end,
--     -- })
--   end,
-- })
--

