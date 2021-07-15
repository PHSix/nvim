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
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case"
      },
      prompt_prefix = "🍭 ",
      selection_caret = "👉 ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "descending",
      layout_strategy = "horizontal",
      layout_config = {
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
      winblend = 0,
      border = {},
      borderchars = {"─", "│", "─", "│", "╭", "╮", "╯", "╰"},
      color_devicons = true,
      use_less = true,
      path_display = {},
      set_env = {["COLORTERM"] = "truecolor"}, -- default = nil,
      file_previewer = require "telescope.previewers".vim_buffer_cat.new,
      grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
      qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require "telescope.previewers".buffer_previewer_maker
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
  vim.g.nvim_tree_tab_open = 1
  vim.g.nvim_tree_add_trailing = 1
  vim.g.nvim_tree_disable_netrw = 0
  vim.g.nvim_tree_hijack_netrw = 0
  vim.g.nvim_tree_update_cwd = 1
  local tree_cb = require "nvim-tree.config".nvim_tree_callback
  vim.g.nvim_tree_bindings = {
    {key = {"<CR>", "o", "<2-LeftMouse>"}, cb = tree_cb("edit")},
    {key = {"<2-RightMouse>", "<C-]>"}, cb = tree_cb("cd")},
    {key = "<C-v>", cb = tree_cb("vsplit")},
    {key = "<C-x>", cb = tree_cb("split")},
    {key = "<C-t>", cb = tree_cb("tabnew")},
    {key = "<", cb = tree_cb("prev_sibling")},
    {key = ">", cb = tree_cb("next_sibling")},
    {key = "P", cb = tree_cb("parent_node")},
    {key = "<BS>", cb = tree_cb("close_node")},
    {key = "<S-CR>", cb = tree_cb("close_node")},
    {key = "<Tab>", cb = tree_cb("preview")},
    {key = "K", cb = tree_cb("first_sibling")},
    {key = "J", cb = tree_cb("last_sibling")},
    {key = "I", cb = tree_cb("toggle_ignored")},
    {key = "H", cb = tree_cb("toggle_dotfiles")},
    {key = "R", cb = tree_cb("refresh")},
    {key = {"a", "cn"}, cb = tree_cb("create")},
    {key = "d", cb = tree_cb("remove")},
    {key = "r", cb = tree_cb("rename")},
    {key = "<C-r>", cb = tree_cb("full_rename")},
    {key = "x", cb = tree_cb("cut")},
    {key = "c", cb = tree_cb("copy")},
    {key = "p", cb = tree_cb("paste")},
    {key = "y", cb = tree_cb("copy_name")},
    {key = "Y", cb = tree_cb("copy_path")},
    {key = "gy", cb = tree_cb("copy_absolute_path")},
    {key = "[c", cb = tree_cb("prev_git_item")},
    {key = "]c", cb = tree_cb("next_git_item")},
    {key = {"-", "u"}, cb = tree_cb("dir_up")},
    {key = "q", cb = tree_cb("close")},
    {key = "g?", cb = tree_cb("toggle_help")}
  }
end

function config.autopairs()
  require("nvim-autopairs").setup()
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

function config.smartinput()
  require("smartinput").setup {
    ["go"] = {";", ":=", ";"}
    -- ['javascript'] = {'.', '.', '+'},
  }
end

function config.vim_eft()
  vim.g.eft_ignorecase = true
end
function config.fzf()
  -- vim.g.fzf_command_prefix = "Fzf"
end

function config.rest()
  vim.cmd [[packadd plenary.nvim]]
end

function config.toggle_term()
  require("toggleterm").setup {
    -- size can be a number or function which is passed the current terminal
    size = function(term)
      if term.direction == "horizontal" then
        return 15
      elseif term.direction == "vertical" then
        return vim.o.columns * 0.70
      end
    end,
    open_mapping = [[<c-\>]],
    hide_numbers = true, -- hide the number column in toggleterm buffers
    shade_filetypes = {},
    shade_terminals = true,
    shading_factor = 3, -- the degree by which to darken to terminal colour, default: 1 for dark backgrounds, 3 for light
    start_in_insert = true,
    insert_mappings = true, -- whether or not the open mapping applies in insert mode
    persist_size = true,
    direction = "float",
    close_on_exit = true, -- close the terminal window when the process exits
    shell = vim.o.shell, -- change the default shell
    -- This field is only relevant if direction is set to 'float'
    float_opts = {
      -- The border key is *almost* the same as 'nvim_win_open'
      -- see :h nvim_win_open for details on borders however
      -- the 'curved' border is a custom border type
      -- not natively supported but implemented in this plugin.
      border = "single",
      width = 110,
      winblend = 3,
      highlights = {
        border = "Normal",
        background = "Normal"
      }
    }
  }
end
function config.cheatsheet()
end
function config.findr()
  function _G.Findr_auto_func(sign)
    if packer_plugins["nvim-compe"] and packer_plugins["nvim-compe"].loaded then
      Compe_toggle(sign)
    end
  end
  vim.cmd [[autocmd FileType findr-files call v:lua.Findr_auto_func(0) | autocmd BufWipeout <buffer> call v:lua.Findr_auto_func(1)]]
end
function config.spectre()
  vim.cmd [[command Spectre lua require('spectre').open()]]
end
function config.chadtree()
  vim.g.chadtree_settings = {
    ["keymap"] = {
      ["quit"] = {"q"},
      ["change_focus_up"] = {"u"},
      ["change_focus"] = {"c"},
      ["primary"] = {"o", "<enter>"},
      ["new"] = {"n"},
      ["rename"] = {"r"}
    },
    ["view"] = {
      ["width"] = 30
    }
  }
end

function config.shade()
  require "shade".setup(
    {
      overlay_opacity = 50,
      opacity_step = 1,
      keys = {
        brightness_up = "<C-Up>",
        brightness_down = "<C-Down>",
        toggle = "<Leader>s"
      }
    }
  )
end

function config.nvim_finder()
  vim.cmd [[PackerLoad popfix]]
  function _G.finder_command()
    require "finder".commands {}
  end
  vim.cmd [[command FinderCommand lua finder_command()]]
end
function config.auto_session()
  local opts = {
    log_level = "info",
    auto_session_enable_last_session = false,
    auto_session_root_dir = vim.fn.stdpath("data") .. "/sessions/",
    auto_session_enabled = true,
    auto_save_enabled = nil,
    auto_restore_enabled = nil,
    auto_session_suppress_dirs = nil
  }

  require("auto-session").setup(opts)
end
function config.nerdtree()
  vim.g.NERDTreeDirArrowExpandable = "▸"
  vim.g.NERDTreeDirArrowCollapsible = "▾"
end

return config
