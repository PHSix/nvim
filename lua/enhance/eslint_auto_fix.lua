return {
  setup = function()
    local function format()
      local clients = vim.lsp.get_active_clients({ bufnr = 0 })

      for _, client in ipairs(clients) do
        if client.name == 'eslint' then
          -- --- @type lsp.Client
          -- local c = client
          vim.cmd([[EslintFixAll]])
          return
        end
      end
    end
    local id

    local function auto()
      id = vim.api.nvim_create_autocmd('BufWritePre', {
        pattern = '*',
        callback = function()
          if vim.bo.modified then
            format()
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
