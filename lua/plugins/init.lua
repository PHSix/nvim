local git = "fgit"
local execute = vim.api.nvim_command
local fn = vim.fn

local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"

if fn.empty(fn.glob(install_path)) > 0 then
  fn.system({git, "clone", "https://github.com/wbthomason/packer.nvim", install_path})
end

execute "packadd packer.nvim"

local packer = require("packer")
local use = packer.use

packer.init(
  {
    git = {
      cmd = "fgit"
    }
  }
)

vim.api.nvim_set_keymap("n", "<F2>", ":PackerCompile<CR>", {noremap=true})

--
-- completion
--
use {
  "wbthomason/packer.nvim"
}

use {
  "neoclide/coc.nvim",
  requires = {{"rafcamlet/coc-nvim-lua", ft = {"lua"}}},
  config = function()
    require("plugins.coc")
  end
}

--
-- ui
--
use {
  "PHSix/nvim-hybrid",
  config = function()
    require("hybrid")
  end
}
use {
  "glepnir/dashboard-nvim";
  config = function ()
    require("plugins.dashboard")()
  end
}
use {
  "lukas-reineke/indent-blankline.nvim",
  branch = "lua",
  config = function()
    require("plugins.indentLine")()
  end
}
use {
  "romgrk/barbar.nvim",
  requires = {{"kyazdani42/nvim-web-devicons", opt = true}},
  config = function()
    vim.cmd [[packadd nvim-web-devicons]]
    local buf = {}
    buf["animation"] = false
    buf["icons"] = "both"
    buf["auto_hide"] = true
    buf["closable"] = false
    buf["maximum_padding"] = 2
    vim.g.bufferline = buf
    for i=1,9,1 do
      if i ~= nil or i ~= "" or i ~= " " then
        vim.api.nvim_set_keymap("n", "<leader>" .. i, ":BufferGoto " .. i .. "<CR>", {})
      end
    end
  end
}
use {
  "hoob3rt/lualine.nvim";
  config = function()
    require("plugins.evil")
  end;
}

--
-- edit
--
use {
  "windwp/nvim-autopairs";
  event = {"BufEnter"};
  config = function()
    require("nvim-autopairs").setup()
  end
}

use {
  "tyru/caw.vim";
  requires = {{"Shougo/context_filetype.vim", ft = {"html", "vue"}}};
  keys = {",c"};
  config = function()
    vim.api.nvim_set_keymap("n", ",c", "<Plug>(caw:prefix)", {})
  end;
}

use {
  "tpope/vim-surround",
  keys = {"c", "d", "y"}
}
use {
  "PHSix/faster.nvim",
  event = {"VimEnter *"},
  config = function()
    vim.api.nvim_set_keymap("n", "j", "<Plug>(faster_move_j)", {noremap = false, silent = true})
    vim.api.nvim_set_keymap("n", "k", "<Plug>(faster_move_k)", {noremap = false, silent = true})
  end
}
use {
  "norcalli/nvim-colorizer.lua",
  ft = {"lua", "vim", "css", "html", "javascript", "typescript", "c", "cpp", "vue"},
  config = function()
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
}

use {
  "ms-jpq/chadtree",
  keys = "<C-n>",
  config = function()
    require("plugins.chadtree")()
  end
}

--
-- language
--
use {
  "dkarter/bullets.vim",
  ft = {"markdown"}
}
use {
  "mhartington/formatter.nvim",
  ft = {"typescript", "lua", "javascript", "json", "vue"},
  config = function()
    require("plugins.formatter")()
  end
}

use {
  "nvim-treesitter/nvim-treesitter",
  requires = {
    {"windwp/nvim-ts-autotag", ft = {"vue", "html", "xml"}},
    {"p00f/nvim-ts-rainbow", event = {"BufReadPre"}}
  },
  config = function()
    require("plugins.treesitter")()
  end
}
use {
  "dart-lang/dart-vim-plugin",
  ft = {"dart"}
}
use {
  "leafOfTree/vim-vue-plugin",
  ft = {"vue"}
}

--
-- git
--
use {
  "lewis6991/gitsigns.nvim",
  event = {"BufRead", "BufNewFile"},
  requires = {{"nvim-lua/plenary.nvim", opt = true}},
  config = function()
    if not packer_plugins["plenary.nvim"].loaded then
      vim.cmd [[packadd plenary.nvim]]
    end
    require("gitsigns").setup {
      keymaps = {
        noremap = false,
        buffer = false
      }
    }
  end
}

--
-- finder
--
use {
  "nvim-telescope/telescope.nvim";
  requires = {
    {"nvim-lua/plenary.nvim", opt = true},
    {"nvim-lua/popup.nvim", opt = true},
    {"nvim-telescope/telescope-fzy-native.nvim", opt = true}
  };
  config = function ()
    require("plugins.telescope")()
  end
}
