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
    },
    go = {
      type = "executable",
      command = "node",
      args = {os.getenv("HOME") .. "/Github/vscode-go/dist/debugAdapter.js"}
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
      request = "launch"
    },
    go = {
      {
        type = "go",
        name = "Debug",
        request = "launch",
        showLog = false,
        program = "${file}",
        dlvToolPath = vim.fn.exepath("dlv") -- Adjust to where delve is installed
      }
    }
  }
end

function config.dap_ui()
  require("dapui").setup(
    {
      icons = {
        expanded = "⯆",
        collapsed = "⯈"
      },
      mappings = {
        -- Use a table to apply multiple mappings
        expand = {"<CR>", "<2-LeftMouse>"},
        open = "o",
        remove = "d",
        edit = "e"
      },
      sidebar = {
        elements = {
          -- You can change the order of elements in the sidebar
          "scopes",
          "breakpoints",
          "stacks",
          "watches"
        },
        width = 40,
        position = "left" -- Can be "left" or "right"
      },
      tray = {
        elements = {
          "repl"
        },
        height = 10,
        position = "bottom" -- Can be "bottom" or "top"
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil -- Floats will be treated as percentage of your screen.
      }
    }
  )
end

return config
