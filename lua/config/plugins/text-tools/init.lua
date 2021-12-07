local misc_text_plugins = {
    -- This plugin adds indentation guides to all lines (including empty lines).
    {
        'lukas-reineke/indent-blankline.nvim',
        event = 'BufRead',
        setup = function()
            require('config.plugins.text-tools.indent-blankline')
        end
    },

    -- This plugin show trailing whitespace.
    {
        'ntpeters/vim-better-whitespace',
        config = function()
            require('config.plugins.text-tools.better-whitespace')
        end
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
}
return misc_text_plugins
