local events = {}
local utils = require('enhance.stsline.utils')
local then_call, tbl_get, encode_value = utils.then_call, utils.tbl_get, utils.encode_value
local fn, api, notify, log_levels = vim.fn, vim.api, vim.notify, vim.log.levels

local sep = '  '
local SKIP = { SKIP_SYMBOL = true }

---@class ComponentOption
---@field fetcher fun(params: any): string | nil
---@field events string[]
---@class Component
---@field source_opt ComponentOption
---@field value string
---@param opt ComponentOption
---@return Component
local function create_component(opt)
  local component = {
    source_opt = opt,
    value = opt.fetcher(),
  }

  local function fecher_callback()
    local result = opt.fetcher()
    if result ~= SKIP then
      component.value = result
    end
  end

  for _, event in ipairs(opt.events) do
    if events[event] == nil then
      events[event] = {}
    end

    table.insert(events[event], fecher_callback)
  end

  return component
end

local function subscribe(render_callback)
  local id = api.nvim_create_augroup('stsline', { clear = true })
  local p = nil
  local tasks = {}

  for event, callbacks in pairs(events) do
    local pattern = '*'

    if string.match(event, '^Coc') then
      pattern = event
      event = 'User'
    end

    api.nvim_create_autocmd(event, {
      group = id,
      pattern = pattern,
      callback = function()
        for _, cb in ipairs(callbacks) do
          table.insert(tasks, cb)
        end
        if p == nil then
          p = then_call(function()
            for _, t in ipairs(tasks) do
              t()
            end
            render_callback()
            tasks = {}
            p = nil
          end)
        end
      end,
    })
  end

  render_callback()
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
    events = { 'ModeChanged', 'BufEnter' },
    fetcher = function()
      return mode_map[fn.mode()][1]
    end,
  })

  local file_comp = create_component({
    events = { 'BufEnter', 'OptionSet' },
    fetcher = function()
      local filename = fn.expand('%:t')
      local buf = api.nvim_get_current_buf()

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
      return (vim.g.coc_git_status or '') .. (vim.b.coc_git_status or '')
    end,
  })

  local cursor_pos_comp = create_component({
    events = { 'CursorMoved', 'CursorMovedI', 'BufEnter' },
    fetcher = function()
      return string.format('Ln %d, Col %d', fn.line('.'), fn.col('.'))
    end,
  })

  local fileencoding_comp = create_component({
    events = { 'BufEnter', 'OptionSet' },
    fetcher = function()
      local cur_buf = api.nvim_get_current_buf()
      return string.format(
        'Spaces: %s  %s',
        api.nvim_get_option_value('shiftwidth', { buf = cur_buf }),
        string.upper(api.nvim_get_option_value('fileencoding', {
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

  vim.cmd([[hi link StsLine StatusLine]])
  vim.cmd([[hi! StsLine guifg=#928b95]])
  -- vim.cmd([[hi! StsLine ctermfg=245 ctermbg=235 guifg=#928b95 guibg=#262626]])

  local render_callback = function()
    local stl_tbl = {}
    for _, c in ipairs(comps) do
      local value = type(c) == 'string' and c or c.value
      if value ~= nil and value ~= SKIP then
        table.insert(stl_tbl, value)
      end
    end

    local stl = '%#StsLine#  ' .. table.concat(stl_tbl, sep) .. '  %*'

    local ok, result = pcall(api.nvim_get_option_value, 'laststatus', { scope = 'global' })
    if not ok or result ~= 3 then
      if result == 2 then
        notify('stsline only support laststatus=3 (global statusline mode)', log_levels.WARN)
      end
      return
    end

    ok, result = pcall(api.nvim_set_option_value, 'statusline', stl, { scope = 'global' })
    if ok == false or ok == nil then
      notify(stl, log_levels.ERROR)
    end
  end

  subscribe(render_callback)
end

vim.defer_fn(setup, 100)

