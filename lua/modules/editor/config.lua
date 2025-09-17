local config = {}

function config.nvim_treesitter()
    local lazy = require('lazy')
    local parser_config = require('nvim-treesitter.parsers').get_parser_configs()
    parser_config.rescript = {
        install_info = {
            url = 'https://github.com/rescript-lang/tree-sitter-rescript',
            branch = 'main',
            files = { 'src/scanner.c' },
            generate_requires_npm = false,
            requires_generate_from_grammar = true,
            use_makefile = true, -- macOS specific instruction
        },
    }
    require('nvim-treesitter.configs').setup({
        ensure_installed = { 'javascript', 'typescript', 'tsx', 'lua', 'markdown', 'go', 'css', 'scss' },
        auto_install = true,
        highlight = {
            enable = true,
            disable = function(_, buf)
                return vim.api.nvim_buf_line_count(buf) > 5000
            end,
        },
    })
    vim.g.skip_ts_context_commentstring_module = true

    require('ts_context_commentstring').setup({ enable_autocmd = true })

    lazy.load({
        plugins = { 'Comment.nvim' },
    })
end

function config.lastplace()
    require('nvim-lastplace').setup({
        lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
        lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
        lastplace_open_folds = true,
    })
end

function config.flash()
    require('flash').setup({
        modes = {
            search = {
                enabled = false,
            },
            char = {
                enabled = false,
            },
        },
    })
end

function config.nvim_osc52()
    vim.keymap.set('v', 'fy', require('osc52').copy_visual)
end

function config.comment_nvim()
    require('Comment').setup({
        mappings = {
            basic = true,
            extra = false,
        },
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
end

function config.fzf_lua()
    local function setup()
        local columns = vim.o.columns / 2
        local rows = vim.o.lines
        local layout = columns > rows and 'horizontal' or 'vertical'
        require('fzf-lua').setup({
            winopts = {
                backdrop = 0,
                preview = {
                    horizontal = 'right:55%',
                    vertical = 'up:55%',
                    default = 'bat',
                    layout = layout,
                    flip_columns = 100,
                },
            },
        })
    end

    setup()

    -- dynamically change windows layout
    vim.api.nvim_create_autocmd('VimResized', {
        callback = function()
            setup()
        end,
    })
end

return config
