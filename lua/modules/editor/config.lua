local config = {}

function config.nvim_treesitter()
  local lazy = require('lazy')
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'javascript', 'typescript', 'tsx', 'lua', 'markdown', 'go', 'css', 'scss' },
    auto_install = true,
    highlight = {
      enable = true,
      disable = function(_, buf)
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

function config.fzf_lua()
  require('fzf-lua').setup({
    winopts = {
      height = 0.65,
      row = 0.7,
    },
    grep = {},
  })
end

return config

