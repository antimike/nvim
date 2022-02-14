return {
  -- Fuzzy finder and it requirments.
  -- TODO: lazy load plenary, popup and telescope-media-files
  { 'nvim-lua/plenary.nvim' },
  {
    'nvim-telescope/telescope.nvim',
    cmd = 'Telescope',
    requires = {
      "cljoly/telescope-repo.nvim",
    },
    config = function()
      require('plugins/telescope')
    end
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim', run = 'make',
    cmd = 'Telescope'
  },
  {
    'nvim-lua/popup.nvim',
    cmd = 'Telescope'
  },
  {
    'nvim-telescope/telescope-media-files.nvim',
    after = 'popup.nvim'
  },
  -- NOTE: May conflict with dressing.nvim and popui
  { 'nvim-telescope/telescope-ui-select.nvim' },
  {
    "nvim-telescope/telescope-frecency.nvim",
    requires = {"tami5/sqlite.lua"},
  },
  -- Support web searches from neovim
  {
    "nvim-telescope/telescope-arecibo.nvim",
    rocks = {"openssl", "lua-http-parser"},
  },
  -- Symbol picker
  -- TODO: Add shruggie symbol and others in custom data file
  'nvim-telescope/telescope-symbols.nvim',
  -- SQLite: required for frecency (Telescope plugin)
  { "tami5/sqlite.lua" },
}
