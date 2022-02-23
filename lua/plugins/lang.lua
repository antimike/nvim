return {
  {
    'nvim-treesitter/nvim-treesitter-textobjects',
    as = "ts-textobjects",
    requires = "treesitter",
  },
  {
    'JoosepAlviste/nvim-ts-context-commentstring',
    as = "ts-context-commentstring",
    requires = "treesitter",
  },
  -- To help compose custom TS queries
  {
    'nvim-treesitter/playground',
    as = "playground",
    requires = "treesitter",
  },
  {
    'romgrk/nvim-treesitter-context',
    config = function()
      require('treesitter-context.config').setup {enable = true}
    end
  },
  -- LSP, LSP installer and tab completion.
  -- NOTE: GH page claims that 0.6.1 is required
  {
    'neovim/nvim-lspconfig',
    as = "lspconfig",
  },
  {
    'williamboman/nvim-lsp-installer',
    requires = "lspconfig",
    config = function()
      require("config.lspconfig")
    end
  },
  -- LSP signature.
  {
    "ray-x/lsp_signature.nvim",
    as = "lsp_signature",
  },

  -- VsCode like pictograms for lsp.
  {
    'onsails/lspkind-nvim',
    as = "lspkind"
  },

  -- View and search LSP symbols, tags in Neovim.
  {
    'liuchengxu/vista.vim',
    as = "vista",
    cmd = 'Vista',
    config = function()
      require("config.vista")
    end
  },

  -- This is for html and it can autorename too!
  {
    'windwp/nvim-ts-autotag',
    as = "ts-autotag",
    after = 'treesitter',
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
   as = "kommentary",
   config = function()
     require("config.kommentary")
   end
  },

  -- Code formatter
  {
    "sbdchd/neoformat",
    cmd = "Neoformat"
  },

  {
    "danymat/neogen",
    config = function()
        require('config.neogen')
    end,
    requires = "treesitter",
    -- Uncomment next line if you want to follow only stable versions
    tag = "*"
  },

  -- Helps manage package.json
  {
    "vuki656/package-info.nvim",
    requires = "nui",
    config = function()
      require("package-info").setup()
    end,
  },

  -- Rust dependency management
  {
   "Saecki/crates.nvim",
   as = "crates",
    event = { "BufRead Cargo.toml" },
    config = function()
      require("crates").setup()
    end,
  },

  -- Other Rust tools
  {
    'simrat39/rust-tools.nvim',
    as = "rust-tools",
    config = function()
      require("rust-tools").setup({})
    end
  },
}
