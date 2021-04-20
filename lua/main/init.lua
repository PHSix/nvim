-- local async
local load_comple = function()
  -- vim.cmd [[set guifont=FiraCode\ Nerd\ Font:h20]]
  require("main.opts")
  -- require("main.theme")
  require("main.packer")
  -- async =
  --   vim.loop.new_async(
  --   vim.schedule_wrap(
  -- function()
  require("main.event")
  require("mappings")
  -- async:close()
  -- end
  --   )
  -- )
  -- async:send()
end

load_comple()
