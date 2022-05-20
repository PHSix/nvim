local opts = require(_G.p("core.opts"))
local packer = require(_G.p("core.packer"))
local keymap = require(_G.p("core.keymap"))
local autocmd = require(_G.p("core.autocmd"))
local hack = require(_G.p("hack"))
vim.g.python3_host_prog = "/bin/python3"
require("coolors").debug("light")

opts.setup()
keymap.setup()
autocmd.setup()
hack.setup()
packer.setup()
