return {
  setup = function()
    local function format()
      local clients = vim.lsp.get_active_clients({ bufnr = 0 })
      local client_names = vim.tbl_map(function(client)
        return client.name
      end, clients)

      if vim.tbl_contains(client_names, 'eslint') then
        vim.cmd([[EslintFixAll]])
        return
      end

      vim.lsp.buf.format({ async = false })
    end
    vim.api.nvim_create_user_command('LspFormat', format, {})
    local id

    local function auto()
      id = vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function()
          if vim.bo.modified then
            format()
            -- vim.lsp.buf.format({ async = false })
          end
        end,
      })
    end

    id = auto()

    vim.api.nvim_create_user_command('AutoFormatToggle', function()
      if id ~= nil then
        vim.api.nvim_del_autocmd(id)
        id = nil
      else
        auto()
      end
    end, {})
  end,
}
