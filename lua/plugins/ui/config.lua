local config = {}
function config.dashboard()
  vim.cmd [[augroup dashboard_autocmd]]
  vim.cmd [[autocmd FileType dashboard lua vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<CR>', {noremap=true, silent=true})]]
  vim.cmd [[autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2]]
  vim.cmd [[augroup END]]
  vim.g.dashboard_default_executive = "telescope"
  -- vim.g.dashboard_default_executive = "fzf"
  -- vim.g.dashboard_preview_command = "cat"
  -- vim.g.dashboard_preview_pipeline = "lolcat"
  -- vim.g.dashboard_preview_file = vim.fn["getenv"]("HOME") .. "/.config/nvim/static/neovim.txt"
  -- vim.g.dashboard_preview_file_height = 8
  -- vim.g.dashboard_preview_file_width = 50
  vim.g.dashboard_custom_shortcut = {
    last_session = "         ",
    find_history = "<Ctrl-f>o",
    find_file = "<Ctrl-f>f",
    new_file = "<Ctrl-f>n",
    change_colorscheme = "<Ctrl-f>c",
    find_word = "<Ctrl-f>w",
    book_marks = "         "
  }
end

function config.hybrid()
  require("hybrid")
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

function config.nvim_bufferline()
  require("bufferline").setup {
    options = {
      numbers = "ordinal",
      show_buffer_close_icons = false,
      number_style = "",
      modified_icon = "✥",
      show_close_icon = true,
      buffer_close_icon = "",
      mappings = true,
      always_show_bufferline = false
    },
    highlights = {
      buffer_visible = {
        guifg = "#d2dae2",
        guibg = "#1e272e"
      },
      pick_visible = {
        guifg = "#d2dae2",
        guibg = "#1e272e"
      }
    }
  }
end

function config.indent_guides()
  require("indent_guides").setup(
    {
      indent_space_guides = true,
      indent_tab_guides = false,
      exclude_filetypes = {"help", "dashboard", "dashpreview", "NvimTree", "vista", "sagahover", "vista_kind"},
      -- indent_pretty_mode = true,
      even_colors = {fg = "#2a3834", bg = "#213049"},
      odd_colors = {fg = "#34495e", bg = "#213049"}
    }
  )
end
function config.blankline()
  vim.g.indentLine_char = "|"
  vim.g.indent_blankline_filetype_exclude = {
    "help",
    "dashboard",
    "flutterToolsOutline",
    "peek",
    "packer",
    "vista",
    "vista_kind"
  }
  vim.g.indent_blankline_char_highlight = "GitChange"
end

function config.statusline()
  local statusline = require("statusline")
  statusline.tabline = false
end

function config.galaxyline()
  vim.cmd [[packadd nvim-web-devicons]]
  require("plugins.ui.evil")
end
function config.goyo()
  vim.g.goyo_width = 120
end
function config.focus()
  local focus = require("focus")
  focus.enable = false
  focus.signcolumn = false
  focus.width = 120
end
function config.specs()
  require('specs').setup{ 
    popup = {
	-- Simple constant blend effect
        fader = function(blend, cnt)
            if cnt > 100 then
                return 80
            else return nil end
        end,
	-- Growing effect from left to right
        resizer = function(width, ccol, cnt)
            if width-cnt > 0 then
                return {width+cnt, ccol}
            else return nil end
        end,
    }
}
end

return config
