local function dashboard()
  vim.api.nvim_set_keymap("n", "<C-f>n", ":DashboardNewFile<CR>", {})
  vim.api.nvim_set_keymap("n", "<C-f>s", ":SessionLoad<CR>", {})
  vim.cmd [[augroup dashboard_autocmd]]
  vim.cmd [[autocmd FileType dashboard lua vim.api.nvim_buf_set_keymap(0, 'n', 'q', ':q<CR>', {noremap=true, silent=true})]]
  -- vim.cmd [[autocmd FileType dashboard set showtabline=0 | autocmd WinLeave <buffer> set showtabline=2]]
  vim.cmd [[augroup END]]
  vim.g.dashboard_default_executive = "telescope"
  vim.g.dashboard_session_directory = "~/.cache/vim/session"
  vim.g.dashboard_custom_section = {
    a = {description = {"  Recently Files         <C-f> u"}, command = "Telescope oldfiles"},
    b = {description = {"  Load Session           <C-f> s"}, command = "SessionLoad"},
    c = {description = {"  Find File              <C-f> f"}, command = "Findr"},
    d = {description = {"  Find Word              <C-f> w"}, command = "Telescope live_grep"},
    -- e = {description = {"  Marks                  <C-f> m"}, command = "Telescope marks"},
    e = {description = {"  New File               <C-f> n"}, command = "DashboardNewFile"},
    f = {description = {"  Compile Configure         <F2>"}, command = "PackerCompile"},
    h = {description = {"  Settings                  <F1>"}, command = ":e ~/.config/nvim/init.lua"}
  }
end

return dashboard
