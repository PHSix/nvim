local fn = vim.fn
local cmd = vim.cmd

local bg = "#0F1419"
local fg = "#E6E1CF"
local black = "#212733"
local darkgray = "#272d38"
local gray = "#303540"
local text = "#d9d7ce"
local white = "#c7c7c7"
local blue = "#5ccfe6"
local cyan = "#95e6cb"
local green = "#bae67e"
local orange = "#ffa759"
local purple = "#d4bfff"
local red = "#ff3333"
local yellow = "#151A1E"

local hi_group = {
  {"Normal", bg = bg, fg = fg},
  {"ColorColumn", bg=yellow},
  {"CursorLine", bg=yellow},
}

local async =
  vim.loop.new_async(
  vim.schedule_wrap(
    function()
      for _, v in pairs(hi_group) do
        local gbg = v["bg"] or "NONE"
        local gfg = v["fg"] or "NONE"
        cmd("hi! " .. v[1] .. " guibg=" .. gbg .. " guifg=" .. gfg)
      end
    end
  )
)

local function config()
  cmd("highlight clear")
  vim.o.background = "dark"
  vim.o.termguicolors = true
  if fn.exists("syntax_on") then
    vim.cmd("syntax reset")
  end
  vim.g.gitgutter_sign_added = "▊"
  vim.g.gitgutter_sign_modified = "▊"
  vim.g.gitgutter_sign_removed = "▊"
  vim.g.gitgutter_sign_removed_first_line = "▊"
  vim.g.gitgutter_sign_removed_above_and_below = "▊"
  async:send()
end

config()

return
