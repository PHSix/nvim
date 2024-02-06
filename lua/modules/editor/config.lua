local config = {}

function config.nvim_treesitter()
  local lazy = require('lazy')
  vim.api.nvim_command('set foldmethod=expr')
  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'javascript', 'typescript', 'tsx', 'lua', 'markdown', 'go' },
    auto_install = false,
    highlight = {
      disable = function(lang, buf)
        if lang == 'help' then
          return true
        end
        return vim.api.nvim_buf_line_count(buf) > 5000
      end,
    },
  })
  vim.g.skip_ts_context_commentstring_module = true

  require('ts_context_commentstring').setup({ enable_autocmd = true })

  lazy.load({
    plugins = { 'Comment.nvim' },
  })
end

function config.lastplace()
  require('nvim-lastplace').setup({
    lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
    lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
    lastplace_open_folds = true,
  })
end

function config.flash()
  require('flash').setup({
    modes = {
      search = {
        enabled = false,
      },
      char = {
        enabled = false,
      },
    },
  })
end

function config.nvim_osc52()
  vim.keymap.set('v', 'fy', require('osc52').copy_visual)
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

return config
