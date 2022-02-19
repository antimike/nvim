return {
  {
    'lukas-reineke/indent-blankline.nvim',
    as = "indent-blankline",
    event = 'BufRead',
    config = function()
      require('config.indent-blankline')
    end
  },

  -- This plugin show trailing whitespace.
  {
    'ntpeters/vim-better-whitespace',
    as = "better-whitespace",
    config = function()
        require('config.better-whitespace')
    end
  },

  {
    "mfussenegger/nvim-ts-hint-textobject",
    as = "ts-hint-textobject",
    requires = 'treesitter',
    config = function()
      require('config.nvim-ts-hint-textobject')
    end
  },

  {
    'RRethy/nvim-treesitter-textsubjects',
    as = "ts-textsubjects",
    requires = 'treesitter',
  },

  -- nvim_context_vt: Uses Treesitter to display expanded node context
  -- Toggleable
  {
    "haringsrob/nvim_context_vt",
    as = "ts-context-vt",
    requires = 'treesitter',
  },

  -- Auto closes.
  {
    'windwp/nvim-autopairs',
    event = 'BufRead',
    config = function()
      require('nvim-autopairs').setup{}
    end
  },

  -- match-up is a plugin that lets you highlight, navigate, and operate on sets of matching text.
  {
    'andymass/vim-matchup',
    after = "treesitter",
  },

  {
    'machakann/vim-sandwich',
    as = "sandwich",
    config = function()
      require("config.sandwich")
    end,
  },

  -- Improved EasyMotion
  {
    'phaazon/hop.nvim',
    as = "hop",
    branch = 'v1', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
    end
  },
}
