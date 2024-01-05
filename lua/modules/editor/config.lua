local config = {}

function config.nvim_treesitter()
  local lazy = require('lazy')
  vim.api.nvim_command('set foldmethod=expr')
  vim.api.nvim_command('set foldexpr=nvim_treesitter#foldexpr()')
  require('nvim-treesitter.configs').setup({
    ensure_installed = { 'javascript', 'tsx', 'lua', 'markdown', 'go' },
    auto_install = false,
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

function config.neo_tree()
  require('neo-tree').setup({
    close_if_last_window = true,
    window = {
      position = 'right',
      width = 35,
      mappings = {
        ['o'] = { 'open' },
      },
    },
  })
end

function config.project()
  require('project_nvim').setup({})
end

function config.lastplace()
  require('nvim-lastplace').setup({
    lastplace_ignore_buftype = { 'quickfix', 'nofile', 'help' },
    lastplace_ignore_filetype = { 'gitcommit', 'gitrebase', 'svn', 'hgcommit' },
    lastplace_open_folds = true,
  })
end

function config.gitsigns()
  require('gitsigns').setup({
    signs = {
      add = { text = '▎' },
      change = { text = '▎' },
      delete = { text = '' },
      topdelete = { text = '' },
      changedelete = { text = '▎' },
      untracked = { text = '▎' },
    },
    on_attach = function(buffer)
      local gs = require('gitsigns')

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = buffer, desc = desc })
      end

      -- stylua: ignore start
      map("n", "]h", gs.next_hunk, "Next Hunk")
      map("n", "[h", gs.prev_hunk, "Prev Hunk")
      map({ "n", "v" }, "<leader>ghs", ":Gitsigns stage_hunk<CR>", "Stage Hunk")
      map({ "n", "v" }, "<leader>ghr", ":Gitsigns reset_hunk<CR>", "Reset Hunk")
      map("n", "<leader>ghS", gs.stage_buffer, "Stage Buffer")
      map("n", "<leader>ghu", gs.undo_stage_hunk, "Undo Stage Hunk")
      map("n", "<leader>ghR", gs.reset_buffer, "Reset Buffer")
      map("n", "<leader>ghp", gs.preview_hunk, "Preview Hunk")
      map("n", "<leader>ghb", function() gs.blame_line({ full = true }) end, "Blame Line")
      map("n", "<leader>ghd", gs.diffthis, "Diff This")
      map("n", "<leader>ghD", function() gs.diffthis("~") end, "Diff This ~")
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "GitSigns Select Hunk")
    end,
    current_line_blame = true,
  })
end

function config.flash()
  require('flash').setup({
    modes = {
      search = {
        enable = false,
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
