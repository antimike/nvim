--- Plugins used by many other plugins

return {
  -- TODO: lazy load plenary, popup and telescope-media-files
  {
    'nvim-lua/plenary.nvim',
    as = "plenary",
  },

  {
    'nvim-lua/popup.nvim',
    as = "popup",
    requires = "plenary",
    cmd = 'Telescope'
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
  -- TODO: Figure out lazy loading (is it worth it?)
  {
    'nvim-treesitter/nvim-treesitter',
    as = "treesitter",
    -- run = ':TSUpdate',
    -- event = 'BufRead',
    -- cmd = {
    --   'TSInstall',
    --   'TSInstallSync',
    --   'TSBufEnable',
    --   'TSBufToggle',
    --   'TSEnableAll',
    --   'TSInstallFromGrammer',
    --   'TSToggleAll',
    --   'TSUpdate',
    --   'TSUpdateSync'
    -- },
    config = function()
      require('config.treesitter')
    end
  },

  -- For better diffs
  {
    "sindrets/diffview.nvim",
    as = "diffview",
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require("config.diffview")
    end
  },
}
