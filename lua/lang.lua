return {
  -- TreeSitter.
  {
    'nvim-treesitter/nvim-treesitter',
    run = ':TSUpdate',
    event = 'BufRead',
    cmd = {
      'TSInstall',
      'TSInstallSync',
      'TSBufEnable',
      'TSBufToggle',
      'TSEnableAll',
      'TSInstallFromGrammer',
      'TSToggleAll',
      'TSUpdate',
      'TSUpdateSync'
    },
    config = function()
      require('plugins/treesitter')
    end
  },
  {'nvim-treesitter/nvim-treesitter-textobjects'},
  {'JoosepAlviste/nvim-ts-context-commentstring'},
  -- To help compose custom TS queries
  {'nvim-treesitter/playground'},
  -- {
  --   'romgrk/nvim-treesitter-context',
  --   config = function()
  --     require('treesitter-context.config').setup {enable = true},
  --   end
  -- },
  -- LSP, LSP installer and tab completion.
  { 'neovim/nvim-lspconfig' },
  { 'williamboman/nvim-lsp-installer' },
  -- LSP signature.
  { "ray-x/lsp_signature.nvim" },

  -- VsCode like pictograms for lsp.
  { 'onsails/lspkind-nvim' },

  -- View and search LSP symbols, tags in Neovim.
  { 'liuchengxu/vista.vim', cmd = 'Vista' },
  -- This is for html and it can autorename too!
  {
    'windwp/nvim-ts-autotag',
    after = 'nvim-treesitter',
  },
  -- Neovim plugin to comment text in and out.
  -- Supports commenting out the current line, a visual selection and a motion.
  -- {
  --   'terrortylor/nvim-comment',
  --   cmd = 'CommentToggle',
  --   config = function()
  --     require('plugins.nvim_comment')
  --   end
  -- },
  {
   'b3nj5m1n/kommentary',
   config = function()
   end
  },
  -- Helps manage package.json
  {
    "vuki656/package-info.nvim",
    requires = "MunifTanjim/nui.nvim",
    config = function()
      require("package-info").setup()
    end,
  },

  -- Rust dependency management
  {
   "Saecki/crates.nvim",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },

  -- Other Rust tools
  {
    'simrat39/rust-tools.nvim',
    config = function()
      require("rust-tools").setup({})
    end
  },

}
