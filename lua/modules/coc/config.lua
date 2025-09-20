local config = {}
local cmd, fn, api = vim.cmd, vim.fn, vim.api

vim.g.coc_data_home = '~/.config/coc_nvim'
vim.g.coc_node_args = { '--experimental-vm-modules' }

local ensure_installed_extensions = {
    'coc-json',
    'coc-css',
    '@yaegassy/coc-volar',
    '@yaegassy/coc-tailwindcss3',
    '@yaegassy/coc-astro',
    'coc-emmet',
    -- 'coc-eslint',
    -- 'coc-floatinput',
    'coc-prettier',
    'coc-vimlsp',
    'coc-marketplace',
    'coc-snippets',
    'coc-explorer',
    'coc-pairs',
    'coc-go',
    'coc-sumneko-lua',
    'coc-git',
    'coc-basedpyright',
    'coc-tsserver',
    'coc-biome',
}

local function executable(c)
    return vim.fn.executable(c) == 1
end

local coc_user_config = {
    ['Lua.workspace.library'] = { vim.fn.expand('$VIMRUNTIME') },
}

if executable('nix') then
    if executable('nil') then
        table.insert(ensure_installed_extensions, 'coc-nil')
    end

    if executable('lua-language-server') then
        local serverDir

        --- @type string[]
        local paths = vim.fn.split(vim.env.PATH, ':')

        for _, path in ipairs(paths) do
            local match = string.match(path, [[lua.language.server]])
            if match ~= nil then
                serverDir = path:sub(0, string.len(path) - 4)
                coc_user_config = vim.tbl_extend('force', coc_user_config, {
                    ['Lua.misc.parameters'] = {
                        '--metapath',
                        '~/.cache/sumneko_lua/meta',
                        '--logpath',
                        '~/.cache/sumneko_lua/log',
                    },
                    ['sumneko-lua.serverDir'] = serverDir,
                })
                goto break_out
            end
        end

        ::break_out::
    end
end

vim.g.coc_global_extensions = ensure_installed_extensions

vim.g.coc_user_config = coc_user_config

function config.coc()
    vim.api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', { silent = true, expr = true })
    vim.api.nvim_set_keymap('i', '<S-TAB>', "pumvisible() ? '<C-p>' : '<C-h>'", { noremap = true, expr = true })

    vim.keymap.set('i', '<Cr>', function()
        if vim.fn['coc#pum#visible']() == 1 then
            return vim.fn['coc#pum#confirm']()
        else
            return '<Cr>'
        end
    end, { silent = true, noremap = true, expr = true })

    vim.g.coc_snippet_next = '<tab>'

    vim.api.nvim_create_augroup('coc_patch_autocmd', { clear = true })

    vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
        group = 'coc_patch_autocmd',
        pattern = '*',
        callback = function()
            if vim.fn.mode() == 's' then
                local key = vim.api.nvim_replace_termcodes('<C-r>_', true, false, true)
                vim.api.nvim_feedkeys(key, 's', false)
            end
        end,
        once = false,
    })

    -- vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    --     group = 'coc_patch_autocmd',
    --     pattern = '*',
    --     callback = function()
    --         local file = fn.expand('%:p')
    --         if fn.exists('g:WorkspaceFolders') == 1 then
    --             for _, f in ipairs(vim.g.WorkspaceFolders) do
    --                 if fn.match(file, f, 0) == 1 then
    --                     api.nvim_set_current_dir(f)
    --                     -- vim.cmd(string.format([[cd %s]], f))
    --                     return
    --                 end
    --             end
    --         end
    --         -- vim.opt.statusline = vim.opt.statusline
    --     end,
    -- })

    vim.api.nvim_create_user_command('CocFormat', function()
        vim.fn.CocActionAsync('format')
    end, {
        desc = 'coc lsp format with async',
    })

    vim.api.nvim_create_user_command('CocMarketplace', function()
        vim.cmd([[CocList marketplace]])
    end, {
        desc = 'open coc marketplace',
    })

    vim.g.coc_quickfix_open_command = 'vsplit'

    vim.cmd([[
        hi link CocGitAddedSign GitNew
        hi link CocGitRemovedSign GitDeleted
        hi link CocGitTopRemovedSign GitDeleted
        hi link CocGitChangeRemovedSign GitDeleted
        hi link CocGitChangedSign GitDirty
    ]])

    local explorer_size = 40
    local function resize_handler(num)
        return function()
            if explorer_size <= 5 then
                return
            end

            explorer_size = explorer_size + 5
            vim.cmd([[vertical resize ]] .. string.format(num > 0 and '+%d' or '%d', num))
        end
    end
    -- shortcut keys for explorer when vertical split.
    vim.api.nvim_create_autocmd('filetype', {
        group = 'coc_patch_autocmd',
        pattern = 'coc-explorer',
        callback = function()
            vim.keymap.set('n', '-', resize_handler(-5), { buffer = true })
            vim.keymap.set('n', '=', resize_handler(5), { buffer = true })
        end,
    })
    --
    vim.api.nvim_create_user_command('CocExplorer', function()
        local rows = vim.o.lines
        local cols = vim.o.columns / 2
        if rows > cols then
            vim.cmd([[CocCommand explorer --position floating --floating-position center --floating-height 40]])
        else
            vim.cmd(string.format([[CocCommand explorer --position right --width %d]], explorer_size))
        end
    end, {
        desc = 'Open Coc Explorer',
    })
end

function config.ufo()
    vim.o.foldcolumn = '0' -- '0' is not bad
    vim.o.foldlevel = 99 -- Using ufo provider need a large value, feel free to decrease the value
    vim.o.foldlevelstart = 99
    vim.o.foldenable = true

    -- Using ufo provider need remap `zR` and `zM`. If Neovim is 0.6.1, remap yourself
    vim.keymap.set('n', 'zR', require('ufo').openAllFolds)
    vim.keymap.set('n', 'zM', require('ufo').closeAllFolds)
    require('ufo').setup()
end

function config.bqf()
    require('bqf').setup({
        func_map = {
            split = '<C-s>',
            vsplit = '<C-v>',
        },
    })

    -- local cmd = vim.cmd
    -- local fn = vim.fn
    -- local api = vim.api
    -- https://github.com/neoclide/coc.nvim
    -- if you use coc-fzf, you should disable its CocLocationsChange event
    -- to make bqf work for <Plug>(coc-references)

    -- vim.schedule(function()
    --     cmd('au! CocFzfLocation User CocLocationsChange')
    -- end)
    vim.g.coc_enable_locationlist = 0
    cmd([[
    aug Coc
        au!
        au User CocLocationsChange lua _G.jumpToLoc()
    aug END
  ]])

    --   cmd([[
    --   nnoremap <silent> <leader>qd <Cmd>lua _G.diagnostic()<CR>
    -- ]])

    -- just use `_G` prefix as a global function for a demo
    -- please use module instead in reality
    function _G.jumpToLoc(locs)
        locs = locs or vim.g.coc_jump_locations
        fn.setloclist(0, {}, ' ', { title = 'CocLocationList', items = locs })
        local winid = fn.getloclist(0, { winid = 0 }).winid
        if winid == 0 then
            cmd('bo lw')
        else
            api.nvim_set_current_win(winid)
        end

        vim.defer_fn(function()
            local bufnr = vim.api.nvim_get_current_buf()
            vim.keymap.set('n', 'q', '<CMD>q<CR>', { buffer = bufnr })
        end, 10)
    end

    function _G.diagnostic()
        fn.CocActionAsync('diagnosticList', '', function(err, res)
            if err == vim.NIL then
                local items = {}
                for _, d in ipairs(res) do
                    local text = ('[%s%s] %s'):format(
                        (d.source == '' and 'coc.nvim' or d.source),
                        (d.code == vim.NIL and '' or ' ' .. d.code),
                        d.message:match('([^\n]+)\n*')
                    )
                    local item = {
                        filename = d.file,
                        lnum = d.lnum,
                        end_lnum = d.end_lnum,
                        col = d.col,
                        end_col = d.end_col,
                        text = text,
                        type = d.severity,
                    }
                    table.insert(items, item)
                end
                fn.setqflist({}, ' ', { title = 'CocDiagnosticList', items = items })

                cmd('bo cope')
            end
        end)
    end

    vim.keymap.set('n', '<leader>qd', _G.diagnostic, { silent = true, noremap = true })

    -- you can also subscribe User `CocDiagnosticChange` event to reload your diagnostic in quickfix
    -- dynamically, enjoy yourself :)
end

return config
