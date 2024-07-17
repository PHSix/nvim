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
            },
        })
    end,
})

package({
    'stevearc/dressing.nvim',
    opts = {},
})

package({
    'dstein64/nvim-scrollview',
    config = true,
})

-- package({
--     'PHSix/vitesse.nvim',
--     enabled = false,
--     config = function()
--         vim.cmd([[colorscheme vitesse]])
--     end,
-- })

package({
    'olimorris/onedarkpro.nvim',
    config = function()
        vim.cmd([[colorscheme onelight]])
    end,
})
