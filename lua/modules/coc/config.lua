local config = {}


vim.g.coc_data_home = '~/.config/coc_nvim'

vim.g.coc_global_extensions = {
  'coc-json',
  'coc-tsserver',
  'coc-marketplace',
  'coc-snippets',
  'coc-explorer',
  'coc-pairs',
  'coc-go',
  'coc-eslint',
}

function config.coc()
  vim.api.nvim_set_keymap('i', '<C-Space>', 'coc#refresh()', { silent = true, expr = true })
  -- vim.api.nvim_set_keymap(
  -- 	"i",
  -- 	"<TAB>",
  -- 	"pumvisible() ? '<C-n>' : '<TAB>'",
  -- 	{ noremap = true, silent = true, expr = true }
  -- )
  vim.api.nvim_set_keymap('i', '<S-TAB>', "pumvisible() ? '<C-p>' : '<C-h>'", { noremap = true, expr = true })
  vim.api.nvim_set_keymap('n', 'K', "<Cmd>call CocActionAsync('doHover')<CR>", { silent = true, noremap = true })
  vim.api.nvim_set_keymap('n', '<F2>', '<Plug>(coc-rename)', {})

  vim.cmd([[
inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#_select_confirm() :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ CheckBackspace() ? "\<TAB>" :
      \ coc#refresh()

function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'
inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
		\: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"
]])

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

  vim.keymap.set('n', '<M-x>', '<Cmd>Telescope coc commands<CR>', { silent = true })

  vim.keymap.set("n", "<C-n>", "<Cmd>CocTree<CR>", {silent = true})

  vim.api.nvim_create_user_command('CocTree', function()
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

