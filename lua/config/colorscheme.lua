local utils = require('utils')
local cmd = vim.cmd
utils.opt('o', 'termguicolors', true)

-- Hide ~ from end of lines.
vim.opt.fillchars = {eob = " "}

-- Add icons for lsp diagnostics sings
cmd
[[
  sign define LspDiagnosticsSignError text= texthl=LspDiagnosticsSignError linehl= numhl=
  sign define LspDiagnosticsSignWarning text= texthl=LspDiagnosticsSignWarning linehl= numhl=
  sign define LspDiagnosticsSignInformation text= texthl=LspDiagnosticsSignInformation linehl= numhl=
  sign define LspDiagnosticsSignHint text= texthl=LspDiagnosticsSignHint linehl= numhl=
]]

vim.g.tokyonight_style = 'night' -- styles: storm, night and day.
vim.g.onedark_style = 'deep'     -- styles: dark, darker, cool, deep, warm and warmer.
cmd('colorscheme onedark')
--cmd 'colorscheme gruvbox-material'
vim.g.edge_style = 'aura'
vim.g.edge_enable_italic = 1
vim.g.disable_italic_comment = 1
