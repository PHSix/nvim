local function chadtree()
  vim.api.nvim_set_keymap("n", "<C-n>", ":CHADopen<CR>", {noremap=true})
  vim.g.chadtree_settings = {
    ["keymap"] = {
      ["quit"] = {"q"},
      ["change_focus_up"] = {"u"},
      ["change_focus"] = {"c"},
      ["primary"] = {"o", "<enter>"},
      ["new"] = {"n"},
      ["rename"] = {"r"}
    },
    ["view"] = {
      ["width"] = 30
    }
  }
end

return chadtree
