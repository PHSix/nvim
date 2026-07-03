local package = require('core.pack').package
local conf = require('modules.editor.config')

package({
    'romus204/tree-sitter-manager.nvim',
    opts = {
        {
            ensure_installed = {
                'lua',
                'vim',
                'vimdoc',
                'markdown',
                'markdown_inline',
                'bash',
                'python',
                'javascript',
                'typescript',
                'html',
                'css',
                'json',
                'rust',
                'vue',
                'jsx',
                'toml',
                'tsx',
                'tmux',
                'vhs',
                'yaml',
                'zsh',
                'c',
                'cpp',
                'fish',
                'gitcommit',
                'gitignore',
                'go',
                'gomod',
                'gosum',
                'json5',
            },
            border = 'rounded', -- border style for the window (e.g. "rounded", "single"), if nil, use the default border style defined by 'vim.o.winborder'. See :h 'winborder' for more info.
            auto_install = true,
        },
    },
})
package({
    'psliwka/vim-smoothie',
})

package({
    'famiu/bufdelete.nvim',
    cmd = 'Bdelete',
})

package({
    'folke/flash.nvim',
    lazy = true,
    keys = {
        {
            's',
            mode = { 'n', 'x', 'o' },
            function()
                require('flash').jump()
            end,
            desc = 'Flash',
        },
        {
            'S',
            mode = { 'n', 'o', 'x' },
            function()
                require('flash').treesitter()
            end,
            desc = 'Flash Treesitter',
        },
        {
            'r',
            mode = 'o',
            function()
                require('flash').remote()
            end,
            desc = 'Remote Flash',
        },
        {
            'R',
            mode = { 'o', 'x' },
            function()
                require('flash').treesitter_search()
            end,
            desc = 'Treesitter Search',
        },
        {
            '<c-s>',
            mode = { 'c' },
            function()
                require('flash').toggle()
            end,
            desc = 'Toggle Flash Search',
        },
    },
    config = conf.flash,
})

package({
    'ethanholz/nvim-lastplace',
    config = conf.lastplace,
})

package({
    'nvimdev/hlsearch.nvim',
    config = true,
})

package({
    'ojroques/nvim-osc52',
    config = conf.nvim_osc52,
})

package({
    'numToStr/Comment.nvim',
    config = conf.comment_nvim,
    event = 'VeryLazy',
    dependencies = {
        'JoosepAlviste/nvim-ts-context-commentstring',
        lazy = true,
    },
})

-- package({
--     'folke/todo-comments.nvim',
--     dependencies = { 'nvim-lua/plenary.nvim' },
--     opts = {},
-- })

-- package({
--     'kawre/leetcode.nvim',
--     build = ':TSUpdate html',
--     dependencies = {
--         'MunifTanjim/nui.nvim',
--         'nvim-lua/plenary.nvim'
--     },
--     opts = {
--         -- 配置放在这里
--         cn = {
--             enabled = true,
--         },
--         lang = 'typescript',
--     },
-- })

package({
    'h-hg/fcitx.nvim',
    enabled = vim.fn.executable('fcitx5') == 1,
})

package({
    'numToStr/FTerm.nvim',
    config = function()
        require('FTerm').setup({
            border = 'single',
            dimensions = {
                height = 0.9,
                width = 0.9,
            },
        })

        -- Example keybindings
        vim.keymap.set('n', '<C-t>', '<CMD>lua require("FTerm").toggle()<CR>')
        vim.keymap.set('t', '<C-t>', '<C-\\><C-n><CMD>lua require("FTerm").toggle()<CR>')
    end,
})

package({
    'kdheepak/lazygit.nvim',
    lazy = true,
    cmd = {
        'LazyGit',
        'LazyGitConfig',
        'LazyGitCurrentFile',
        'LazyGitFilter',
        'LazyGitFilterCurrentFile',
    },
    dependencies = {
        'nvim-lua/plenary.nvim',
    },
})


