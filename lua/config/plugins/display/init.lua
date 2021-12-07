local utils = require('utils')
local misc_display_plugins = {
    -- Startup screen.
    {
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
            require('config.plugins.display.dashboard')
        end
    },

    -- Scrollbar.
    {
        'dstein64/nvim-scrollview',
        event = 'BufRead',
        config = function()
            require('config.plugins.display.nvim-scroll')
        end
    },

    -- Smooth scroll.
    {
        'karb94/neoscroll.nvim',
        event = 'BufRead',
        config = function()
            require('neoscroll').setup()
        end
    },

    -- Icons.
    {
        'kyazdani42/nvim-web-devicons',
        event = 'BufEnter'
    },

    -- Bufferline.
    {
        'akinsho/nvim-bufferline.lua',
        after = 'nvim-web-devicons',
        config  = function()
            require('config.plugins.display.bufferline')
        end
    },

    -- Statusline.
    {
        'nvim-lualine/lualine.nvim',
        after = 'nvim-bufferline.lua',
        config = function ()
            require('config.plugins.display.lualine')
        end
    },

    -- With this plugin you can resize Neovim buffers easily.
    {
        'artart222/vim-resize',
        event = 'BufEnter'
    }
}
return utils.concat(
    misc_display_plugins,
    require('config.plugins.display.colorscheme')
)
