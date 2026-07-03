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
    'rose-pine/neovim',
    name = 'rose-pine',
    enabled = false,
    config = function()
        vim.cmd('colorscheme rose-pine')
    end,
})

package({
    'ntbbloodbath/doom-one.nvim',
    config = function()
        vim.o.background = 'light'
        vim.cmd('colorscheme doom-one')
    end,
})
