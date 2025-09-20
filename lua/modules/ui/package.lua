local package = require('core.pack').package

package({ 'nvim-tree/nvim-web-devicons', lazy = true })

package({
    'shellRaining/hlchunk.nvim',
    config = function()
        require('hlchunk').setup({
            -- indent = {
            --     enable = true,
            --     exclude_filetypes = {
            --         ['coc-explorer'] = true,
            --     },
            -- },
            chunk = {
                enable = true,
                chars = {
                    right_arrow = '▶',
                    left_top = '┌',
                    left_bottom = '└',
                },
            },
        })
    end,
})

package({
    'stevearc/dressing.nvim',
    opts = {},
})

package({
    'PHSix/vitesse.nvim',
    enabled = false,
    config = function()
        vim.cmd([[colorscheme vitesse]])
    end,
})

package({
    'olimorris/onedarkpro.nvim',
    enabled = false,
    config = function()
        vim.cmd([[colorscheme onedark]])
    end,
})

package({
    'rose-pine/neovim',
    name = 'rose-pine',
    enabled = false,
    config = function()
        vim.cmd('colorscheme rose-pine')
    end,
})

-- package({
--     'sainnhe/everforest',
--     config = function()
--         vim.g.everforest_better_performance = 1
--         vim.g.everforest_background = 'hard'
--         vim.cmd([[colorscheme everforest]])
--     end,
-- })

package({
    'NTBBloodbath/doom-one.nvim',
    enabled = false,
    config = function()
        vim.cmd([[colorscheme doom-one]])
    end,
})
