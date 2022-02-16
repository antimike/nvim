--- Aesthetics and organizational conveniences
return {
  -- WhichKey is a lua plugin that displays a popup with possible
  -- key bindings of the command you started typing.
  {
    "folke/which-key.nvim",
    as = "which-key",
    config = function()
      require("config.which_key").setup()
    end,
  },

  -- Colorizer (for highlighting color codes).
  {
    'norcalli/nvim-colorizer.lua',
    as = "colorizer",
    event = 'BufRead',
    config = function()
      require('config.colorizer')
    end
  },

  -- Startup screen.
  {
    'glepnir/dashboard-nvim',
    cmd = {
      'Dashboard',
      'DashboardChangeColorscheme',
      'DashboardFindFile',
      'DashboardFindHistory',
      'DashboardFindWord',
      'DashboardNewFile',
      'DashboardJumpMarks',
      'SessionLoad',
      'SessionSave'
    },
    as = "dashboard",
    setup = function()
      require('config.dashboard')
    end,
    opt = false,
    disable = false,
  },

  -- Scrollbar.
  {
    'dstein64/nvim-scrollview',
    as = "scrollbar",
    event = 'BufRead',
    config = function()
      require('config.nvim-scroll')
    end
  },

  -- Smooth scroll.
  {
    'karb94/neoscroll.nvim',
    as = "smooth-scroll",
    event = 'BufRead',
    config = function()
      require('config.neoscroll').setup()
    end
  },

  -- Preview buffer line during commands
  {
   "nacro90/numb.nvim",
   as = "bufferline-preview",
   config = function()
     require("config.numb")
   end,
  },

  -- File explorer tree.
  {
    'kyazdani42/nvim-tree.lua',
    as = "nvim-tree",
    cmd = {
      'NvimTreeOpen',
      'NvimTreeFocus',
      'NvimTreeToggle',
    },
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function()
      require('config.nvim-tree')
    end
  },

  -- Bufferline.
  {
    'akinsho/nvim-bufferline.lua',
    as = "bufferline",
    after = 'nvim-web-devicons',
    config  = function()
      require('config.bufferline')
    end
  },

  -- -- NOTE: May conflict with Bufferline
  -- {
  --   'romgrk/barbar.nvim',
  --   as = "barbar",
  --   requires = {'kyazdani42/nvim-web-devicons'},
  --   config = function()
  --     require("config.barbar")
  --   end
  -- },

  -- Style tabline like status line
  -- {
  --   'kdheepak/tabline.nvim',
  --   as = "tabline",
  --   config = function()
  --     require("config.tabline").setup()
  --   end,
  --   requires = {
  --     {'hoob3rt/lualine.nvim', opt = true },
  --     {'kyazdani42/nvim-web-devicons', opt = true}
  --   }
  -- },

  -- Statusline.
  {
    'nvim-lualine/lualine.nvim',
    as = "lualine",
    after = 'bufferline',
    config = function ()
      require('config.lualine')
    end
  },

  -- Smarter status line context
  -- Fails to install on clean packer install
  -- {
  --   "SmiteshP/nvim-gps",
  --   as = "gps",
  --   config = function()
  --     require("nvim-gps").setup(require("config.gps"))
  --   end,
  --   requires = "nvim-treesitter/nvim-treesitter",
  -- },

  -- todo-comments is a lua plugin for Neovim to highlight and search for
  -- todo comments like TODO, HACK, BUG in code base.
  {
    'folke/todo-comments.nvim',
    as = "todo-comments",
    requires = {
      'nvim-lua/plenary.nvim'
    },
    event = 'BufEnter',
    config = function()
      require('config.todo-comments')
    end
  },

  -- A plugin for neovim that automatically creates missing directories
  -- on saving a file.
  {
    'jghauser/mkdir.nvim',
    cmd = 'new',
    config = function()
      require('mkdir')
    end
  },

  -- With this plugin you can resize Neovim buffers easily.
  {
    'artart222/vim-resize',
    event = 'BufEnter'
  },

  -- Startup speed optimization
  {
    "nathom/filetype.nvim",
    as = "filetype",
    config = function()
      require("config.filetype")
    end
  },
}