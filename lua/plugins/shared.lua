--- Plugins used by many other plugins

return {
  -- TODO: lazy load plenary, popup and telescope-media-files
  {
    'nvim-lua/plenary.nvim',
    as = "plenary",
  },

  -- Icons.
  {
    'kyazdani42/nvim-web-devicons',
    as = "devicons",
    event = 'BufEnter',
  },

  -- SQLite: required for frecency (Telescope plugin)
  {
    "tami5/sqlite.lua",
    as = "sqlite"
  },

  -- TreeSitter.
  {
    'nvim-treesitter/nvim-treesitter',
    as = "treesitter",
    run = ':TSUpdate',
    event = 'BufRead',
    cmd = {
      'TSInstall',
      'TSInstallSync',
      'TSBufEnable',
      'TSBufToggle',
      'TSEnableAll',
      'TSInstallFromGrammer',
      'TSToggleAll',
      'TSUpdate',
      'TSUpdateSync'
    },
    config = function()
      require('config.treesitter')
    end
  },
}
