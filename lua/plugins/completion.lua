return {
  {
     'rafamadriz/friendly-snippets',
     as = "friendly-snippets",
     event = 'InsertEnter',
  },
  -- NOTE: Snippet "aggregator" (subsumes LuaSnip, e.g.)
  {
    'hrsh7th/nvim-cmp',
    as = "nvim-cmp",
    after = "friendly-snippets",
    config = function()
      require('config.cmp')
    end
  },
  {
    'hrsh7th/cmp-nvim-lsp',
    requires = {
      "nvim-cmp",
    },
    after = {
      "nvim-cmp",
    }
  },
  {
    'L3MON4D3/LuaSnip',
    as = "LuaSnip",
    after = 'nvim-cmp'
  },
  {
    'saadparwaiz1/cmp_luasnip',
    as = "cmp_luasnip",
    after = 'LuaSnip'
  },
  {
    'hrsh7th/cmp-buffer',
    as = "cmp-buffer",
    after = 'cmp_luasnip'
  },
  {
    'hrsh7th/cmp-path',
    as = "cmp-path",
    after = 'cmp-buffer'
  },
  {
    'hrsh7th/cmp-nvim-lua',
    as = "cmp-nvim-lua",
    requires = {
      "nvim-cmp"
    },
    after = {
      'cmp-nvim-lsp',
      'nvim-cmp'
    }
  },
}
