local status = "1\n"
local function set_chinese()
  vim.fn.system("fcitx5-remote -o")
end

local function set_english()
  vim.fn.system("fcitx5-remote -c")
end

function _G.leave_insert()
  status = vim.fn.system("fcitx5-remote")
  if status == "1\n" then
    return
  end
  set_english()
  return
end

function _G.enter_insert()
  if status == "1\n" then
    return
  end
  set_chinese()
  return
end


vim.cmd [[autocmd InsertLeave * call v:lua.leave_insert()]]
vim.cmd [[autocmd InsertEnter * call v:lua.enter_insert()]]




