
  -- This plugin adds indentation guides to all lines (including empty lines).
return {
  {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    setup = function()
      require('plugins/indent-blankline')
    end
  },
  -- This plugin show trailing whitespace.
  {
    'ntpeters/vim-better-whitespace',
    config = function()
        require('plugins/better-whitespace')
    end
  },
  {
    "mfussenegger/nvim-ts-hint-textobject",
    requires = {'nvim-treesitter/nvim-treesitter'}
  },
  {
    'RRethy/nvim-treesitter-textsubjects',
    requires = {'nvim-treesitter/nvim-treesitter'}
  },
  -- nvim_context_vt: Uses Treesitter to display expanded node context
  -- Toggleable
  {
    "haringsrob/nvim_context_vt",
    requires = {'nvim-treesitter/nvim-treesitter'}
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
  { 'andymass/vim-matchup' },
  -- Improved EasyMotion
  {
    'phaazon/hop.nvim',
    branch = 'v1', -- optional but strongly recommended
    config = function()
      -- you can configure Hop the way you like here; see :h hop-config
      require'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    end
  },
}
