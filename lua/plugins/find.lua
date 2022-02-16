return {
  -- Fuzzy finder and it requirments.
  {
    'nvim-telescope/telescope.nvim',
    as = "telescope",
    -- cmd = 'Telescope',
    requires = {
      "cljoly/telescope-repo.nvim",
    },
    config = function()
      require('config.telescope')
    end
  },
  {
    'nvim-telescope/telescope-project.nvim',
    -- requires = "telescope",
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    as = "telescope-fzf-native",
    -- requires = "telescope",
    run = 'make',
    -- cmd = 'Telescope'
  },
  {
    'nvim-telescope/telescope-media-files.nvim',
    as = "telescope-media-files",
    requires = {
      "plenary",
      "popup",
      -- "telescope"
    },
    -- after = 'popup'
  },
  -- NOTE: May conflict with dressing.nvim and popui
  {
    'nvim-telescope/telescope-ui-select.nvim',
    as = "telescope-ui-select",
    -- requires = "telescope"
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    as = "telescope-file-browser",
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    as = "telescope-frecency",
    requires = {
      -- "telescope",
      "sqlite",
      "devicons"
    },
  },
  -- Support web searches from neovim
  {
    "nvim-telescope/telescope-arecibo.nvim",
    as = "telescope-arecibo",
    requires = {
      -- "telescope",
      "treesitter",
    },
    rocks = {"openssl", "lua-http-parser"},
  },
  -- Symbol picker
  -- TODO: Add shruggie symbol and others in custom data file
  {
    'nvim-telescope/telescope-symbols.nvim',
    as = "telescope-symbols",
    requires = {
      -- "telescope"
    }
  },
}
