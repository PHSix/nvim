require("bufferline").setup {
	options = {
		numbers = function(opts)
			return string.format("%s.)", opts.ordinal)
		end,
		indicator = {
			style = "none"
		},
		offsets = {
			{
				filetype = "coc-explorer",
				text = "EXPLORER",
				separator = true,
				text_align = "center"
			}
		}
	}
}
