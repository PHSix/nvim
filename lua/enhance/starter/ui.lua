local api = vim.api
local fn = vim.fn
local map = require('ld.map')
local concat = require('ld.concat')
local ui = {
    buf = nil,
    header = nil,
}

function ui:render()
    local buf = self.buf or api.nvim_create_buf(false, true)
    local header = self.header or { '' }
    local win_id = api.nvim_get_current_win()
    local height = fn.winheight(win_id)
    local width = fn.winwidth(win_id)

    local header_content = vim.iter(header)
        :map(function(line)
            local len = string.len(line)
            local n = math.floor((width - len) / 2)
            local fix = string.rep(' ', n)

            return fix .. line .. fix
        end)
        :totable()

    local padding = vim.iter
end

return ui
