local config = {}
function config.vista()
  vim.g.vista_icon_indent = {"╰─▸ ", "├─▸ "}
  vim.g.vista_cursor_delay = 100
  vim.g.vista_no_mappings = 1
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
        -- cpp = {
        --   function()
        --     return {
        --       exe = "prettier",
        --       args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
        --       stdin = true
        --     }
        --   end
        -- },
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

function config.treesitter()
  require "nvim-treesitter.configs".setup {
    autotag = {
      enable = true
    },
    ensure_installed = "maintained",
    highlight = {
      enable = true,
      disable = {"rust"}
    },
  }
end

function config.rt_format()
  vim.g.rtf_on_insert_leave = 1
end

function config.nvim_go()
  vim.cmd [[packadd plenary.nvim]]
  vim.cmd [[packadd popup.nvim]]
  require("go").setup {
    -- linters: golint, errcheck, golangci-lint
    linter = "golangci-lint",
    -- lint_prompt_style: qf (quickfix), vt (virtual text, not implemented yet)
    -- lint_prompt_style = 'vt',
    -- formatter: goimports, gofmt, gofumpt
    formatter = "goimports",
    -- test flags: -count=1 will disable cache
    test_flags = {"-v"},
    test_timeout = "30s",
    -- show test result with popup window
    test_popup = true
  }
end

function config.vim_dadbod_ui()
end

function config.vue()
  vim.cmd [[
  function! OnChangeVueSubtype(subtype)
  echom 'Subtype is '.a:subtype
  if a:subtype == 'html'
    setlocal commentstring=<!--%s-->
    setlocal comments=s:<!--,m:\ \ \ \ ,e:-->
  elseif a:subtype =~ 'css'
    setlocal comments=s1:/*,mb:*,ex:*/ commentstring&
  else
    setlocal commentstring=//%s
    setlocal comments=sO:*\ -,mO:*\ \ ,exO:*/,s1:/*,mb:*,ex:*/,://
  endif
endfunction
  ]]
end
function config.luapad()
  -- lua
  require "luapad".config {
    count_limit = 150000,
    error_indicator = false,
    eval_on_move = true,
    error_highlight = "WarningMsg",
    on_init = function()
      print "Hello from Luapad!"
    end,
    context = {
      the_answer = 42,
      shout = function(str)
        return (string.upper(str) .. "!")
      end
    }
  }
end
function config.autotag()
  require("nvim-ts-autotag").setup()
end

return config
