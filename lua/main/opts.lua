local M = {
  ["global"] = {
    guifont = "FiraCode Nerd Font:h16",
    mouse = "a",
    undofile = true,
    tabstop = 2,
    shiftwidth = 2,
    softtabstop = 2,
    expandtab = true,
    autowrite = true,
    swapfile = false,
    hlsearch = true,
    ignorecase = true,
    smartcase = true,
    backup = false,
    autochdir = true,
    autoindent = true,
    history = 400,
    encoding = "utf-8",
    fileencodings = "utf-8,gb2312,gbk,gb18030",
    syntax = "on",
    hidden = true,
    writebackup = true,
    showtabline = 2
  },
  ["buffer"] = {
    undofile = true,
    tabstop = 2,
    shiftwidth = 2,
    softtabstop = 2,
    expandtab = true,
    swapfile = false,
    autoindent = true,
    syntax = "on"
  },
  ["win"] = {
    wrap = true,
    cursorline = true,
    number = true,
    relativenumber = true,
    scrolloff = 5,
    signcolumn = "yes"
  }
}

local function load_opts()
  for opt, value in pairs(M["buffer"]) do
    vim.bo[opt] = value
  end
  for opt, value in pairs(M["win"]) do
    vim.wo[opt] = value
  end
  for opt, value in pairs(M["global"]) do
    vim.o[opt] = value
  end
end

load_opts()
