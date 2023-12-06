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

function config.pairs()
  require('mini.pairs').setup()
end

function config.conform()
  local util = vim.lsp.util
  local lsp = vim.lsp
  local opts = { bufnr = 0 }
  --- @type conform.FormatterConfigOverride
  local function eslintFixAll()
    local eslint_lsp_client = util.get_active_client_by_name(opts.bufnr, 'eslint')
    if eslint_lsp_client == nil then
      return
    end

    local request
    if opts.sync then
      request = function(bufnr, method, params)
        eslint_lsp_client.request_sync(method, params, nil, bufnr)
      end
    else
      request = function(bufnr, method, params)
        eslint_lsp_client.request(method, params, nil, bufnr)
      end
    end

    local bufnr = util.validate_bufnr(opts.bufnr or 0)
    request(0, 'workspace/executeCommand', {
      command = 'eslint.applyAllFixes',
      arguments = {
        {
          uri = vim.uri_from_bufnr(bufnr),
          version = lsp.util.buf_versions[bufnr],
        },
      },
    })
  end
  local formatters_by_ft = {
    lua = { 'stylua' },
    json = { 'eslint' },
    scss = { 'eslint' },
    css = { 'eslint' },
    go = { 'gofmt' },
    python = { 'black' },

    javascript = { 'eslint' },
    javascriptreact = { 'eslint' },
    typescript = { 'eslint' },
    typescriptreact = { 'eslint' },

    vue = { 'prettier' },
  }

  if vim.fn.executable('nixpkgs-fmt') == 1 then
    formatters_by_ft['nix'] = { 'nixpkgs_fmt' }
  end

  vim.o.formatexpr = "v:lua.require'conform'.formatexpr()"

  pcall(require, 'mason')
  require('conform').setup({
    formatters_by_ft = formatters_by_ft,
    format_after_save = {
      lsp_fallback = true,
    },
  })

  vim.api.nvim_create_user_command('ConformFmt', function()
    require('conform').format({ bufnr = vim.api.nvim_get_current_buf() })
  end, { desc = 'Map conform.nvim plugin format to `ConformFmt`' })
end

function config.comment()
  require('mini.comment').setup({
    options = {
      custom_commentstring = function()
        return require('ts_context_commentstring.internal').calculate_commentstring() or vim.bo.commentstring
      end,
    },
    mappings = {
      -- Toggle comment (like `gcip` - comment inner paragraph) for both
      -- Normal and Visual modes
      comment = 'gc',

      -- Toggle comment on current line
      comment_line = 'gcc',

      -- Define 'comment' textobject (like `dgc` - delete whole comment block)
      textobject = 'gc',
    },
  })
end

function config.spectre()
  require('spectre').setup()
  vim.api.nvim_create_user_command('Spectre', function()
    require('spectre').toggle()
  end, { desc = 'Wrap spectre lua callable function' })
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

function config.lsp_format()
  require('lsp-format').setup({})
end

return config
