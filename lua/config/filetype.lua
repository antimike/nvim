local version = vim.version()
if version.major == 0 and version.minor < 6 then
  -- Do not source the default filetype.vim
  -- Only needed if neovim version is < 0.6.0
  vim.g.did_load_filetypes = 1
end
