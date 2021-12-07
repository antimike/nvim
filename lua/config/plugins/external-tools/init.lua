local misc_ext_plugins = {
    -- Terminal.
    {
        'akinsho/nvim-toggleterm.lua',
        cmd = 'ToggleTerm',
        setup = function()
            require('config.plugins.external-tools.toggleterm')
        end
    },

    -- Git support for nvim.
    {
        'tpope/vim-fugitive',
        cmd = 'Git',
        setup = function()
            require('config.plugins.external-tools.fugitive')
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
}
return misc_ext_plugins
