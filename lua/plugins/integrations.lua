--- Plugins that integrate with external utilities (REPLs, tmux, etc.)
return {
  -- Terminal.
  {
    'akinsho/nvim-toggleterm.lua',
    as = "toggleterm",
    cmd = 'ToggleTerm',
    setup = function()
      require('plugins/toggleterm')
    end
  },

  -- Create shareable permalinks with line ranges
  {
    'ruifm/gitlinker.nvim',
    as = "gitlinker",
    requires = 'nvim-lua/plenary.nvim',
    config = function()
      require("config.gitlinker").setup()
    end
  },

  -- Collaborative editing
  {
    'jbyuki/instant.nvim',
    config = function()
      vim.cmd('let g:instant_username = "antimike"')
    end
  },
}
