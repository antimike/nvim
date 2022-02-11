local misc_nav_plugins = {
  -- Fuzzy finder and its requirments.
    { 'nvim-lua/plenary.nvim' },
    {
        'nvim-telescope/telescope.nvim',
        requires = {{'nvim-lua/popup.nvim'}, {'nvim-lua/plenary.nvim'}},
        cmd = 'Telescope',
        config = function()
            require('config.plugins.navigation.telescope')
        end,
        module = {'telescope'},
        provides = {
            navigation = {
                search = {
                    files = 'builtin.find_files',
                    git_files = 'builtin.git_files',
                    grep = {
                        'builtin.grep_string',
                        live = 'builtin.live_grep',
                    },
                },
                explorer = 'builtin.file_browser'
            },
        }
    },
    {
        'nvim-telescope/telescope-fzf-native.nvim', run = 'make',
    --    cmd = 'Telescope'
    },

    -- File explorer tree.
    {
        'kyazdani42/nvim-tree.lua',
        cmd = {
            'NvimTreeOpen',
            'NvimTreeFocus',
            'NvimTreeToggle',
        },
        config = function()
            require('config.plugins.navigation.nvim-tree')
        end
    },
}
return misc_nav_plugins
