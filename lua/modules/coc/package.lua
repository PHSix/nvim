local package = require('core.pack').package
local conf = require('modules.coc.config')

package({
    'neoclide/coc.nvim',
    branch = 'release',
    dependencies = { 'PHSix/coc-eslint-tools' },
    config = conf.coc,
    init = function()
        vim.cmd([[set rtp+=~/.config/nvim/extensions/coc-stylua]])
        vim.cmd([[set rtp+=~/.config/nvim/extensions/coc-pos]])
        vim.cmd([[set rtp+=~/.config/nvim/extensions/coc-vtsls]])
        vim.cmd([[set rtp+=~/.config/nvim/extensions/coc-fzf-lua]])
    end,
})

package({
    'kevinhwang91/nvim-ufo',
    events = { 'BufRead' },
    dependencies = 'kevinhwang91/promise-async',
    config = conf.ufo,
})

package({
    'kevinhwang91/nvim-bqf',
    config = conf.bqf,
})
