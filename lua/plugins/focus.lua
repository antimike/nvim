
  -- TrueZen.nvim is a Neovim plugin that aims to provide a cleaner and less cluttered interface
  -- when toggled in either of it's three different modes (Ataraxis, Minimalist and Focus).
return {
  {
    'Pocco81/TrueZen.nvim',
    cmd = {
      'TZFocus',
      'TZAtaraxis',
      'TZMinimalist',
    },
    setup = function()
      require('plugins/true-zen')
    end
  },
  {
    "folke/twilight.nvim",
    config = function()
      require("plugins.twilight")
    end
  }
}
