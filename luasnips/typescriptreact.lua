---@diagnostic disable: unused-local
local ls = require('luasnip')
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require('luasnip.util.events')
local ai = require('luasnip.nodes.absolute_indexer')
local extras = require('luasnip.extras')
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local conds = require('luasnip.extras.expand_conditions')
local postfix = require('luasnip.extras.postfix').postfix
local types = require('luasnip.util.types')
local parse = require('luasnip.util.parser').parse_snippet
local ms = ls.multi_snippet
local k = require('luasnip.nodes.key_indexer').new_key

local get_component_name = function()
  local filepath = vim.fn.expand('%d') or ''
  local fpf = vim.split(filepath, '/')
  local cname = 'Comp'

  if #fpf > 0 then
    if fpf[#fpf] == 'index.tsx' then
      cname = fpf[#fpf - 1]
    else
      cname = fpf[#fpf]
      cname = cname:sub(0, cname:len() - 4)
    end
  end

  return cname
end

return {
  s(
    { trig = 'cst', dscr = 'Create a state by call useState.' },
    fmt('const [{}, set{setter}] = useState({})', {
      i(1, 'state'),
      i(2, 'initialValue'),
      setter = l(l._1:sub(1, 1):upper() .. l._1:sub(2, -1), 1),
    })
  ),

  s({
    trig = 'rfc',
    dscr = 'React Function Component create by filepath.',
  }, {
    t({ "import { FC } from 'react';", '', '' }),
    f(function()
      return string.format('interface I%sProps {', get_component_name())
    end, {}),
    t({ '', '  value?: any;', '}', '', '' }),
    f(function()
      local name = get_component_name()
      return string.format('const %s: FC<I%sProps> = ({ value }) => {', name, name)
    end, {}),
    t({ '', '  return <div></div>;', '};', '', '' }),
    f(function()
      return string.format('export default %s;', get_component_name())
    end),
  }),
}
