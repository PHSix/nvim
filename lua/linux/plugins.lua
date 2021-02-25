local execute = vim.api.nvim_command
local fn = vim.fn
local execu_install = false
local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. install_path)
  execu_install = true
end
vim.cmd [[packadd packer.nvim]]
local use = require("packer").use
require("packer").init(
  {
    clone_timeout = 30,
    transitive_opt = true
  }
)
require("packer").startup(
  function()
    use {
      "wbthomason/packer.nvim",
      opt = true
    }
    use {
      "lilydjwg/fcitx.vim",
      event = {"InsertEnter *"}
    }
    use {
      "tpope/vim-surround",
      keys = {"c", "d", "y"}
    }
    use {
      "nvim-treesitter/nvim-treesitter",
      event = {"BufRead *"},
      run = ":TSUpdate",
      config = function()
        require "nvim-treesitter.configs".setup {
          ensure_installed = "maintained",
          highlight = {
            enable = true,
            disable = {"rust"}
          }
        }
      end
    }
    use {
      "hardcoreplayers/dashboard-nvim",
      setup = function()
        local vim = vim
        vim.cmd [[autocmd FileType dashboard lua vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<CR>', {noremap=true, silent=true})]]
        vim.g.dashboard_default_executive = "telescope"
        vim.g.dashboard_preview_command = "cat"
        vim.g.dashboard_preview_pipeline = "lolcat"
        vim.g.dashboard_preview_file = vim.fn["getenv"]("HOME") .. "/.config/nvim/static/neovim.txt"
        vim.g.dashboard_preview_file_height = 8
        vim.g.dashboard_preview_file_width = 50
        vim.cmd("autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2")

        vim.api.nvim_set_keymap("n", "<C-f>s", ":<C-u>SessionSave<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<C-f>l", ":<C-u>SessionLoad<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<C-f>o", ":DashboardFindHistory<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<C-f>f", ":DashboardFindFile<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<C-f>c", ":DashboardChangeColorscheme<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<C-f>m", ":DashboardJumpMark<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<C-f>w", ":DashboardFindWord<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<C-f>n", ":DashboardNewFile<CR>", {noremap = true, silent = true})

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
    }
    use {
      "rhysd/accelerated-jk",
      keys = {{"n", "j"}, {"n", "k"}},
      disable = true,
      config = function()
        -- local vim = vim
        -- vim.api.nvim_set_keymap("n","j","<Plug>(accelerated_jk_gj_position)",{noremap = false, silent = true})
        -- vim.api.nvim_set_keymap("n","k","<Plug>(accelerated_jk_gk_position)",{noremap = false, silent = true})
      end
    }
    use {
      "gcmt/wildfire.vim",
      keys = {"n", "<CR>"}
    }
    use {
      "junegunn/vim-easy-align",
      keys = {{"v", "ga"}, {"n", "ga"}},
      config = function()
        local vim = vim
        vim.api.nvim_set_keymap("n", "ga", "<Plug>(EasyAlign)", {silent = true})
        vim.api.nvim_set_keymap("v", "ga", "<Plug>(EasyAlign)", {silent = true})
      end
    }
    use {
      "skywind3000/asynctasks.vim",
      requires = {"skywind3000/asyncrun.vim", keys = {"R"}},
      opt = true,
      keys = {"R"},
      config = function()
        local vim = vim
        vim.g.asyncrun_open = 9
        vim.g.asynctasks_rtp_config = "asynctasks.ini"
        vim.api.nvim_set_keymap("n", "R", ":lua StartR()<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "B", ":AsyncTask file-build<CR>", {noremap = true, silent = true})
      end
    }
    use {
      "dart-lang/dart-vim-plugin",
      ft = {"dart"}
    }
    use {
      "dhruvasagar/vim-table-mode",
      opt = true,
      ft = {"markdown"}
    }
    use {
      "p00f/nvim-ts-rainbow",
      event = "BufReadPost *",
      config = function()
        require "nvim-treesitter.configs".setup {
          rainbow = {
            enable = true
          }
        }
      end
    }

    use {
      "norcalli/nvim-colorizer.lua",
      config = function()
        vim.o.termguicolors = true
        require "colorizer".setup(
          {
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
    }
    use {
      "npxbr/glow.nvim",
      cmd = {"Glow"}
    }
    use {
      "liuchengxu/vista.vim",
      cmd = {"Vista"},
      config = function()
        local vim = vim
        vim.g.vista_icon_indent = {"╰─▸ ", "├─▸ "}
        vim.cmd("let g:vista#renderer#enable_icon = 1")
        vim.cmd [[autocmd FileType vista,vista_kind nnoremap <buffer> <silent> o :<c-u>call vista#cursor#FoldOrJump()<CR>]]
      end
    }
    use {
      "nvim-telescope/telescope.nvim",
      cmd = {"Telescope"},
      requires = {
        {"nvim-lua/popup.nvim", opt = true},
        {"nvim-lua/plenary.nvim", opt = true},
        {"nvim-telescope/telescope-packer.nvim", opt = true}
      },
      config = function()
        vim.cmd [[packadd popup.nvim]]
        vim.cmd [[packadd plenary.nvim]]
        vim.cmd [[packadd telescope-packer.nvim]]
        vim.api.nvim_set_keymap(
          "n",
          "<C-f>p",
          ":lua require('telescope').extensions.packer.plugins(opts)<CR>",
          {noremap = true, silent = true}
        )
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
    }
    use {
      "voldikss/vim-translator",
      keys = {"<leader>tt"},
      config = function()
        local vim = vim
        vim.api.nvim_set_keymap("n", "<leader>tt", "<Plug>TranslateW", {noremap = false, silent = true})
        vim.api.nvim_set_keymap("v", "<leader>tt", ":'<,'>TranslateW<CR>", {noremap = false, silent = true})
      end
    }
    use {
      "windwp/nvim-autopairs",
      event = {"BufEnter *"},
      config = function()
        require("nvim-autopairs").setup()
      end
    }
    use {
      "lewis6991/gitsigns.nvim",
      event = {"BufReadPre *"},
      requires = {"nvim-lua/plenary.nvim", opt = true},
      config = function()
        vim.cmd [[packadd plenary.nvim]]
        require("gitsigns").setup {
          keymaps = {
            noremap = false,
            buffer = false
          }
        }
      end
    }
    use {
      "tyru/caw.vim",
      keys = {",c"},
      config = function()
        local vim = vim
        vim.api.nvim_set_keymap("n", ",c", "<Plug>(caw:prefix)", {noremap = false, silent = true})
        vim.api.nvim_set_keymap("x", ",c", "<Plug>(caw:prefix)", {noremap = false, silent = true})
      end
    }
    use {
      "/home/ph/Github/nvim-hybrid",
      requires = {"ms-jpq/neovim-async-tutorial"},
      config = function()
        vim.cmd("colorscheme nvim-hybrid")
      end
    }
    use {
      "glepnir/lspsaga.nvim",
      keys = {"K", "<leader>ca", "<leader>rn", "[g", "]g", "gd", "gp"},
      config = function()
        local vim = vim
        vim.api.nvim_set_keymap("n", "K", ":lua vim.lsp.buf.hover()<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap(
          "n",
          "<leader>rn",
          ":lua require('lspsaga.rename').rename()<CR>",
          {noremap = true, silent = true}
        )
        vim.api.nvim_set_keymap(
          "n",
          "gp",
          ":lua require'lspsaga.provider'.preview_definition()<CR>",
          {noremap = true, silent = true}
        )
        vim.api.nvim_set_keymap(
          "n",
          "[g",
          ":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_prev()<CR>",
          {noremap = true, silent = true}
        )
        vim.api.nvim_set_keymap(
          "n",
          "]g",
          ":lua require'lspsaga.diagnostic'.lsp_jump_diagnostic_next()<CR>",
          {noremap = true, silent = true}
        )
        vim.api.nvim_set_keymap(
          "n",
          "gd",
          ":lua require'lspsaga.provider'.lsp_finder()<CR>",
          {noremap = true, silent = true}
        )
        vim.api.nvim_set_keymap(
          "n",
          "gh",
          ":lua require'lspsaga.provider'.signature_help()<CR>",
          {noremap = true, silent = true}
        )
        vim.api.nvim_set_keymap(
          "n",
          "<leader>ca",
          ":lua require('lspsaga.codeaction').code_action()<CR>",
          {noremap = true, silent = true}
        )
      end
    }
    use {
      "neovim/nvim-lspconfig",
      config = function()
        require("linux.lspconfig")
      end
    }
    use {
      "hrsh7th/nvim-compe",
      opt = true,
      event = {"InsertEnter *"},
      requires = {
        {"hrsh7th/vim-vsnip-integ", opt = true},
        {"hrsh7th/vim-vsnip", event = {"BufReadPre *"}},
        {"PHSix/compe-tabnine", run = "./install.sh"},
        "onsails/lspkind-nvim",
        opt = true
      },
      config = function()
        vim.cmd [[packadd lspkind-nvim]]
        vim.g.compe_tabnine_max_line = 1000
        vim.g.compe_tabnine_max_num_results = 2
        require("lspkind").init(
          {
            with_text = true,
            symbol_map = {
              TN = "T",
              Text = "",
              Method = "ƒ",
              Function = "",
              Constructor = "",
              Variable = "",
              Class = "",
              Interface = "ﰮ",
              Module = "",
              Property = "",
              Unit = "",
              Value = "",
              Enum = "了",
              Keyword = "",
              Snippet = "﬌",
              Color = "",
              File = "",
              Folder = "",
              EnumMember = "",
              Constant = "",
              Struct = ""
            }
          }
        )
        vim.o.completeopt = "menu,menuone,noselect"
        require "compe".setup {
          enabled = true,
          debug = false,
          min_length = 1,
          preselect = "disable",
          allow_prefix_unmatch = false,
          source = {
            path = true,
            buffer = true,
            vsnip = true,
            nvim_lsp = true,
            nvim_lua = true,
            spell = true,
            tags = true,
            treesitter = true,
            tabnine = true
          }
        }
        local t = function(str)
          return vim.api.nvim_replace_termcodes(str, true, true, true)
        end
        local check_back_space = function()
          local col = vim.fn.col(".") - 1
          if col == 0 or vim.fn.getline("."):sub(col, col):match("%s") then
            return true
          else
            return false
          end
        end
        _G.tab_complete = function()
          if vim.fn.pumvisible() == 1 then
            return t "<C-n>"
          elseif vim.fn.call("vsnip#available", {1}) == 1 then
            return t "<Plug>(vsnip-expand-or-jump)"
          elseif check_back_space() then
            return t "<Tab>"
          else
            return vim.fn["compe#complete"]()
          end
        end
        _G.s_tab_complete = function()
          if vim.fn.pumvisible() == 1 then
            return t "<C-p>"
          elseif vim.fn.call("vsnip#jumpable", {-1}) == 1 then
            return t "<Plug>(vsnip-jump-prev)"
          else
            return t "<S-Tab>"
          end
        end
        vim.api.nvim_set_keymap("i", "<Tab>", "v:lua.tab_complete()", {expr = true})
        vim.api.nvim_set_keymap("s", "<Tab>", "v:lua.tab_complete()", {expr = true})
        vim.api.nvim_set_keymap("i", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
        vim.api.nvim_set_keymap("s", "<S-Tab>", "v:lua.s_tab_complete()", {expr = true})
        vim.api.nvim_set_keymap("i", "<CR>", "compe#confirm('<CR>')", {expr = true, noremap = true})
      end
    }
    use {
      "ojroques/nvim-hardline",
      event = {"VimEnter *"},
      config = function()
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
    }
    use {
      "akinsho/flutter-tools.nvim",
      ft = {"dart"},
      requires = {"neovim/nvim-lspconfig"},
      config = function()
        require("flutter-tools").setup {
          closing_tags = {
            highlight = "ErrorMsg",
            prefix = ">"
          },
          dev_log = {
            open_cmd = "tabedit"
          },
          outline = {
            open_cmd = "30vnew"
          }
        }
      end
    }
    use {
      "itchyny/vim-cursorword",
      event = {"BufReadPost *"}
    }
    use {
      "skywind3000/vim-rt-format",
      event = {"InsertEnter *"},
      config = function()
        vim.g.rtf_on_insert_leave = 1
      end
    }
    use {
      "numtostr/FTerm.nvim",
      keys = {{"n", "<A-f>"}},
      config = function()
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
        vim.api.nvim_set_keymap("n", "<A-f>", ":FTermOpen<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap(
          "t",
          "<A-f>",
          '<C-\\><C-n><CMD>lua require"FTerm".toggle()<CR>',
          {noremap = true, silent = true}
        )
      end
    }
    use {
      "tkmpypy/chowcho.nvim",
      keys = {{"n", ";"}},
      config = function()
        require("chowcho").setup {
          text_color = "#ffeaa7",
          bg_color = "#213039",
          active_border_color = "#D4BFFF",
          border_style = "rounded" -- 'default', 'rounded',
        }
        vim.api.nvim_set_keymap("n", ";", ":lua require('chowcho').run()<CR>", {noremap = true, silent = true})
      end
    }
    use {
      "APZelos/blamer.nvim",
      keys = {"n", "<leader>a"},
      config = function()
        vim.g.blamer_enabled = 0
        vim.g.blamer_delay = 500
        vim.g.blamer_prefix = " 🐛 :"
        vim.api.nvim_set_keymap("n", "<leader>a", ":BlamerToggle<CR>", {noremap = true, silent = true})
      end
    }
    use {
      "glacambre/firenvim",
      opt = true
    }
    use {
      "Yggdroot/indentLine",
      event = {"BufEnter *", "BufReadPre *"},
      config = function()
        local vim = vim
        vim.g.indentLine_char = "|"
        vim.g.indentLine_fileTypeExclude = {"help", "dashboard"}
      end
    }
    use {
      "kyazdani42/nvim-web-devicons"
    }
    use {
      "romgrk/barbar.nvim",
      config = function()
        local vim = vim
        local buf = {}
        buf["animation"] = false
        buf["icons"] = true
        buf["auto_hide"] = true
        buf["closable"] = false
        buf["maximum_padding"] = 2
        vim.g.bufferline = buf
        vim.api.nvim_set_keymap("n", "<leader>1", ":BufferGoto 1<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<leader>2", ":BufferGoto 2<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<leader>3", ":BufferGoto 3<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<leader>4", ":BufferGoto 4<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<leader>5", ":BufferGoto 5<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<leader>6", ":BufferGoto 6<CR>", {noremap = true, silent = true})
        vim.api.nvim_set_keymap("n", "<leader>7", ":BufferGoto 7<CR>", {noremap = true, silent = true})
      end
    }
    use {
      "TimUntersberger/neogit",
      keys = {"<leader>mg"},
      disable = true,
      config = function()
        -- local neogit = require('neogit')
        -- neogit.status.create("floating")
      end
    }
    use {
      "kyazdani42/nvim-tree.lua",
      opt = true,
      -- commit = "58a5e4ab48f201a80d58af965cbaa8468ad64144",
      keys = {"<C-n>"},
      config = function()
        local vim = vim
        vim.api.nvim_set_keymap("n", "<C-n>", ":NvimTreeToggle<CR>", {noremap = true, silent = true})
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
          ["cn"] = ":lua require'nvim-tree'.on_keypress('cn')<CR>"
        }
      end
    }
    use {
      "~/Github/faster.nvim",
      keys = {{"n", "j"}, {"n", "k"}},
      config = function()
        vim.api.nvim_set_keymap("n", "j", "<Plug>(faster_move_j)", {noremap = false, silent = true})
        vim.api.nvim_set_keymap("n", "k", "<Plug>(faster_move_k)", {noremap = false, silent = true})
      end
    }
    use {
      "mhartington/formatter.nvim",
      ft = {"typescript", "lua", "javascript", "json"},
      config = function()
        require("formatter").setup(
          {
            logging = false,
            filetype = {
              javascript = {
                function()
                  return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
                    stdin = true
                  }
                end
              },
              typescriptreact = {
                function()
                  return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
                    stdin = true
                  }
                end
              },
              typescript = {
                function()
                  return {
                    exe = "prettier",
                    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
                    stdin = true
                  }
                end
              },
              lua = {
                function()
                  return {
                    exe = "luafmt",
                    args = {"--indent-count", 2, "--stdin"},
                    stdin = true
                  }
                end
              },
              json = {
                function()
                  return {
                    exe = "jsonlint",
                    args = {"--indent", 2}
                  }
                end
              }
            }
          }
        )
      end
    }
  end
)

if execu_install == true then
  vim.cmd(":PackerSync")
end
