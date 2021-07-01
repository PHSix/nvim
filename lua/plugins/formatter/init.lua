local function formatter()
  vim.api.nvim_set_keymap("n", "F", ":Format<CR>", {})
  require("formatter").setup(
    {
      logging = false,
      filetype = {
        vue = {
          function()
            return {
              exe = "prettier",
              args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
              stdin = true
            }
          end
        },
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

return formatter
