local misc_ide_plugins = {
    -- Neovim plugin to comment text in and out.
    -- Supports commenting out the current line, a visual selection and a motion.
    {
        'terrortylor/nvim-comment',
        cmd = 'CommentToggle',
        config = function()
            require('nvim_comment').setup()
        end
    },

    -- todo-comments is a lua plugin for Neovim to highlight and search for
    -- todo comments like TODO, HACK, BUG in code base.
    {
        'folke/todo-comments.nvim',
        event = 'BufEnter',
        config = function()
            require('config.plugins.ide.todo-comments')
        end
    },

    -- Snippets
    { 'honza/vim-snippets' },
    { 'SirVer/ultisnips' },
    {
        'rafamadriz/friendly-snippets',
        event = 'InsertEnter'
    },

    -- DAP
    { 'mfussenegger/nvim-dap' },
    { 'nvim-telescope/telescope-dap.nvim' },
    { 'mfussenegger/nvim-dap-python' }, -- Python

    -- Lua development
    { 'tjdevries/nlua.nvim' },

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
            require('config.plugins.ide.treesitter')
        end
    },

    -- Vim dispatch
    { 'tpope/vim-dispatch' },

    -- LSP, LSP installer and tab completion.
    { 'nvim-lua/completion-nvim' },
    { 'neovim/nvim-lspconfig' },
    { 'williamboman/nvim-lsp-installer' },
    {
        'hrsh7th/nvim-cmp',
        after = "friendly-snippets",
        requires = {
            'hrsh7th/cmp-nvim-lsp'
        },
        config = function()
            require('config.plugins.cmp')
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
--    {
--        'hrsh7th/cmp-nvim-lua',
--        after = 'cmp-nvim-lsp'
--    },

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
}
return misc_ide_plugins
