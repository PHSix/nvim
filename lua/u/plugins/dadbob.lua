local uv = vim.loop
local fn = vim.fn
local PATH = '~/.dbs.json'
uv.fs_open(fn.expand(PATH), "r", "438", function(err, fd)
	if err == nil then
		uv.fs_fstat(fd, function(err1, stat)
			if err == nil then
				uv.fs_read(fd, stat.size, 0, function(err, data)
					if err == nil then
						local ok, obj = pcall(vim.json.decode, data)
						if ok then
							vim.g.dbs = obj
						end
					end
				end)
			end
		end
		)
	end
end)
-- vim.cmd [[DBUIToggle]]

vim.keymap.set('n', "<c-m>", "<Cmd>DBUIToggle<CR>", {
	silent = true
})