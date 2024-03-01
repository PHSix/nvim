local config = {}

function config.telescope()
  local actions = require('telescope.actions')
  require('telescope').setup({
    defaults = {
      layout_config = {
        horizontal = { prompt_position = 'top', results_width = 0.6 },
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
          -- ["<esc>"] = actions.close,
          ['<C-j>'] = actions.move_selection_next,
          ['<C-k>'] = actions.move_selection_previous,
          ['<C-d>'] = actions.delete_buffer,
        },
      },
    },
    pickers = {
      live_grep = {
        theme = 'ivy',
      },
      oldfiles = {
        theme = 'ivy',
      },
      find_files = {
        theme = 'ivy',
      },
      buffers = {
        theme = 'ivy',
      },
      commands = {
        theme = 'ivy',
      },
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true,
      },
    },
  })
  require('telescope').load_extension('fzy_native')
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

