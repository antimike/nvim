vim.opt.shell = "/bin/zsh"

-- Function for make mapping easier.
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local additional_plugins = {
  -- You can put your additional plugins here.
  -- Syntax is like normal packer.nvim Syntax. Examples:

  -- {'famiu/feline.nvim', branch = 'develop' },

  -- 'mhartington/formatter.nvim'
  -- { crispgm/nvim-go', ft = 'go'}

 -- Project
}

-- Other settings here
-- For examples for disabling line number:
-- vim.opt.number = false
-- vim.opt.relativenumber = false

-- Or for changing terminal toggle mapping:
-- first argument is mode of mapping. second argument is keymap.
-- third argument is command. and last argument is optional argument like {expr = true}.
-- map('n', '<C-t>', ':ToggleTerm<CR>')
-- map('t', '<C-t>', ':ToggleTerm<CR>')

map('n', '<C-Space>', ":call fzf#run(fzf#wrap({'source': 'find $HOME/Source -maxdepth 2 -type d'}))<CR>")

-- Suggested by https://alpha2phi.medium.com/neovim-tips-for-a-better-coding-experience-part-2-3b6a5a09d7c8
map('o', 'm', ':<C-U>lua require("tsht").nodes()<CR>')
map('v', 'm', ':lua require("tsht").nodes()<CR>')

return additional_plugins
