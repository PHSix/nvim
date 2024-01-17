local package = require('core.pack').package
local conf = require('modules.coc.config')

package({
	'neoclide/coc.nvim',
	branch = 'release',
	event = "VeryLazy",
	config = conf.coc
})


package({
	'kevinhwang91/nvim-ufo',
	dependencies = 'kevinhwang91/promise-async',
	event = { 'BufReadPost' },
	config = conf.ufo,
})
