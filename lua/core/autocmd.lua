local id = vim.api.nvim_create_augroup('patch_augroup', { clear = true })
vim.api.nvim_create_autocmd({ 'FileType' }, {
    pattern = { 'help', 'dashboard', 'coctree' },
    callback = function()
        vim.keymap.set('n', 'q', '<Cmd>q<CR>', { silent = true, buffer = true })
    end,
    group = id,
})

local use_double_space_tab_filetypes = {
    'astro',
    'c',
    'cpp',
    'css',
    'go',
    'html',
    'javascript',
    'javascriptreact',
    'json',
    'less',
    'nix',
    'python',
    'scss',
    'typescript',
    'typescriptreact',
    'vue',
    'dart',
    'coc-explorer',
}

local use_tab_expand_filetypes = {
    'nix',
}

vim.api.nvim_create_autocmd('BufEnter', {
    pattern = '*',
    group = id,
    callback = function(args)
        local buf = args and args.buf or 0
        local ft = vim.bo[buf].filetype
        if vim.list_contains(use_double_space_tab_filetypes, ft) == true then
            vim.api.nvim_set_option_value('shiftwidth', 2, { scope = 'local' })
            vim.api.nvim_set_option_value('softtabstop', 2, { scope = 'local' })
            vim.api.nvim_set_option_value('tabstop', 2, { scope = 'local' })
            local use_expand_tab = vim.list_contains(use_tab_expand_filetypes, ft)
            vim.api.nvim_set_option_value('expandtab', use_expand_tab, { scope = 'local' })
        end
    end,
})
