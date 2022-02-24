  -- Color schemes.
return {
  { "ellisonleao/gruvbox.nvim" },
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
  'jonstoler/werewolf.vim',
   'sjl/badwolf',
   -- 'vim-scripts/candy.vim',
   'Lokaltog/vim-distinguished',
   'ParamagicDev/vim-medic_chalk',
   'tpope/vim-vividchalk',
   -- 'rafi/awesome-vim-colorschemes',
   'reedes/vim-colors-pencil',
    {
        'metalelf0/jellybeans-nvim',
        requires = "lush"
    }
}
