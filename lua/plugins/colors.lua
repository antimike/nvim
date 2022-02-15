  -- Color schemes.
return {
  { 'folke/tokyonight.nvim' },
  { 'bluz71/vim-nightfly-guicolors' },
  { 'bluz71/vim-moonfly-colors' },
  { 'shaunsingh/nord.nvim' },
  {
    'navarasu/onedark.nvim',
    config = function()
      require("config.onedark")
    end
  },
  { 'wuelnerdotexe/vim-enfocado' },
}
