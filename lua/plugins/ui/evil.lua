local gl = require("galaxyline")
local gls = gl.section
gl.short_line_list = {"LuaTree", "vista", "dbui", "NvimTree", "flutterToolsOutline"}

local colors = {
  line_bg = "#213039",
  bg0 = "#213039",
  bg1 = "#242B48",
  bg2 = "#343F4C",
  dark0 = "#374D51",
  dark1 = "#1e272e",
  dark2 = "#34495e",
  white = "#d2dae2",
  clearwhite = "#ffffff",
  lightred = "#ff7979",
  red = "#ee5253",
  darkred = "#b33939",
  lightgreen = "#BBE67E",
  green = "#78e08f",
  darkgreen = "#218c74",
  cyan = "#12CBC4",
  darkcyan = "#38ada9",
  purple = "#D4BFFF",
  clearblue = "#40ffff",
  lightblue = "#34ace0",
  blue = "#227093",
  darkblue = "#3B3B98",
  orange = "#FEA47F",
  darkorange = "#F97F51",
  lightyellow = "#f9ca24",
  yellow = "#ffeaa7",
  darkyellow = "#ffb142",
  darkgray = "#84817a",
  gray = "#747d8c",
  pink = "#f78fb3"
}
local buffer_not_empty = function()
  if vim.fn.empty(vim.fn.expand("%:t")) ~= 1 then
    return true
  end
  return false
end
local function find_git_root()
  local path = vim.fn.expand("%:p:h")
  local get_git_dir = require("galaxyline.provider_vcs").get_git_dir
  return get_git_dir(path)
end
gls.left = {
  {
    ViMode = {
      provider = function()
        local mode_color = {
          n = colors.green,
          i = colors.purple,
          v = colors.pink,
          [""] = colors.pink,
          V = colors.pink,
          c = colors.green,
          no = colors.magenta,
          s = colors.orange,
          S = colors.orange,
          [""] = colors.orange,
          ic = colors.green,
          R = colors.purple,
          Rv = colors.purple,
          cv = colors.red,
          ce = colors.red,
          r = colors.cyan,
          rm = colors.cyan,
          ["r?"] = colors.cyan,
          ["!"] = colors.red,
          t = colors.red
        }
        vim.api.nvim_command("hi GalaxyViMode guifg=" .. mode_color[vim.fn.mode()])
        local mode = ""
        if vim.fn.mode() == "n" then
          mode = "Normal"
        elseif vim.fn.mode() == "i" then
          mode = "Insert"
        elseif vim.fn.mode() == "v" then
          mode = "Visual"
        elseif vim.fn.mode() == "V" then
          mode = "Visual"
        elseif vim.fn.mode() == "^V" then
          mode = "Visual"
        elseif vim.fn.mode() == "c" then
          mode = "Command"
        elseif vim.fn.mode() == "cv" then
          mode = "Command"
        end
        return "▊ " .. mode .. "   "
      end,
      highlight = {colors.red, colors.line_bg, "bold"}
    }
  },
  {
    FirstElement = {
      provider = function()
        return " "
      end,
      condition = buffer_not_empty,
      highlight = {colors.line_bg, colors.bg2}
    }
  },
  {
    FileIcon = {
      provider = "FileIcon",
      condition = buffer_not_empty,
      highlight = {require("galaxyline.provider_fileinfo").get_file_icon_color, colors.bg2}
    }
  },
  {
    FileName = {
      provider = {"FileName", "FileSize"},
      condition = buffer_not_empty,
      highlight = {colors.clearwhite, colors.bg2, "bold"},
      separator = "",
      separator_highlight = {colors.bg2, colors.line_bg}
    }
  },
  {
    GitIcon = {
      provider = function()
        return "  "
      end,
      condition = find_git_root,
      highlight = {colors.orange, colors.line_bg}
    }
  },
  {
    GitBranch = {
      provider = "GitBranch",
      condition = find_git_root,
      highlight = {colors.clearwhite, colors.line_bg, "bold"}
    }
  },
  {
    DiagnosticError = {
      provider = "DiagnosticError",
      icon = "  ",
      highlight = {colors.red, colors.line_bg}
    }
  },
  {
    DiagnosticWarn = {
      provider = "DiagnosticWarn",
      icon = "  ",
      highlight = {colors.blue, colors.line_bg}
    }
  }
}
gls.right = {
  {
    FileFormat = {
      provider = function()
        return vim.bo.filetype
      end,
      highlight = {colors.yellow, colors.bg2},
      separator = "",
      separator_highlight = {colors.bg2, colors.line_bg}
    }
  },
  {
    LineInfo = {
      provider = "LineColumn",
      highlight = {colors.clearwhite, colors.line_bg},
      separator = "",
      separator_highlight = {colors.bg2, colors.line_bg}
    }
  }
}
gls.short_line_left = {
  {
    SecondElement = {
      provider = function()
        return "▊ "
      end,
      condition = buffer_not_empty,
      highlight = {colors.dark2, colors.line_bg}
    }
  },
  {
    BufferType = {
      provider = "FileTypeName",
      highlight = {colors.dark2, colors.line_bg}
    }
  }
}
gls.short_line_right = {
  {
    BufferIcon = {
      provider = "BufferIcon",
      highlight = {colors.dark2, colors.line_bg}
    }
  },
  {
    ThridElement = {
      provider = function()
        return "▊ "
      end,
      condition = buffer_not_empty,
      highlight = {colors.dark2, colors.line_bg}
    }
  },
}
