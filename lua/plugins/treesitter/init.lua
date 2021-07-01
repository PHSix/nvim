local function treesitter()
  require "nvim-treesitter.configs".setup {
    autotag = {
      enable = true;
    };
    ensure_installed = "maintained";
    highlight = {
      enable = true;
      disable = {"rust"};
    };
    rainbow = {
      enable = true
    };
  }
end

return treesitter
