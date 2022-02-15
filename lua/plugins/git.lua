--- Git-related plugins
return {
  -- Git support for nvim.
  {
    'tpope/vim-fugitive',
    as = "fugitive",
    cmd = 'Git'
  },
  -- Shows hidden "git messages" for each line
  {
    "rhysd/git-messenger.vim",
    as = "git-messenger",
    cmd = "GitMessenger",
  },
  -- Magit clone for neovim
  {
   "TimUntersberger/neogit",
   as = "neogit",
   cmd = "Neogit",
   requires = "diffview",
   config = function()
      require("plugins.neogit").setup()
   end,
  },
  -- Another visual git client
  {
    "tanvirtin/vgit.nvim",
    as = "vgit",
    requires = {
      'nvim-lua/plenary.nvim'
    },
    event = "BufWinEnter",
    config = function()
      -- require("vgit").setup()
      require("config.vgit").setup()
    end,
  },

  -- For better diffs
  {
    "sindrets/diffview.nvim",
    as = "diffview",
    requires = {
      'nvim-lua/plenary.nvim'
    },
    config = function()
      require("config.diffview")
    end
  },

  -- Git signs.
  {
    'lewis6991/gitsigns.nvim',
    as = "gitsigns",
    requires = {
      'nvim-lua/plenary.nvim'
    },
    event = 'BufRead',
    config = function()
      require('config.gitsigns').setup()
    end
  },
}
