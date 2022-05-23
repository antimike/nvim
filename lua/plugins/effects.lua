return {
 -- Allows fancy UI hooks
 -- Requires nvim 0.6 for full effect
 -- NOTE: May conflict with popui and telescope-ui-select.nvim
 {
  "stevearc/dressing.nvim",
  as = "dressing",
  event = "UIEnter",
  config = function()
      require("config.dressing")
  end,
 },

 -- Markdown Preview
 { "ellisonleao/glow.nvim", ft = "markdown" },
 -- Register peeking
 {
   "gennaro-tedesco/nvim-peekup",
   keys = '<leader>"',
   config = function()
       vim.cmd [[let g:peekup_open = '<leader>"']]
   end
 },

 -- Auto-resizes splits
 {
  "beauwilliams/focus.nvim",
  module = "focus",
  cmd = { "FocusSplitNicely", "FocusSplitCycle" },
  config = function()
      require("config.focus")
  end,
 },

 -- Popui: custom popups
 -- NOTE: May conflict with dressing.nvim and telescope-ui-select.nvim
 {
  "RishabhRD/popfix",
  as = "popfix",
  module = "popfix"
 },

 {
  "hood/popui.nvim",
  requires = "popfix",
  module = "popui",
  config = function()
      vim.ui.select = require("popui.ui-overrider")
      vim.ui.input = require("popui.input-overrider")
  end,
 },
 {
  "xiyaowong/nvim-transparent",
  as = "transparent",
  config = function()
      require("config.transparent")
  end,
 },
 {
  "wfxr/minimap.vim",
  as = "minimap",
  cmd = {
          "Minimap",
          "MinimapClose",
          "MinimapToggle",
          "MinimapRefresh",
          "MinimapUpdateHighlight",
          "MinimapRescan"
  },
  config = function()
      require("config.minimap")
  end,
 },
 -- Quickfix popup
 {
  "kevinhwang91/nvim-bqf",
  as = "bqf",
  ft = "qf",
  requires = "treesitter",
  after = "treesitter",
  config = function()
      require("config.bqf")
  end,
 },
}
