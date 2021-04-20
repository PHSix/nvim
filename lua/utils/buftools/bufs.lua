-- params: 
-- key => a table include all loaded buffer id
-- value => a table include all loaded buffer path
local api = vim.api
local buf_loaded = function(id)
  return api.nvim_buf_is_loaded(id) and api.nvim_buf_get_option(id, "modifiable") and api.nvim_buf_get_name(id) ~= "" and
    api.nvim_buf_get_option(id, "filetype") ~= ""
end
local bufs = function()
  local cur_bufs = {}
  local bufs_name = {}
  for _, buf_id in pairs(api.nvim_list_bufs()) do
    if buf_loaded(buf_id) then
      table.insert(cur_bufs, buf_id)
    end
  end
  for _, buf_id in pairs(cur_bufs) do
    local bn = api.nvim_buf_get_name(buf_id)
    table.insert(bufs_name, bn)
  end
  return {
    keys = cur_bufs,
    value = bufs_name
  }
end

return bufs
