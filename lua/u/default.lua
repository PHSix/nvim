-- vim.g.material_style = "oceanic"
-- vim.cmd("colorscheme material")

-- vim.g.everforest_background = "soft"
-- vim.cmd([[colorscheme everforest]])

-- vim.cmd [[colorscheme gruvbox-material]]

-- vim.g.sonokai_style = 'atlantis'
-- vim.g.sonokai_better_performance = 1
-- vim.cmd [[colorscheme sonokai]]

-- vim.g.onedark_config = {
-- 	style = "deep",
-- }
-- vim.cmd([[colorscheme onedark]])

vim.g.catppuccin_flavour = "latte" -- latte, frappe, macchiato, mocha
require("catppuccin").setup()
vim.cmd([[colorscheme catppuccin]])

-- require("github-theme").setup()

-- vim.cmd([[colorscheme dracula]])

-- vim.opt.background = "dark"
-- require('nvim-tundra').setup({})
-- vim.cmd("colorscheme tundra")

-- vim.cmd([[colorscheme noctis]])

-- vim.cmd [[colorscheme tokyodark]]

vim.g.exclude_ft = { "plaintext" }

-- vim.cmd [[set rtp+=/home/ph/projects/hardhat-coc]]
