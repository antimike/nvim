return {
  {
     'rafamadriz/friendly-snippets',
     event = 'InsertEnter'
  },
  {
    'hrsh7th/nvim-cmp',
    after = "friendly-snippets",
    requires = {
      'hrsh7th/cmp-nvim-lsp'
    },
    config = function()
      require('plugins/cmp')
    end
  },
  {
    'L3MON4D3/LuaSnip',
    after = 'nvim-cmp'
  },
  {
    'saadparwaiz1/cmp_luasnip',
    after = 'LuaSnip'
  },
  {
    'hrsh7th/cmp-buffer',
    after = 'cmp_luasnip'
  },
  {
    'hrsh7th/cmp-path',
    after = 'cmp-buffer'
  },
  {
    'hrsh7th/cmp-nvim-lua',
    after = 'cmp-nvim-lsp'
  },
}
