local async
local load_comple = function()
  vim.o.guifont = "Cascadia Code PL:h20"
  -- vim.cmd [[set guifont=FiraCode\ Nerd\ Font:h20]]
  require("main.opts")
  -- require("main.theme")
  require("main.packer").init()
  async =
    vim.loop.new_async(
    vim.schedule_wrap(
      function()
        require("main.event")
        require("main.dart")
        require("mappings")
        async:close()
      end
    )
  )
  async:send()
  vim.cmd [[command! PackerCompile lua require('packer').compile()]]
  vim.cmd [[command! PackerInstall lua require('packer').install()]]
  vim.cmd [[command! PackerUpdate lua require('packer').update()]]
  vim.cmd [[command! PackerSync lua require('packer').sync()]]
  vim.cmd [[command! PackerClean lua require('packer').clean()]]
end

load_comple()
