local load_comple = function()
	require("main.opts")
  require("main.event")
  require("main.packer").init()
  require("mappings")
  vim.cmd [[command! PackerCompile lua require('packer').compile()]]
  vim.cmd [[command! PackerInstall lua require('packer').install()]]
  vim.cmd [[command! PackerUpdate lua require('packer').update()]]
  vim.cmd [[command! PackerSync lua require('packer').sync()]]
  vim.cmd [[command! PackerClean lua require('packer').clean()]]
end

load_comple()

