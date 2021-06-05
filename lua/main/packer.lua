local api = vim.api
local fn = vim.fn
local execute = api.nvim_command
local to_do_install = false
local packer = nil
local Packer = {}
local plugins_dir = fn["stdpath"]("config") .. "/lua/plugins"
local plugins_list = vim.split(fn["globpath"](plugins_dir, "*"), "\n")
local function update_plugins()
  for key, value in pairs(plugins_list) do
    plugins_list[key] = string.sub(string.match(value, "/[a-zA-Z-]+$"), 2)
  end
end

function Packer:add_repos()
  update_plugins()
  self.repos = {}
  for _, filename in pairs(plugins_list) do
    local packs = require("plugins." .. filename)
    for repo, conf in pairs(packs) do
      --      if string.sub(repo, 1, 1) ~= "~" then
      --        repo = "https://hub.fastgit.org/" .. repo
      --      end
      self.repos[#self.repos + 1] = vim.tbl_extend("force", {repo}, conf)
    end
  end
end

function Packer:load_plugins()
  if not packer then
    vim.cmd [[packadd packer.nvim]]
    packer = require("packer")
  end
  packer.init {
    clone_timeout = 30,
    transitive_opt = true,
    git = {
      cmd = "git"
    },
    profile = {
    enable = false,
    threshold = 1, -- integer in milliseconds, plugins which load faster than this won't be shown in profile output
  }
  }
  packer.reset() -- clean plugin manages
  local use = packer.use
  use {
    "wbthomason/packer.nvim",
    opt = true
  }
  for _, repo in pairs(self.repos) do
    use(repo)
  end
end

local function install(path)
  execute("!git clone https://github.com/wbthomason/packer.nvim " .. path)
  local plugin_path = fn.stdpath("config") .. "/plugin"
  if fn.empty(fn.glob(plugin_path)) ~= 0 then
    execute("!rm -rf ~/.config/nvim/plugin")
  end
end

local function init()
  local install_path = fn.stdpath("data") .. "/site/pack/packer/opt/packer.nvim"
  if fn.empty(fn.glob(install_path)) > 0 then
    to_do_install = true
    install(install_path)
  end
  Packer:add_repos()
  Packer:load_plugins()
  if to_do_install == true then
    vim.cmd [[PackerSync]]
  end
end

local async
async =
  vim.loop.new_async(
  vim.schedule_wrap(
    function()
      init()
      vim.cmd [[command! PackerCompile lua require('packer').compile()]]
      vim.cmd [[command! PackerInstall lua require('packer').install()]]
      vim.cmd [[command! PackerUpdate lua require('packer').update()]]
      vim.cmd [[command! PackerSync lua require('packer').sync()]]
      vim.cmd [[command! PackerClean lua require('packer').clean()]]
      async:close()
    end
  )
)
async:send()

-- return {init = init}
