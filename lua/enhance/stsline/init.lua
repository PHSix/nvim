local utils = require('enhance.stsline.utils')
local tbl_get, encode_value = utils.tbl_get, utils.encode_value
local fn, api = vim.fn, vim.api

local sep = '  '

---@class ComponentOption
---@field fetcher fun(params: any): string | nil
---@field events string[]
---@class Component
---@field source_opt ComponentOption
---@field fetcher fun(params: any): string | nil
---@param opt ComponentOption
---@return Component
local function create_component(opt)
    local component = {
        source_opt = opt,
        fetcher = opt.fetcher,
    }

    return component
end

local function setup()
    local mode_map = {
        ['n'] = { '-- Normal --', 'Normal' },
        ['no'] = { '-- Visual --', 'Visual' },
        ['nov'] = { '-- Visual --', 'Visual' },
        ['noV'] = { '-- Visual --', 'Visual' },
        ['no'] = { '-- Visual --', 'Visual' },
        ['niI'] = { '-- Normal --', 'Normal' },
        ['niR'] = { '-- Normal --', 'Normal' },
        ['niV'] = { '-- Normal --', 'Normal' },
        ['v'] = { '-- Visual --', 'Visual' },
        ['V'] = { '-- Visual --', 'Visual' },
        [''] = { '-- Visual --', 'Visual' },
        ['s'] = { '-- Visual --', 'Visual' },
        ['S'] = { '-- Visual --', 'Visual' },
        [''] = { '-- Visual --', 'Visual' },
        ['i'] = { '-- Insert --', 'Insert' },
        ['ic'] = { '-- Insert --', 'Insert' },
        ['ix'] = { '-- Insert --', 'Insert' },
        ['R'] = { '-- Replace --', 'Replace' },
        ['Rc'] = { '-- Replace --', 'Replace' },
        ['Rv'] = { '-- Normal --', 'Normal' },
        ['Rx'] = { '-- Normal --', 'Normal' },
        ['c'] = { '-- Commmand --', 'Command' },
        ['cv'] = { '-- Commmand --', 'Command' },
        ['ce'] = { '-- Commmand --', 'Command' },
        ['r'] = { '-- Replace --', 'Replace' },
        ['rm'] = { '-- Normal --', 'Normal' },
        ['r?'] = { '-- Normal --', 'Normal' },
        ['!'] = { '-- Normal --', 'Normal' },
        ['t'] = { '-- Normal --', 'Command' },
        ['nt'] = { '-- Terminal --', 'Command' },
    }
    local mode_comp = create_component({
        fetcher = function()
            return mode_map[fn.mode()][1]
        end,
    })

    local file_comp = create_component({
        fetcher = function()
            local filename = fn.expand('%:t')
            local buf = api.nvim_get_current_buf()

            -- if filename:match('explorer') then
            --   notify(string.format('filename: %s, buffer: %d', filename, buf), log_levels.TRACE)
            -- end

            if vim.bo[buf].modified and vim.bo[buf].modifiable then
                return string.format('%s  ', filename)
            end

            return filename
        end,
    })

    local function get_diags()
        local diagnostic = vim.b.coc_diagnostic_info

        if diagnostic == nil then
            diagnostic = {}
        end

        local error = tbl_get(diagnostic, 'error', 0)
        local warning = tbl_get(diagnostic, 'warning', 0)

        return {
            is_nil = error + warning == 0,
            error = error,
            warning = warning,
        }
    end

    local lsp_diags_comp = create_component({
        fetcher = function()
            local diags = get_diags()
            if diags.is_nil then
                return ''
            end

            return string.format(' %s  %s', diags.error, diags.warning)
        end,
    })

    local divider_comp = '%='

    local coc_status_comp = create_component({
        fetcher = function()
            local status = vim.g.coc_status or ''
            if string.len(status) > 50 then
                status = status:sub(1, 50)
            end

            return encode_value(status)
        end,
    })

    local git_comp = create_component({
        fetcher = function()
            return (vim.g.coc_git_status or '') .. (vim.b.coc_git_status or '')
        end,
    })

    local cursor_pos_comp = create_component({
        fetcher = function()
            return string.format('Ln %d, Col %d', fn.line('.'), fn.col('.'))
        end,
    })

    local fileencoding_comp = create_component({
        fetcher = function()
            local cur_buf = api.nvim_get_current_buf()
            return string.format(
                'Spaces: %s  %s',
                api.nvim_get_option_value('shiftwidth', { buf = cur_buf }),
                string.upper(api.nvim_get_option_value('fileencoding', {
                    buf = cur_buf,
                }))
            )
        end,
    })

    local comps = {
        mode_comp,
        file_comp,
        lsp_diags_comp,
        divider_comp,
        coc_status_comp,
        git_comp,
        cursor_pos_comp,
        fileencoding_comp,
    }

    -- vim.cmd([[hi link StsLine StatusLine]])
    -- vim.cmd([[hi! StsLine guifg=#928b95]])
    local function set_hi_group()
        if vim.opt.background == 'dark' then
            vim.cmd([[hi! StsLine ctermfg=245 ctermbg=235 guifg=#928b95 guibg=#262626]])
        else
            vim.cmd([[hi! link StsLine NormalFloat]])
        end
    end

    set_hi_group()
    vim.api.nvim_create_augroup('stsline_augroup', { clear = true })
    vim.api.nvim_create_autocmd('ColorScheme', {
        pattern = '*',
        callback = set_hi_group,
    })
    -- vim.cmd([[hi! link StsLine StatusLine]])

    local render_callback = function(args)
        local stl_tbl = {}
        for _, c in ipairs(comps) do
            local value = type(c) == 'string' and c or c.fetcher(args)
            if value == nil then
                value = ''
            end
            table.insert(stl_tbl, value)
        end

        local stl = '%#StsLine#  ' .. table.concat(stl_tbl, sep) .. '  %*'

        return stl
    end

    _G.StslineRender = render_callback

    vim.o.statusline = '%!v:lua.StslineRender()'
end

vim.defer_fn(setup, 100)
