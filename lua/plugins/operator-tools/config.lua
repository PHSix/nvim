local config = {}
function config.faster()
  vim.api.nvim_set_keymap("n", "j", "<Plug>(faster_move_j)", {noremap = false, silent = true})
  vim.api.nvim_set_keymap("n", "k", "<Plug>(faster_move_k)", {noremap = false, silent = true})
end

function config.telescope()
  vim.cmd [[packadd plenary.nvim]]
  vim.cmd [[packadd popup.nvim]]
  vim.cmd [[packadd telescope-fzy-native.nvim]]
  local actions = require("telescope.actions")
  require("telescope").setup {
    defaults = {
      mappings = {
        i = {
          ["<esc>"] = actions.close,
          ["<C-j>"] = actions.move_selection_next,
          ["<C-k>"] = actions.move_selection_previous
        }
      },
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case"
      },
      prompt_position = "bottom",
      prompt_prefix = " 🍭",
      selection_caret = "> ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_defaults = {
        horizontal = {
          mirror = false
        },
        vertical = {
          mirror = false
        }
      },
      file_sorter = require "telescope.sorters".get_fuzzy_file,
      file_ignore_patterns = {},
      generic_sorter = require "telescope.sorters".get_generic_fuzzy_sorter,
      shorten_path = true,
      winblend = 0,
      width = 0.3,
      preview_cutoff = 120,
      results_height = 1,
      results_width = 0.5,
      border = {},
      borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
      color_devicons = true,
      use_less = true,
      set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
      file_previewer = require "telescope.previewers".vim_buffer_cat.new,
      grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
      qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker
    },
    extensions = {
      fzy_native = {
        override_generic_sorter = false,
        override_file_sorter = true
      }
    }
  }
end

function config.nvim_tree()
  local tree_cb = require "nvim-tree.config".nvim_tree_callback
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_hide_dotfiles = 0
  vim.g.nvim_tree_indent_markers = 1
  vim.g.nvim_tree_auto_close = 1
  vim.g.nvim_tree_git_hl = 1
  vim.g.nvim_tree_auto_open = 0
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_follow = 1
  vim.g.nvim_tree_bindings = {
    ["o"] = tree_cb("edit"),
    ["<CR>"] = tree_cb("edit"),
    ["R"] = tree_cb("refresh"),
    ["r"] = tree_cb("rename"),
    ["a"] = tree_cb("rename"),
    ["d"] = tree_cb("delete"),
    ["q"] = tree_cb("close"),
    ["p"] = tree_cb("paste"),
    ["u"] = tree_cb("dir_up"),
    ["<TAB>"] = tree_cb("preview"),
    ["cn"] = tree_cb("create"),
    ["zh"] = tree_cb("toggle_dotfiles")
  }
end
function config.chowcho()
  require("chowcho").setup {
    text_color = "#ffeaa7",
    bg_color = "#213039",
    active_border_color = "#D4BFFF",
    border_style = "rounded" -- 'default', 'rounded',
  }
end

function config.autopairs()
  require("nvim-autopairs").setup()
end

function config.fterm()
  require "FTerm".setup(
    {
      dimensions = {
        height = 0.5,
        width = 0.4,
        row = 0.5,
        col = 0.98
      },
      border = {
        horizontal = "─",
        vertical = "|",
        topLeft = "┌",
        topRight = "┐",
        bottomRight = "┘",
        bottomLeft = "└"
      }
    }
  )
end

function config.colorizer()
  vim.o.termguicolors = true
  require "colorizer".setup(
    {
      cpp = {rgb_fn = true},
      c = {rgb_fn = true},
      lua = {rgb_fn = true},
      css = {rgb_fn = true},
      scss = {rgb_fn = true},
      vue = {rgb_fn = true},
      sass = {rgb_fn = true},
      stylus = {rgb_fn = true},
      vim = {names = true},
      tmux = {names = false},
      "javascript",
      "javascriptreact",
      "typescript",
      "typescriptreact",
      "json",
      html = {
        mode = "foreground"
      },
      "*"
    }
  )
end

function config.multi_cursor()
  vim.g.VM_maps = {
    ["Select Operator"] = "gs",
    ["Find Under"] = "<C-d>",
    ["Undo"] = "u",
    ["Redo"] = "<C-r>",
    ["Increase"] = "+",
    ["Decrease"] = "-"
  }
end

function config.clipboard()
  require "clipboard-image".setup {
    default = {
      img_name = function()
        local img_dir = require "clipboard-image.config".get_config().img_dir()
        local index = 1
        for output in io.popen("ls " .. img_dir):lines() do
          if output == "image" .. index .. ".png" then
            index = index + 1
          else
            break
          end
        end
        return "image" .. index
      end
    },
    markdown = {
      img_dir = "img",
      img_dir_txt = "./img",
      affix = "![](%s)"
    }
  }
end

function config.peekup()
  require("nvim-peekup.config").on_keystroke["delay"] = "50ms"
  require("nvim-peekup.config").on_keystroke["delay"] = "50ms"
end

function config.smartinput()
  require("smartinput").setup {
    ["go"] = {";", ":=", ";"}
    -- ['javascript'] = {'.', '.', '+'},
  }
end

function config.vim_eft()
  vim.g.eft_ignorecase = true
end

function config.lir_nvim()
  vim.cmd [[packadd plenary.nvim]]
end
function config.kommentary()
  vim.api.nvim_set_keymap("n", ",cc", "<Plug>kommentary_line_default", {})
  vim.api.nvim_set_keymap("n", ",cu", "<Plug>kommentary_motion_default", {})
  vim.api.nvim_set_keymap("v", ",cc", "<Plug>kommentary_visual_default", {})
end

function config.fzf()
  -- vim.g.fzf_command_prefix = "Fzf"
end

function config.rest()
  vim.cmd [[packadd plenary.nvim]]
end
return config
