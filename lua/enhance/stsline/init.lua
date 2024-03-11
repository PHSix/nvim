local events = {}
local utils = require('enhance.stsline.utils')
local ref, render, then_call, tbl_get, encode_value =
  utils.ref, utils.render, utils.then_call, utils.tbl_get, utils.encode_value

local sep = '  '

---@class ComponentOption
---@field fetcher fun(): string | nil
---@field events string[]
---@class Component
---@field source_opt ComponentOption
---@field ref Ref
---@param opt ComponentOption
---@return Component
local function create_component(opt)
  local component = {
    source_opt = opt,
    ref = ref(opt.fetcher()),
  }

  for _, event in ipairs(opt.events) do
    if events[event] == nil then
      events[event] = {}
    end

    table.insert(events[event], function()
      component.ref.set(opt.fetcher())
    end)
  end

  return component
end

local function subscribe()
  local id = vim.api.nvim_create_augroup('stsline', { clear = true })

  for event, callbacks in pairs(events) do
    local pattern = '*'
    local p

    if string.match(event, '^Coc') then
      pattern = event
      event = 'User'
    end

    vim.api.nvim_create_autocmd(event, {
      group = id,
      pattern = pattern,
      callback = function()
        if p == nil then
          p = then_call(function()
            for _, cb in ipairs(callbacks) do
              cb()
            end
            p = nil
          end)
        end
      end,
    })
  end
end

local function setup()
  local mode_map = {
    ['n'] = { '-- Normal --', 'Normal' },
    ['no'] = { '-- Visual --', 'Visual' },
    ['nov'] = { '-- Visual --', 'Visual' },
    ['noV'] = { '-- Visual --', 'Visual' },
    ['no'] = { '-- Visual --', 'Visual' },
    ['niI'] = { '-- Normal --', 'Normal' },
    ['niR'] = { '-- Normal --', 'Normal' },
    ['niV'] = { '-- Normal --', 'Normal' },
    ['v'] = { '-- Visual --', 'Visual' },
    ['V'] = { '-- Visual --', 'Visual' },
    [''] = { '-- Visual --', 'Visual' },
    ['s'] = { '-- Visual --', 'Visual' },
    ['S'] = { '-- Visual --', 'Visual' },
    [''] = { '-- Visual --', 'Visual' },
    ['i'] = { '-- Insert --', 'Insert' },
    ['ic'] = { '-- Insert --', 'Insert' },
    ['ix'] = { '-- Insert --', 'Insert' },
    ['R'] = { '-- Replace --', 'Replace' },
    ['Rc'] = { '-- Replace --', 'Replace' },
    ['Rv'] = { '-- Normal --', 'Normal' },
    ['Rx'] = { '-- Normal --', 'Normal' },
    ['c'] = { '-- Commmand --', 'Command' },
    ['cv'] = { '-- Commmand --', 'Command' },
    ['ce'] = { '-- Commmand --', 'Command' },
    ['r'] = { '-- Replace --', 'Replace' },
    ['rm'] = { '-- Normal --', 'Normal' },
    ['r?'] = { '-- Normal --', 'Normal' },
    ['!'] = { '-- Normal --', 'Normal' },
    ['t'] = { '-- Normal --', 'Command' },
    ['nt'] = { '-- Terminal --', 'Command' },
  }
  local mode_comp = create_component({
    events = { 'ModeChanged' },
    fetcher = function()
      return mode_map[vim.fn.mode()][1]
    end,
  })

  local file_comp = create_component({
    events = { 'BufEnter', 'OptionSet' },
    fetcher = function()
      local filename = vim.fn.expand('%:t')
      local buf = vim.api.nvim_get_current_buf()

      if vim.bo[buf].modified and vim.bo[buf].modifiable then
        return string.format('%s  ', filename)
      end

      return filename
    end,
  })

  local function get_diags()
    local diagnostic = vim.b.coc_diagnostic_info

    if diagnostic == nil then
      diagnostic = {}
    end

    local error = tbl_get(diagnostic, 'error', 0)
    local warning = tbl_get(diagnostic, 'warning', 0)

    return {
      is_nil = error + warning == 0,
      error = error,
      warning = warning,
    }
  end

  local lsp_diags_comp = create_component({
    events = { 'CocDiagnosticChange', 'BufEnter' },
    fetcher = function()
      local diags = get_diags()
      if diags.is_nil then
        return ''
      end

      return string.format(' %s  %s', diags.error, diags.warning)
    end,
  })

  local divider_comp = '%='

  local coc_status_comp = create_component({
    events = { 'CocStatusChange', 'BufEnter' },
    fetcher = function()
      local status = vim.g.coc_status or ''
      if string.len(status) > 50 then
        status = status:sub(1, 50)
      end

      return encode_value(status)
    end,
  })

  local git_comp = create_component({
    events = { 'CocGitStatusChange', 'BufEnter' },
    fetcher = function()
      return vim.b.coc_git_status or ''
    end,
  })

  local cursor_pos_comp = create_component({
    events = { 'CursorMoved', 'CursorMovedI', 'BufEnter' },
    fetcher = function()
      return string.format('Ln %d, Col %d', vim.fn.line('.'), vim.fn.col('.'))
    end,
  })

  local fileencoding_comp = create_component({
    events = { 'BufEnter', 'OptionSet' },
    fetcher = function()
      local cur_buf = vim.api.nvim_get_current_buf()
      return string.format(
        'Spaces: %s  %s ',
        vim.api.nvim_get_option_value('shiftwidth', { buf = cur_buf }),
        string.upper(vim.api.nvim_get_option_value('fileencoding', {
          buf = cur_buf,
        }))
      )
    end,
  })

  local comps = {
    mode_comp,
    file_comp,
    lsp_diags_comp,
    divider_comp,
    coc_status_comp,
    git_comp,
    cursor_pos_comp,
    fileencoding_comp,
  }

  subscribe()

  vim.cmd([[hi! StsLine ctermfg=245 ctermbg=235 guifg=#928b95 guibg=#262626]])

  render(function()
    local stl_tbl = {}
    for _, comp in ipairs(comps) do
      if type(comp) == 'string' then
        table.insert(stl_tbl, comp)
      else
        table.insert(stl_tbl, comp.ref.get())
      end
    end

    local stl = '%#StsLine# '
      .. table.concat(
        vim.tbl_filter(function(s)
          return s ~= nil and s ~= ''
        end, stl_tbl),
        sep
      )
      .. ' %*'

    local ok, result = pcall(vim.api.nvim_get_option_value, 'laststatus', { scope = 'global' })
    if not ok or result ~= 3 then
      return
    end

    -- vim.notify(stl, vim.log.levels.TRACE)
    ok, result = pcall(vim.api.nvim_set_option_value, 'statusline', stl, { scope = 'global' })
    if ok == false or ok == nil then
      vim.notify(stl, vim.log.levels.ERROR)
    end
  end, 50)
end

vim.defer_fn(setup, 100)

