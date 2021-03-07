local config = {}
function config.vista()
      vim.g.vista_icon_indent = {"╰─▸ ", "├─▸ "}
    vim.cmd("let g:vista#renderer#enable_icon = 1")
    vim.cmd [[augroup vista_key_bind]]
    vim.cmd [[autocmd FileType vista,vista_kind nnoremap <buffer> <silent> o :<c-u>call vista#cursor#FoldOrJump()<CR>]]
    vim.cmd [[augroup END]]

end
function config.formatter()
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

function config.treesitter()
      require "nvim-treesitter.configs".setup {
      ensure_installed = "maintained",
      highlight = {
        enable = true,
        disable = {"rust"}
      }
    }

end

function config.rt_format()
      vim.g.rtf_on_insert_leave = 1
end
return config
