local config = {}

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
    require('ts_context_commentstring').setup({
        enable_autocmd = false,
    })
    require('Comment').setup({
        pre_hook = require('ts_context_commentstring.integrations.comment_nvim').create_pre_hook(),
    })
end

return config
