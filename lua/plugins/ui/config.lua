local config = {}
function config.dashboard()
  vim.cmd [[augroup dashboard_autocmd]]
  vim.cmd [[autocmd FileType dashboard lua vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<CR>', {noremap=true, silent=true})]]
  vim.cmd [[autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2]]
  vim.cmd [[augroup END]]
  vim.g.dashboard_default_executive = "telescope"
  vim.g.dashboard_preview_command = "cat"
  vim.g.dashboard_preview_pipeline = "lolcat"
  vim.g.dashboard_preview_file = vim.fn["getenv"]("HOME") .. "/.config/nvim/static/neovim.txt"
  vim.g.dashboard_preview_file_height = 8
  vim.g.dashboard_preview_file_width = 50
  vim.g.dashboard_custom_shortcut = {
    last_session = "<Ctrl-f>l",
    find_history = "<Ctrl-f>o",
    find_file = "<Ctrl-f>f",
    new_file = "<Ctrl-f>n",
    change_colorscheme = "<Ctrl-f>c",
    find_word = "<Ctrl-f>w",
    book_marks = "<Ctrl-f>b"
  }
end

function config.hybrid()
  require("hybrid").config()
end

function config.hardline()
  vim.cmd [[augroup hardline_showmode]]
  vim.cmd [[autocmd InsertEnter * ++once set showmode]]
  vim.cmd [[augroup END]]
  require("hardline").setup {
    theme = "nord",
    sections = {
      {class = "mode", item = require("hardline.parts.mode").get_item},
      {class = "error", item = require("hardline.parts.lsp").get_error},
      {class = "warning", item = require("hardline.parts.lsp").get_warning},
      {class = "med", item = "%="},
      {class = "high", item = require("hardline.parts.cwd").get_item, hide = 80},
      {class = "high", item = require("hardline.parts.filename").get_item, hide = 80},
      {class = "low", item = require("hardline.parts.filetype").get_item, hide = 80},
      {class = "mode", item = require("hardline.parts.line").get_item}
    }
  }
end

function config.barbar()
  local buf = {}
  buf["animation"] = false
  buf["icons"] = "both"
  buf["auto_hide"] = true
  buf["closable"] = false
  buf["maximum_padding"] = 2
  vim.g.bufferline = buf
end

function config.indentLine()
  vim.g.indentLine_char = "|"
  vim.g.indentLine_fileTypeExclude = {"help", "dashboard", "flutterToolsOutline"}
end
function config.rainbow()
  require "nvim-treesitter.configs".setup {
    rainbow = {
      enable = true
    }
  }
end

return config
