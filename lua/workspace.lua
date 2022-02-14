return {
  -- File explorer tree.
  {
    'kyazdani42/nvim-tree.lua',
    cmd = {
      'NvimTreeOpen',
      'NvimTreeFocus',
      'NvimTreeToggle',
    },
    config = function()
      require('plugins/nvim-tree')
    end
  },

  -- Bufferline.
  -- {
  --   'akinsho/nvim-bufferline.lua',
  --   after = 'nvim-web-devicons',
  --   config  = function()
  --     require('plugins/bufferline')
  --   end
  -- },

  -- NOTE: May conflict with Bufferline
  -- {
  --   'romgrk/barbar.nvim',
  --   requires = {'kyazdani42/nvim-web-devicons'},
  --   config = function()
  --     require("plugins.barbar")
  --   end
  -- },

  -- Statusline.
  -- {
  --   'nvim-lualine/lualine.nvim',
  --   after = 'nvim-bufferline.lua',
  --   config = function ()
  --     require('plugins/lualine')
  --   end
  -- },

  -- Smarter status line context
--   {
--     "SmiteshP/nvim-gps",
--     config = function()
--       require("nvim-gps").setup()
--     end,
--   },
  -- Terminal.
  {
    'akinsho/nvim-toggleterm.lua',
    cmd = 'ToggleTerm',
    setup = function()
      require('plugins/toggleterm')
    end
  },

  -- Git support for nvim.
  {
    'tpope/vim-fugitive',
    cmd = 'Git'
  },
  -- Shows hidden "git messages" for each line
  { "rhysd/git-messenger.vim" },
  -- Magit clone for neovim
  {
   "TimUntersberger/neogit",
   cmd = "Neogit",
   config = function()
      require("custom.neogit").setup()
   end,
  },
  -- Another visual git client
  {
   "tanvirtin/vgit.nvim",
   event = "BufWinEnter",
   config = function()
      require("vgit").setup()
   end,
  },

  -- For better diffs
  {
    "sindrets/diffview.nvim",
    config = function()
      require("plugins.diffview")
    end
  },

  -- Git signs.
  {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('gitsigns').setup()
    end
  },
  -- todo-comments is a lua plugin for Neovim to highlight and search for
  -- todo comments like TODO, HACK, BUG in code base.
  {
    'folke/todo-comments.nvim',
    event = 'BufEnter',
    config = function()
      require('plugins/todo-comments')
    end
  },
  -- WhichKey is a lua plugin that displays a popup with possible
  -- key bindings of the command you started typing.
  { 'folke/which-key.nvim' },

  -- A plugin for neovim that automatically creates missing directories
  -- on saving a file.
  {
    'jghauser/mkdir.nvim',
    cmd = 'new',
    config = function()
      require('mkdir')
    end
  },
  -- With this plugin you can resize Neovim buffers easily.
  {
    'artart222/vim-resize',
    event = 'BufEnter'
  },

  -- Create shareable permalinks with line ranges
  {
    'ruifm/gitlinker.nvim',
    config = function() require("gitlinker").setup() end
  },

  -- Collaborative editing
  {
    'jbyuki/instant.nvim',
    config = function()
      vim.cmd('let g:instant_username = "antimike"')
    end
  },
  -- Startup speed optimization
  "nathom/filetype.nvim",
}
