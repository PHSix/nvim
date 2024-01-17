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
      lsp_dynamic_workspace_symbols = {
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

function config.conform()
  local formatters_by_ft = {
    lua = { 'stylua' },
    python = { 'black' },

    vue = { 'prettier' },
  }

  if vim.fn.executable('nixpkgs-fmt') == 1 then
    formatters_by_ft['nix'] = { 'nixpkgs_fmt' }
  end

  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

  pcall(require, 'mason')
  require('conform').setup({
    formatters_by_ft = formatters_by_ft,
    -- format_after_save = {
    --   lsp_fallback = false,
    -- },
  })

  local function format()
    local clients = vim.lsp.get_active_clients({ bufnr = 0 })
    local client_names = vim.tbl_map(function(client)
      return client.name
    end, clients)

    if vim.tbl_contains(client_names, 'eslint') then
      vim.cmd([[EslintFixAll]])
      return
    end
    require('conform').format({ bufnr = vim.api.nvim_get_current_buf() })
  end

  vim.api.nvim_create_user_command('Format', format, { desc = 'Map conform.nvim plugin format to `ConformFmt`' })
end

function config.spectre()
  require('spectre').setup()
  vim.api.nvim_create_user_command('Spectre', function()
    require('spectre').toggle()
  end, { desc = 'Wrap spectre lua callable function' })
end

function config.lsp_format()
  require('lsp-format').setup({})
end

function config.winresizer()
  vim.g.winresizer_start_key = '<C-e>'
end

return config
