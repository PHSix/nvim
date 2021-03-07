local config = {}

function config.asynctasks()
  vim.g.asyncrun_open = 9
  vim.g.asynctasks_rtp_config = "asynctasks.ini"
  vim.api.nvim_set_keymap("n", "R", ":lua StartR()<CR>", {noremap = true, silent = true})
  vim.api.nvim_set_keymap("n", "B", ":AsyncTask file-build<CR>", {noremap = true, silent = true})
end

function config.dap()
  local dap = require("dap")
  dap.adapters = {
    python = {
      type = "executable",
      command = os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python",
      args = {"-m", "debugpy.adapter"}
    },
    cpp = {
      type = "executable",
      attach = {
        pidProperty = "pid",
        pidSelect = "ask"
      },
      command = "lldb-vscode",
      env = {
        LLDB_LAUNCH_FLAG_LAUNCH_IN_TTY = "YES"
      },
      name = "lldb"
    }
  }
  dap.configurations = {
    python = {
      {
        type = "python",
        request = "launch",
        name = "Launch file",
        program = "${file}",
        pythonPath = os.getenv("HOME") .. "/.virtualenvs/debugpy/bin/python"
      }
    },
    cpp = {
      type = "cpp",
      request = "launch",
    }
  }
end

return config
