local function formatter()
  function _G.file_format()
    if vim.bo.filetype == "dart" then
      vim.cmd [[DartFmt]]
    else
      vim.cmd [[Format]]
    end
  end
  vim.api.nvim_set_keymap("n", "F", ":lua file_format()<CR>", {silent = true})
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
