return {
  -- Fuzzy finder and it requirments.
  {
    'nvim-telescope/telescope.nvim',
    as = "telescope",
    cmd = 'Telescope',
    requires = {
      "cljoly/telescope-repo.nvim",
    },
    config = function()
      require('config.telescope')
    end
  },
  {
    'nvim-telescope/telescope-project.nvim',
    requires = "telescope",
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    as = "telescope-fzf-native",
    requires = "telescope",
    run = 'make',
    cmd = 'Telescope'
  },
  {
    'nvim-lua/popup.nvim',
    as = "popup",
    requires = "plenary",
    cmd = 'Telescope'
  },
  {
    'nvim-telescope/telescope-media-files.nvim',
    requires = {
      "plenary",
      "popup",
      "telescope"
    },
    after = 'popup'
  },
  -- NOTE: May conflict with dressing.nvim and popui
  {
    'nvim-telescope/telescope-ui-select.nvim',
    requires = "telescope",
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    requires = {
      "telescope",
      "sqlite",
      "devicons"
    },
  },
  -- Support web searches from neovim
  {
    "nvim-telescope/telescope-arecibo.nvim",
    requires = {
      "telescope",
      "treesitter",
    },
    rocks = {"openssl", "lua-http-parser"},
  },
  -- Symbol picker
  -- TODO: Add shruggie symbol and others in custom data file
  {
    'nvim-telescope/telescope-symbols.nvim',
    requires = {
      "telescope"
    }
  },
}
