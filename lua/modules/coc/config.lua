local config = {}

vim.g.coc_data_home = '~/.config/coc_nvim'

local ensure_installed_extensions = {
  'coc-json',
  'coc-tsserver',
  'coc-css',
  '@yaegassy/coc-volar',
  -- 'coc-eslint',
  -- 'coc-prettier',
  'coc-vimlsp',
  'coc-marketplace',
  'coc-snippets',
  'coc-explorer',
  'coc-pairs',
  'coc-go',
  'coc-sumneko-lua',
  'coc-git',
}

local function executable(cmd)
  return vim.fn.executable(cmd) == 1
end

if executable('nix') then
  if executable('nil') then
    table.insert(ensure_installed_extensions, 'coc-nil')
  end

  if executable('lua-language-server') then
    local serverDir

    --- @type string[]
    local paths = vim.fn.split(vim.env.PATH, ':')

    for _, path in ipairs(paths) do
      local match = string.match(path, [[lua.language.server]])
      if match ~= nil then
        serverDir = path:sub(0, string.len(path) - 4)
        vim.g.coc_user_config = {
          ['Lua.misc.parameters'] = {
            '--metapath',
            '~/.cache/sumneko_lua/meta',
            '--logpath',
            '~/.cache/sumneko_lua/log',
          },
          ['sumneko-lua.serverDir'] = serverDir,
        }
        goto break_out
      end
    end

    ::break_out::
  end
end

vim.g.coc_global_extensions = ensure_installed_extensions

function config.coc()
  vim.api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', { silent = true, expr = true })
  vim.api.nvim_set_keymap('i', '<S-TAB>', "pumvisible() ? '<C-p>' : '<C-h>'", { noremap = true, expr = true })

  vim.keymap.set('i', '<Cr>', function()
    if vim.fn['coc#pum#visible']() == 1 then
      return vim.fn['coc#pum#confirm']()
    else
      return '<Cr>'
    end
  end, { silent = true, noremap = true, expr = true })

  vim.g.coc_snippet_next = '<tab>'

  vim.api.nvim_create_augroup('coc_patch_autocmd', { clear = true })

  vim.api.nvim_create_autocmd({ 'ModeChanged' }, {
    group = 'coc_patch_autocmd',
    pattern = '*',
    callback = function()
      if vim.fn.mode() == 's' then
        local key = vim.api.nvim_replace_termcodes('<C-r>_', true, false, true)
        vim.api.nvim_feedkeys(key, 's', false)
      end
    end,
    once = false,
  })

  vim.api.nvim_create_autocmd({ 'User' }, {
    group = 'coc_patch_autocmd',
    pattern = { 'CocStatusChange', 'CocDiagnosticChange' },
    callback = function()
      vim.opt.statusline = vim.opt.statusline
    end,
  })

  vim.api.nvim_create_autocmd({ 'BufEnter' }, {
    group = 'coc_patch_autocmd',
    pattern = '*',
    callback = function()
      vim.defer_fn(function()
        if vim.bo.filetype == 'coc-explorer' and vim.api.nvim_win_get_config(0).relative ~= '' then
          vim.api.nvim_win_set_config(0, {
            zindex = 10,
          })
        end
      end, 100)
    end,
  })

  vim.api.nvim_create_user_command('CocExplorer', function()
    vim.cmd([[CocCommand explorer --position right]])
  end, {
    desc = 'Open Coc Explorer',
  })

  vim.api.nvim_create_user_command('CocFormat', function()
    vim.fn.CocActionAsync('format')
  end, {
    desc = 'coc lsp format with async',
  })

  vim.api.nvim_create_user_command('CocMarketplace', function()
    vim.cmd([[CocList marketplace]])
  end, {
    desc = 'open coc marketplace',
  })

  vim.g.coc_quickfix_open_command = 'vsplit'

  vim.cmd([[
    hi link CocGitAddedSign GitNew
    hi link CocGitRemovedSign GitDeleted
    hi link CocGitTopRemovedSign GitDeleted
    hi link CocGitChangeRemovedSign GitDeleted
    hi link CocGitChangedSign GitDirty
  ]])
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

