local config = {}
function config.gitsigns()
      vim.cmd [[packadd plenary.nvim]]
    require("gitsigns").setup {
      keymaps = {
        noremap = false,
        buffer = false
      }
    }

end

function config.blamer()
      vim.g.blamer_enabled = 0
    vim.g.blamer_delay = 500
    vim.g.blamer_prefix = " 🐛 :"

end
return config
