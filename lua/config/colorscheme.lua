local utils = require('utils')
local cmd = vim.cmd
utils.opt('o', 'termguicolors', true)
cmd 'colorscheme gruvbox-material'
vim.g.edge_style = 'aura'
vim.g.edge_enable_italic = 1
vim.g.disable_italic_comment = 1
