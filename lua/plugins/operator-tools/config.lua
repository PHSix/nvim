local config = {}
function config.faster()
	    vim.api.nvim_set_keymap("n", "j", "<Plug>(faster_move_j)", {noremap = false, silent = true})
    vim.api.nvim_set_keymap("n", "k", "<Plug>(faster_move_k)", {noremap = false, silent = true})

end



function config.telescope()
    vim.cmd [[packadd plenary.nvim]]
    require("telescope").setup {
      defaults = {
        prompt_position = "top",
        prompt_prefix = " 🍭",
        file_preview = require "telescope.previewers".vim_buffer_cat.new,
        grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
        qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous
          }
        }
      }
    }

end

function config.nvim_tree()
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_hide_dotfiles = 1
    vim.g.nvim_tree_indent_markers = 1
    vim.g.nvim_tree_auto_close = 1
    vim.g.nvim_tree_git_hl = 1
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_follow = 1
    vim.g.nvim_tree_bindings = {
      ["o"] = ":lua require'nvim-tree'.on_keypress('edit')<CR>",
      ["<CR>"] = ":lua require'nvim-tree'.on_keypress('edit')<CR>",
      ["r"] = ":lua require'nvim-tree'.on_keypress('rename')<CR>",
      ["dd"] = ":lua require'nvim-tree'.on_keypress('cut')<CR>",
      ["q"] = ":lua require'nvim-tree'.on_keypress('close')<CR>",
      ["p"] = ":lua require'nvim-tree'.on_keypress('paste')<CR>",
      ["u"] = ":lua require'nvim-tree'.on_keypress('dir_up')<CR>",
      ["<TAB>"] = ":lua require'nvim-tree'.on_keypress('preview')<CR>",
      ["n"] = ":lua require'nvim-tree'.on_keypress('create')<CR>"
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
        lua = {rgb_fn = true},
        css = {rgb_fn = true},
        scss = {rgb_fn = true},
        sass = {rgb_fn = true},
        stylus = {rgb_fn = true},
        vim = {names = true},
        tmux = {names = false},
        "javascript",
        "javascriptreact",
        "typescript",
        "typescriptreact",
        html = {
          mode = "foreground"
        }
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
    ["Decrease"] = "-",
  }
end

return config
