local use = require('packer').use

return require('packer').startup({function()
  use { 'wbthomason/packer.nvim' }

  ------------------------ EYE CANDY

  -- Color schemes.
  use { 'sainnhe/gruvbox-material' }
  use { 'sainnhe/edge' }
  use { 'folke/tokyonight.nvim' }
  use { 'bluz71/vim-nightfly-guicolors' }
  use { 'bluz71/vim-moonfly-colors' }
  use { 'shaunsingh/nord.nvim' }
  use { 'navarasu/onedark.nvim' }
  use { 'wuelnerdotexe/vim-enfocado' }

  -- Colorizer (for highlighting color codes).
  use {
    'norcalli/nvim-colorizer.lua',
    event = 'BufRead',
    config = function()
      require('config.plugins.colorize')
      vim.cmd('ColorizerAttachToBuffer')
    end
  }

  -- Scrollbar.
  use {
    'dstein64/nvim-scrollview',
    event = 'BufRead',
    config = function()
      require('config.plugins.nvim-scroll')
    end
  }

  -- Smooth scroll.
  use {
    'karb94/neoscroll.nvim',
    event = 'BufRead',
    config = function()
      require('neoscroll').setup()
    end
  }

  -- Icons.
  use {
    'kyazdani42/nvim-web-devicons',
    event = 'BufEnter'
  }

  -- Bufferline.
  use {
    'akinsho/nvim-bufferline.lua',
    after = 'nvim-web-devicons',
    config  = function()
      require('config.plugins.bufferline')
    end
  }

  -- Statusline.
  use {
    'nvim-lualine/lualine.nvim',
    after = 'nvim-bufferline.lua',
    config = function ()
      require('config.plugins.lualine')
    end
  }

  ------------------------ SEARCH AND NAVIGATION

  -- Fuzzy finder and it requirments.
  use { 'nvim-lua/plenary.nvim' }
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
--  cmd = 'Telescope',
    config = function()
      require('config.plugins.telescope')
    end
  }
  use {
    'nvim-telescope/telescope-fzf-native.nvim', run = 'make',
--    cmd = 'Telescope'
  }
--  use {
--      'nvim-telescope/telescope.nvim'
--  }

  -- File explorer tree.
  use {
    'kyazdani42/nvim-tree.lua',
    cmd = {
      'NvimTreeOpen',
      'NvimTreeFocus',
      'NvimTreeToggle',
    },
    config = function()
      require('config.plugins.nvim-tree')
    end
  }

  ------------------------ TEXT STYLING

  -- This plugin adds indentation guides to all lines (including empty lines).
  use {
    'lukas-reineke/indent-blankline.nvim',
    event = 'BufRead',
    setup = function()
      require('config.plugins.indent-blankline')
    end
  }

  -- This plugin show trailing whitespace.
  use {
    'ntpeters/vim-better-whitespace',
    config = function()
        require('config.plugins.better-whitespace')
    end
  }

  -- Auto closes.
  use {
    'windwp/nvim-autopairs',
    event = 'BufRead',
    config = function()
      require('nvim-autopairs').setup{}
    end
  }

  -- match-up is a plugin that lets you highlight, navigate, and operate on sets of matching text.
  use { 'andymass/vim-matchup' }

  ------------------------ IDE / LANGUAGES

  -- Neovim plugin to comment text in and out.
  -- Supports commenting out the current line, a visual selection and a motion.
  use {
    'terrortylor/nvim-comment',
    cmd = 'CommentToggle',
    config = function()
      require('nvim_comment').setup()
    end
  }

  -- todo-comments is a lua plugin for Neovim to highlight and search for
  -- todo comments like TODO, HACK, BUG in code base.
  use {
    'folke/todo-comments.nvim',
    event = 'BufEnter',
    config = function()
      require('config.plugins.todo-comments')
    end
  }

  -- Snippets
  use { 'honza/vim-snippets' }
  use { 'SirVer/ultisnips' }
  use {
     'rafamadriz/friendly-snippets',
     event = 'InsertEnter'
  }

  -- DAP
  use { 'mfussenegger/nvim-dap' }
  use { 'nvim-telescope/telescope-dap.nvim' }
  use { 'mfussenegger/nvim-dap-python' } -- Python

  -- TrueZen.nvim is a Neovim plugin that aims to provide a cleaner and less cluttered interface
  -- when toggled in either of it's three different modes (Ataraxis, Minimalist and Focus).
  use {
    'Pocco81/TrueZen.nvim',
    cmd = {
      'TZFocus',
      'TZAtaraxis',
      'TZMinimalist',
    },
    setup = function()
      require('config.plugins.true-zen')
    end
  }

  -- Lua development
  use { 'tjdevries/nlua.nvim' }

  -- TreeSitter.
  use {
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
      require('config.plugins.treesitter')
    end
  }

  -- Vim dispatch
  use { 'tpope/vim-dispatch' }
  -- Startup screen.
  use {
    'glepnir/dashboard-nvim',
    cmd = {
      'Dashboard',
      'DashboardChangeColorscheme',
      'DashboardFindFile',
      'DashboardFindHistory',
      'DashboardFindWord',
      'DashboardNewFile',
      'DashboardJumpMarks',
      'SessionLoad',
      'SessionSave'
    },
    setup = function()
        require('config.plugins.dashboard')
    end
  }

  -- LSP, LSP installer and tab completion.
  use { 'nvim-lua/completion-nvim' }
  use { 'neovim/nvim-lspconfig' }
  use { 'williamboman/nvim-lsp-installer' }
  use {
    'hrsh7th/nvim-cmp',
    after = "friendly-snippets",
    requires = {
      'hrsh7th/cmp-nvim-lsp'
    },
    config = function()
      require('config.plugins.cmp')
    end
  }
  use {
    'L3MON4D3/LuaSnip',
    after = 'nvim-cmp'
  }
  use {
    'saadparwaiz1/cmp_luasnip',
    after = 'LuaSnip'
  }
  use {
    'hrsh7th/cmp-buffer',
    after = 'cmp_luasnip'
  }
  use {
    'hrsh7th/cmp-path',
    after = 'cmp-buffer'
  }
  use {
    'hrsh7th/cmp-nvim-lua',
    after = 'cmp-nvim-lsp'
  }

  -- LSP signature.
  use { "ray-x/lsp_signature.nvim" }

  -- VsCode like pictograms for lsp.
  use { 'onsails/lspkind-nvim' }

  -- View and search LSP symbols, tags in Neovim.
  use { 'liuchengxu/vista.vim', cmd = 'Vista' }

  -- This is for html and it can autorename too!
  use {
    'windwp/nvim-ts-autotag',
    after = 'nvim-treesitter',
  }

  ------------------------ TERMINAL / REPL / EXTERNAL TOOLS

  -- Terminal.
  use {
    'akinsho/nvim-toggleterm.lua',
    cmd = 'ToggleTerm',
    setup = function()
      require('config.plugins.toggleterm')
    end
  }

  -- Git support for nvim.
  use {
    'tpope/vim-fugitive',
    cmd = 'Git'
  }

  -- Git signs.
  use {
    'lewis6991/gitsigns.nvim',
    event = 'BufRead',
    config = function()
      require('gitsigns').setup()
    end
  }

  ------------------------ VIM

  -- With this plugin you can resize Neovim buffers easily.
  use {
    'artart222/vim-resize',
    event = 'BufEnter'
  }

  -- WhichKey is a lua plugin that displays a popup with possible
  -- key bindings of the command you started typing.
  use { 'folke/which-key.nvim' }

  -- A plugin for neovim that automatically creates missing directories
  -- on saving a file.
  use {
    'jghauser/mkdir.nvim',
    cmd = 'new',
    config = function()
      require('mkdir')
    end
  }

  -- Import settings of plugins or start plugins.
  require('lsp_signature').setup()
  require("which-key").setup()

end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
