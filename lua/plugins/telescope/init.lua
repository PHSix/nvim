local function telescope()
  vim.cmd [[packadd plenary.nvim]]
  vim.cmd [[packadd popup.nvim]]
  vim.cmd [[packadd telescope-fzy-native.nvim]]
  vim.api.nvim_set_keymap("n", "<C-f>u", ":Telescope oldfiles<CR>", {})
  vim.api.nvim_set_keymap("n", "<C-f>w", ":Telescope live_grep<CR>", {})
  vim.api.nvim_set_keymap("n", "<A-x>", ":Telescope commands<CR>", {})
  local actions = require("telescope.actions")
end

return telescope
