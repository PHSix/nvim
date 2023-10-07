---@diagnostic disable: inject-field
local concat = require('ld.concat')
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
  { server = 'eslint' },
  { server = 'cssls' },
  { server = 'pyright' },
  { server = 'gopls', useLocal = true },
  { server = 'tailwindcss' },
  { server = 'angularls' },
  { server = 'html' },
  { server = 'volar' },
}

local else_dependences = {
  'stylua',
  'black',
  'tsserver',
}

function config.mason()
  require('mason').setup()
  require('mason-lspconfig').setup(concat({
    ensure_installed = vim.tbl_map(
      function(s)
        return s.server
      end,
      vim.tbl_filter(function(s)
        return not s.useLocal
      end, lsp_services)
    ),
  }, else_dependences))
end

-- config server in this function
function config.nvim_lsp()
  pcall(require, 'mason')
  local lspconfig = require('lspconfig')

  require('neodev').setup()

  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  capabilities.textDocument.foldingRange = {
    dynamicRegistration = false,
    lineFoldingOnly = true,
  }

  vim.api.nvim_create_autocmd('LspAttach', {
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      client.server_capabilities.semanticTokensProvider = nil
    end,
  })

  for _, service in ipairs(lsp_services) do
    local _opts = service.opts or {}

    --- @type table
    local opts = type(_opts) == 'function' and _opts() or _opts

    lspconfig[service.server].setup(vim.tbl_extend('force', opts, {
      capabilities = capabilities,
    }))
  end

  require('typescript-tools').setup({
    settings = {
      jsx_close_tag = {
        enable = true,
        filetypes = { 'javascriptreact', 'typescriptreact' },
      },
    },
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

  local signs = { Error = ' ', Warn = ' ', Hint = ' ', Info = ' ' }
  for type, icon in pairs(signs) do
    local hl = 'DiagnosticSign' .. type
    vim.fn.sign_define(hl, { text = icon, texthl = hl, numhl = hl })
  end
end

function config.coq()
  vim.g.coq_settings = {
    keymap = {
      pre_select = true,
    },
  }
end

function config.ddc() end

function config.nvim_cmp()
  local nvim_cmp = require('cmp')
  local kind_icons = {
    Text = '',
    Method = '󰆧',
    Function = '󰊕',
    Constructor = '',
    Field = '󰇽',
    Variable = '󰂡',
    Class = '󰠱',
    Interface = '',
    Module = '',
    Property = '󰜢',
    Unit = '',
    Value = '󰎠',
    Enum = '',
    Keyword = '󰌋',
    Snippet = '',
    Color = '󰏘',
    File = '󰈙',
    Reference = '',
    Folder = '󰉋',
    EnumMember = '',
    Constant = '󰏿',
    Struct = '',
    Event = '',
    Operator = '󰆕',
    TypeParameter = '󰅲',
  }

  --- @type cmp.ComparatorFunction
  local types = require('cmp.types')
  local function keyword_up_compare(entry1, entry2)
    local k1 = entry1:get_kind() == types.lsp.CompletionItemKind.Keyword
    local k2 = entry2:get_kind() == types.lsp.CompletionItemKind.Keyword

    if k1 and k2 then
      return nil
    elseif k1 then
      return false
    elseif k2 then
      return true
    end
  end

  nvim_cmp.setup({
    enabled = function()
      return vim.bo.buflisted
    end,
    snippet = {
      expand = function(args)
        require('luasnip').lsp_expand(args.body)
      end,
    },
    completion = {
      completeopt = 'menu,menuone,noinsert',
      keyword_pattern = [[\%(-\?\d\+\%(\.\d\+\)\?\|\h\w*\%(-\w*\)*\)]],
    },
    window = {
      completion = nvim_cmp.config.window.bordered({ border = 'single' }),
      documentation = nvim_cmp.config.window.bordered({ border = 'single' }),
    },
    sources = nvim_cmp.config.sources({
      { name = 'luasnip' },
      {
        name = 'nvim_lsp',
        entry_filter = function(entry, _)
          return require('cmp.types').lsp.CompletionItemKind[entry:get_kind()] ~= 'Text'
        end,
      },
      { name = 'path' },
      { name = 'nvim_lua' },
      { name = 'buffer' },
    }),
    mapping = nvim_cmp.mapping.preset.insert({
      ['<C-d>'] = nvim_cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = nvim_cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = nvim_cmp.mapping.complete(),
      ['<CR>'] = nvim_cmp.mapping.confirm({ select = true }),
    }),
    formatting = {
      format = function(entry, vim_item)
        -- Kind icons
        vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind) -- This concatonates the icons with the name of the item kind
        -- Source
        vim_item.menu = ({
          buffer = '[Buffer]',
          nvim_lsp = '[LSP]',
          luasnip = '[LuaSnip]',
          nvim_lua = '[Lua]',
          latex_symbols = '[LaTeX]',
        })[entry.source.name]

        return vim_item
      end,
    },
    sorting = {
      comparators = {
        nvim_cmp.config.compare.offset,
        nvim_cmp.config.compare.exact,
        nvim_cmp.config.compare.score,
        nvim_cmp.config.compare.recently_used,
        nvim_cmp.config.compare.kind,
        nvim_cmp.config.compare.order,

        keyword_up_compare,
      },
    },
  })
end

function config.luasnip()
  local snip_path = '~/.config/nvim/luasnips'
  require('luasnip.loaders.from_snipmate').load()
  require('luasnip.loaders.from_lua').load({ paths = snip_path })
  require('luasnip').filetype_extend('typescriptreact', { 'typescript', 'javascript' })
  require('luasnip').filetype_extend('typescript', { 'javascript' })

  vim.api.nvim_create_user_command('LuaSnipEdit', function()
    local uv = vim.loop

    uv.fs_access(
      snip_path,
      'R',
      vim.schedule_wrap(function(err, permission)
        if err ~= nil or permission == false then
          vim.cmd(string.format('!touch %s/%s.lua', snip_path, vim.bo.filetype))
          require('luasnip.loaders.from_lua').load({ paths = snip_path })
        end
        require('luasnip.loaders').edit_snippet_files()
      end)
    )
  end, { desc = 'Edit LuaSnip in lua.' })
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
    },
  })
end

function config.lsp_lines()
  require('lsp_lines').setup()
  vim.diagnostic.config({ virtual_text = false })
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

return config
