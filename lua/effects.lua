return {
  -- Allows fancy UI hooks
  -- Requires nvim 0.6 for full effect
  -- NOTE: May conflict with popui and telescope-ui-select.nvim
  {'stevearc/dressing.nvim'},

  -- Colorizer (for highlighting color codes).
  {
    'norcalli/nvim-colorizer.lua',
    event = 'BufRead',
    config = function()
      require('plugins/colorize')
      vim.cmd('ColorizerAttachToBuffer')
    end
  },

  -- Startup screen.
  {
    'glepnir/dashboard-nvim',
    -- cmd = {
    --   'Dashboard',
    --   'DashboardChangeColorscheme',
    --   'DashboardFindFile',
    --   'DashboardFindHistory',
    --   'DashboardFindWord',
    --   'DashboardNewFile',
    --   'DashboardJumpMarks',
    --   'SessionLoad',
    --   'SessionSave'
    -- },
    -- setup = function()
    --   require('plugins/dashboard')
    -- end,
    opt = false,
    disable = false,
    as = "dashboard"
  },
  -- Scrollbar.
  {
    'dstein64/nvim-scrollview',
    event = 'BufRead',
    config = function()
      require('plugins/nvim-scroll')
    end
  },
  -- Smooth scroll.
  {
    'karb94/neoscroll.nvim',
    event = 'BufRead',
    config = function()
      require('neoscroll').setup()
    end
  },
  -- Preview buffer line during commands
  {
   "nacro90/numb.nvim",
   config = function()
     require("numb").setup()
   end,
  },
  -- Markdown Preview
  {"ellisonleao/glow.nvim"},
  -- Register peeking
  'gennaro-tedesco/nvim-peekup',

  -- Auto-resizes splits
  {
    "beauwilliams/focus.nvim",
    config = function()
      require("focus").setup()
    end
  },

  -- Popui: custom popups
  -- NOTE: May conflict with dressing.nvim and telescope-ui-select.nvim
  -- use('RishabhRD/popfix')
  -- {
    -- 'hood/popui.nvim',
    -- config = function()
      -- vim.ui.select = require("popui.ui-overrider")
    -- end,
  -- },

}
