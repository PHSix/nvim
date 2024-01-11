---@diagnostic disable: inject-field
local config = {}
local lsp_services = {
  {
    server = 'lua_ls',
    opts = {
      settings = {
        Lua = {
          completion = {
            callSnippet = 'Replace',
          },
          workspace = {

            checkThirdParty = false,
          },
        },
      },
    },
  },
  {
    server = 'jsonls',
    opts = function()
      return {
        settings = {
          json = {
            schemas = require('schemastore').json.schemas(),
            validate = { enable = true },
          },
        },
      }
    end,
  },
  {
    server = 'eslint',
    opts = {
      experimental = {
        useFlatConfig = true,
        codeActionOnSave = {
          enable = true,
          mode = 'all',
        },
      },
    },
  },
  { server = 'cssls' },
  { server = 'pyright' },
  { server = 'gopls', useLocal = true },
  { server = 'tailwindcss' },
  { server = 'angularls' },
  { server = 'html' },
  { server = 'volar' },
  { server = 'kotlin_language_server' },
}

function config.mason()
  require('mason').setup()
  local cmd_dependencies = {
    'stylua',
    'black',
  }

  for _, cmd in ipairs(cmd_dependencies) do
    if vim.fn.executable(cmd) == 0 then
      vim.notify(string.format('%s not found, mason will installing.', cmd))
      vim.cmd(string.format('MasonInstall %s', cmd))
    end
  end
  require('mason-lspconfig').setup({
    ensure_installed = vim.tbl_map(
      function(s)
        return s.server
      end,
      vim.tbl_filter(function(s)
        return not s.useLocal
      end, lsp_services)
    ),
  })
end

-- config server in this function
function config.nvim_lsp()
  pcall(require, 'mason')

  if vim.fn.executable('nix') == 1 then
    lsp_services = vim.tbl_filter(function(service)
      local cmd = require(string.format('lspconfig.server_configurations.%s', service.server)).default_config.cmd[1]
      return vim.fn.executable(cmd) == 1
    end, lsp_services)

    table.insert(lsp_services, {
      server = 'nil_ls',
      opts = {
        settings = {
          ['nil'] = {
            formatting = 'nixpkgs-fmt',

            nix = {
              maxMemoryMB = 1024 * 8,
              flake = {
                autoArchive = true,
                nixpkgsInputName = 'nixpkgs',
              },
            },
          },
        },
      },
    })
  end

  local lspconfig = require('lspconfig')

  require('neodev').setup()

  local capabilities = vim.tbl_deep_extend(
    'force',
    vim.lsp.protocol.make_client_capabilities(),
    -- {}
    require('epo').register_cap()
  )
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      if client == nil then
        return
      end

      -- client.server_capabilities.semanticTokensProvider = nil
    end,
  })

  require('typescript-tools').setup({
    settings = {
      jsx_close_tag = {
        enable = true,
        filetypes = { 'javascriptreact', 'typescriptreact' },
      },
    },
  })

  for _, service in ipairs(lsp_services) do
    local _opts = service.opts or {}

    --- @type table
    local opts = type(_opts) == 'function' and _opts() or _opts

    lspconfig[service.server].setup(vim.tbl_extend('force', opts, {
      capabilities = capabilities,
    }))
  end

  require('lspconfig')['typescript-tools'].setup({
    capabilities = capabilities,
  })

  vim.lsp.handlers['textDocument/diagnostic'] = vim.lsp.with(vim.lsp.diagnostic.on_diagnostic, {
    underline = false,
    update_in_insert = false,
  })

  vim.lsp.handlers['textDocument/hover'] = vim.lsp.with(vim.lsp.handlers.hover, {
    -- Use a sharp border with `FloatBorder` highlights
    border = 'solid',
  })

  vim.diagnostic.config({ virtual_text = false })
end

function config.lspsaga()
  require('lspsaga').setup({
    lightbulb = {
      enable = false,
    },
    rename = {
      keys = {
        quit = '<C-c>',
      },
    },
    diagnostic = {
      diagnostic_only_current = true,
      border_follow = false,
    },
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

function config.go_nvim()
  require('go').setup()

  -- Run gofmt + goimport on save

  local format_sync_grp = vim.api.nvim_create_augroup('GoImport', {})
  vim.api.nvim_create_autocmd('BufWritePre', {
    pattern = '*.go',
    callback = function()
      require('go.format').goimport()
    end,
    group = format_sync_grp,
  })
end

function config.epo()
  -- suggested completeopt
  vim.opt.completeopt = 'menu,menuone,noselect'

  -- default settings
  require('epo').setup({
    -- fuzzy match
    fuzzy = true,
    -- increase this value can aviod trigger complete when delete character.
    debounce = 50,
    -- when completion confrim auto show a signature help floating window.
    signature = false,
    -- vscode style json snippet path
    snippet_path = '/Users/ph/.config/nvim/vsc_snippets',
    -- border for lsp signature popup, :h nvim_open_win
    signature_border = 'rounded',
    -- lsp kind formatting, k is kind string "Field", "Struct", "Keyword" etc.
    kind_format = function(k)
      return k
    end,
  })

  -- For using enter as completion, may conflict with some autopair plugin
  vim.keymap.set('i', '<cr>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-y>'
    end

    return '<cr>'
  end, { expr = true, noremap = true })

  vim.keymap.set('i', '<TAB>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-n>'
    elseif vim.snippet.jumpable(1) then
      return '<cmd>lua vim.snippet.jump(1)<cr>'
    else
      return '<TAB>'
    end
  end, { expr = true })

  vim.keymap.set('i', '<S-TAB>', function()
    if vim.fn.pumvisible() == 1 then
      return '<C-p>'
    elseif vim.snippet.jumpable(-1) then
      return '<cmd>lua vim.snippet.jump(-1)<CR>'
    else
      return '<S-TAB>'
    end
  end, { expr = true })

  vim.keymap.set('i', '<C-e>', function()
    if vim.fn.pumvisible() == 1 then
      require('epo').disable_trigger()
    end
    return '<C-e>'
  end, { expr = true })
end

return config
