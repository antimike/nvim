return {
  -- Fuzzy finder and it requirments.
  {
    'nvim-telescope/telescope.nvim',
    as = "telescope",
    after = {
      "telescope_find_directories",
      "telescope-symbols",
      "telescope-fzf-native",
      "telescope-media-files",
      "telescope-project",
      "telescope-ui-select",
      "telescope-file-browser",
      "telescope-frecency",
      "telescope-arecibo",
      "command-palette",
      "smart-history",
      "telescope-cheat",
      "telescope-z",
    },
    -- cmd = 'Telescope',
    requires = {
      "cljoly/telescope-repo.nvim",
    },
    config = function()
      require('config.telescope')
    end
  },
  {
    'nvim-telescope/telescope-smart-history.nvim',
    as = 'smart-history',
    requires = 'sqlite',
  },
  {
    'nvim-telescope/telescope-cheat.nvim',
    as = 'telescope-cheat',
    requires = 'sqlite',
  },
  {
    'nvim-telescope/telescope-z.nvim',
    as = 'telescope-z',
    requires = {
        'plenary',
        'popup',
    },
  },
  {
    'nvim-telescope/telescope-project.nvim',
    as = "telescope-project",
  },
  {
    'nvim-telescope/telescope-fzf-native.nvim',
    as = "telescope-fzf-native",
    run = 'make',
  },
  {
    'nvim-telescope/telescope-media-files.nvim',
    as = "telescope-media-files",
    requires = {
      "plenary",
      "popup",
    },
  },
  -- NOTE: May conflict with dressing.nvim and popui
  {
    'nvim-telescope/telescope-ui-select.nvim',
    as = "telescope-ui-select",
  },
  {
    "nvim-telescope/telescope-file-browser.nvim",
    as = "telescope-file-browser",
  },
  {
    "nvim-telescope/telescope-frecency.nvim",
    as = "telescope-frecency",
    requires = {
      "sqlite",
      "devicons"
    },
  },
  -- Define and search for custom commands
  {
    "LinArcX/telescope-command-palette.nvim",
    as = "command-palette",
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
  },
  -- Directory finder
  {
    "artart222/telescope_find_directories",
    as = "telescope_find_directories",
    after = "telescope-fzf-native"
  }
}
