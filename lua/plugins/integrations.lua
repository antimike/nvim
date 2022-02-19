--- Plugins that integrate with external utilities (REPLs, tmux, etc.)
return {
  -- Terminal.
  {
    'akinsho/nvim-toggleterm.lua',
    as = "toggleterm",
    cmd = 'ToggleTerm',
    setup = function()
      require('config.toggleterm')
    end
  },

  -- Create shareable permalinks with line ranges
  {
    'ruifm/gitlinker.nvim',
    as = "gitlinker",
    requires = 'plenary',
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

  -- Competitive programming
  {
    'xeluxee/competitest.nvim',
    as = 'competitest',
    requires = 'nui',
    config = function()
        require('config.competitest')
    end
  },

  -- Code runner
  {
    'michaelb/sniprun',
    as = "sniprun",
    run = 'bash ./install.sh',
    config = function()
        require('config.sniprun')
    end
  },
}
