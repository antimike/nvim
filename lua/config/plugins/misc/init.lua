local misc_plugins = {
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
    -- TrueZen.nvim is a Neovim plugin that aims to provide a cleaner and less cluttered interface
    -- when toggled in either of it's three different modes (Ataraxis, Minimalist and Focus).
    {
        'Pocco81/TrueZen.nvim',
        cmd = {
            'TZFocus',
            'TZAtaraxis',
            'TZMinimalist',
        },
        setup = function()
            require('config.plugins.misc.true-zen')
        end
    },
}
return misc_plugins
