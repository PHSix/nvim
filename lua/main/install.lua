local fn = vim.fn

local function pack_exist(path, pack_name)
  if fn["globpath"](path, pack_name) == "" then
    return false
  else
    return true
  end
end

local function install_pack()
  -- nodejs
  -- go
  -- yay
  -- xsel
  -- gopls
  -- clangd
  -- rust
  local pack_list = {"node", "go", "xsel", "gopls", "clangd", "npm", "rust"}
  for _, pack in pairs(pack_list) do
    if not pack_exist(pack) then
      vim.cmd [[pack_exit]]
    end
  end
end
