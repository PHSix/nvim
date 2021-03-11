local fn = vim.fn
local jobstart = fn.jobstart
local function format_dart(_, data, _)
  if data[1] ~= "" then
    local fmt = fn.json_decode(data[1])["source"]
    _G.auto_replace(fmt)
  end
end
local opts = {on_stdout = format_dart}

function _G.format_dart_file()
  local current_file = fn.expand("%:p")
  local cmd = "flutter format -m " .. current_file
  jobstart(cmd, opts)
end

function _G.auto_replace(context)
  local back_line = fn.line(".")
  vim.cmd [[exec "norm! ggVGd"]]
  for _, value in pairs(fn.split(context, "\n")) do
    fn.append(fn.line("."), value)
    vim.cmd [[exec "norm! j"]]
  end
  vim.cmd [[exec "norm! ggdd"]]
  vim.cmd('exec "norm! ' .. back_line .. 'G"')
end
