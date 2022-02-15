-- Hide ~ from end of lines.
vim.opt.fillchars = {eob = " "}

-- Add icons for lsp diagnostics sings
vim.cmd
[[
  sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
  sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
  sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
  sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=
]]

vim.g.tokyonight_style = 'night' -- styles: storm, night and day.
local colorscheme = "industry"
if pcall(require, "onedark") then
  require("config.onedark")
  colorscheme = "onedark"
elseif pcall(require, "tokyonight") then
  colorscheme = "tokyonight"
elseif pcall(require, "nord") then
  colorscheme = "nord"
end
vim.cmd('colorscheme ' .. colorscheme)
