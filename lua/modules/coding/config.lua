local config = {}

function config.telescope()
    local actions = require('telescope.actions')

    local function setup_telescope()
        local columns = vim.o.columns / 2
        local rows = vim.o.lines
        local layout = columns > rows and 'horizontal' or 'vertical'

        require('telescope').setup({
            defaults = {
                layout_config = {
                    horizontal = {
                        prompt_position = 'top',
                        results_width = 0.6,
                        preview = {
                            horizontal = 'right:55%',
                            vertical = 'up:55%',
                        },
                    },
                    vertical = { mirror = false },
                },
                sorting_strategy = 'ascending',
                file_previewer = require('telescope.previewers').vim_buffer_cat.new,
                grep_previewer = require('telescope.previewers').vim_buffer_vimgrep.new,
                qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
                prompt_prefix = '   ',
                buffer_previewer_maker = require('telescope.previewers').buffer_previewer_maker,
                mappings = {
                    n = { ['q'] = actions.close },
                    i = {
                        ['<C-j>'] = actions.move_selection_next,
                        ['<C-k>'] = actions.move_selection_previous,
                        ['<C-d>'] = actions.delete_buffer,
                    },
                },
            },
            pickers = {
                find_files = {
                    theme = 'dropdown',
                    previewer = false,
                    hidden = true,
                },
                live_grep = {
                    theme = 'ivy',
                },
                buffers = {
                    theme = 'dropdown',
                    previewer = false,
                },
                oldfiles = {
                    theme = 'dropdown',
                    previewer = false,
                },
                commands = {
                    theme = 'dropdown',
                    previewer = false,
                },
                help_tags = {
                    theme = 'dropdown',
                    previewer = false,
                },
                keymaps = {
                    theme = 'dropdown',
                    previewer = false,
                },
            },
            extensions = {
                fzf = {
                    override_generic_sorter = false,
                    override_file_sorter = true,
                },
            },
        })
    end

    setup_telescope()

    -- 动态切换 layout（适配窗口 resize 时预览窗方向）
    vim.api.nvim_create_autocmd('VimResized', {
        callback = function()
            setup_telescope()
        end,
    })

    require('telescope').load_extension('fzf')
end

function config.spectre()
    require('spectre').setup()
    vim.api.nvim_create_user_command('Spectre', function()
        require('spectre').toggle()
    end, { desc = 'Wrap spectre lua callable function' })
end

function config.winresizer()
    vim.g.winresizer_start_key = '<C-e>'
end

return config
