local package = require('core.pack').package
local conf = require('modules.coding.config')
package({
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    config = conf.telescope,
    dependencies = {
        { 'nvim-lua/plenary.nvim' },
        { 'nvim-telescope/telescope-fzf-native.nvim', build = 'make' },
    },
})

package({
    'tpope/vim-surround',
    keys = { 'd', 'c' },
})

package({
    'nvim-pack/nvim-spectre',
    cmd = { 'Spectre' },
    config = conf.spectre,

    dependencies = {
        { 'nvim-lua/plenary.nvim' },
    },
})

package({
    'kristijanhusak/vim-dadbod-ui',
    dependencies = {
        { 'tpope/vim-dadbod', lazy = true },
        { 'kristijanhusak/vim-dadbod-completion', ft = { 'sql', 'mysql', 'plsql' }, lazy = true }, -- Optional
    },
    cmd = {
        'DBUI',
        'DBUIToggle',
        'DBUIAddConnection',
        'DBUIFindBuffer',
    },
    init = function()
        -- Your DBUI configuration
        vim.g.db_ui_use_nerd_fonts = 1
    end,
})

-- package({
--     'simeji/winresizer',
--     key = '<C-e>',
--     config = conf.winresizer,
-- })
