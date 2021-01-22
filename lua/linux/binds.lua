vim.api.nvim_set_keymap('n', '<C-j>', '5j', {noremap=false, silent=true})
vim.api.nvim_set_keymap('v', '<C-j>', '5j', {noremap=false, silent=true})
vim.api.nvim_set_keymap('n', '<C-k>', '5k', {noremap=false, silent=true})
vim.api.nvim_set_keymap('v', '<C-k>', '5k', {noremap=false, silent=true})
vim.api.nvim_set_keymap('n', '<C-l>', '5l', {noremap=false, silent=true})
vim.api.nvim_set_keymap('v', '<C-l>', '5l', {noremap=false, silent=true})
vim.api.nvim_set_keymap('n', '<C-h>', '5h', {noremap=false, silent=true})
vim.api.nvim_set_keymap('v', '<C-h>', '5h', {noremap=false, silent=true})
vim.api.nvim_set_keymap('n', 'S', ':w<CR>', {noremap=false, silent=true})
vim.api.nvim_set_keymap('n', 'X', ':q!<CR>',{noremap=false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>h', '<C-w>j', {noremap=false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>l', '<C-w>l', {noremap=false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>k', '<C-w>k', {noremap=false, silent=true})
vim.api.nvim_set_keymap('n', '<leader>j', '<C-w>j', {noremap=false, silent=true})
vim.api.nvim_set_keymap('n', '<space>', '<leader>', {silent=true})
vim.api.nvim_set_keymap('v', 'fy', '"+y', {silent=true})
vim.api.nvim_set_keymap('n', 'gl','$', {noremap=false,silent=true})
vim.api.nvim_set_keymap('v', 'gl','$h', {noremap=false,silent=true})
vim.api.nvim_set_keymap('n', 'gh','^', {noremap=false,silent=true})
vim.api.nvim_set_keymap('v', 'gh','^', {noremap=false,silent=true})
vim.api.nvim_set_keymap('n', 'gk','%', {noremap=false,silent=true})
vim.api.nvim_set_keymap('v', 'gk','%', {noremap=false,silent=true})

vim.api.nvim_set_keymap("n", 'Q', ":lua QuitOrClose()<CR>", {noremap=true,silent=true})
vim.api.nvim_set_keymap("n", '<leader>sl', ':set splitright<CR>:vsplit<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap("n", '<leader>sh', ':set nosplitright<CR>:vsplit<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap("n", '<leader>sk', ':set nosplitbelow<CR>:split<CR>', {noremap=true, silent=true})
vim.api.nvim_set_keymap("n", '<leader>sj', ':set splitbelow<CR>:split<CR>', {noremap=true, silent=true})

vim.api.nvim_set_keymap("n", '<leader>h', '<C-w>h', {noremap=false, silent=true})
vim.api.nvim_set_keymap("n", '<leader>k', '<C-w>k', {noremap=false, silent=true})
vim.api.nvim_set_keymap("n", '<leader>l', '<C-w>l', {noremap=false, silent=true})
vim.api.nvim_set_keymap("n", '<leader>j', '<C-w>j', {noremap=false, silent=true})
vim.api.nvim_set_keymap("n", '<leader>nl',':noh<CR>',{noremap=false,silent=true})

vim.api.nvim_set_keymap("t", '<C-p>', '<C-\\><C-n>', {noremap=true, silent=true})
