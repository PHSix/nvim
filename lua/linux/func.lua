local vim = vim
function StartR()
  if vim.bo.filetype == "markdown" then
    vim.cmd(":Glow")
  else 
    vim.cmd(":AsyncTask file-run")
  end
end
