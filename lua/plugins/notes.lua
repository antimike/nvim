return {
    {
        "oberblastmeister/neuron.nvim",
        as = "neuron",
        requires = {
            "popup",
            "plenary",
            "telescope",
        },
        after = "telescope",
        config = function()
            require("config.neuron")
        end,
    },
    {
        'jbyuki/nabla.nvim',
        as = "nabla",
    },
    {
        'nvim-orgmode/orgmode',
        as = 'orgmode',
        -- NOTE: Lazy loading is not recommended by author
        ft = {'org'},
        requires = "treesitter",
        config = function()
            require('config.orgmode')
        end,
    },
    {
        'lukas-reineke/headlines.nvim',
        as = 'headlines',
        ft = {
            'org',
            'md',
            'markdown',
            'vimwiki',
            'rmd',
            'yaml',
        },
        config = function()
            require('config.headlines')
        end,
    },
    {
        'jubnzv/mdeval.nvim',
        as = 'mdeval',
        ft = {
            'org',
            'md',
            'markdown',
            'vimwiki',
            'rmd',
        },
        config = function()
            require('config.mdeval')
        end,
    },
    {
        'akinsho/org-bullets.nvim',
        as = 'org-bullets',
        ft = 'org',
        config = function()
          require("org-bullets").setup {
            symbols = { "◉", "○", "✸", "✿" }
            -- or a function that receives the defaults and returns a list
            -- -- symbols = function(default_list)
            -- --   table.insert(default_list, "♥")
            -- --   return default_list
            -- -- end
          }
        end,
    },
    -- ASCII Diagrams
    {
        "jbyuki/venn.nvim",
        as = "venn",
    },
    {
        'renerocksai/calendar-vim',
        as = 'calendar',
    },
    {
        'renerocksai/telekasten.nvim',
        as = 'telekasten',
        requires = {
            'telescope',
            'calendar',
        },
        after = {
            'telescope',
            'calendar',
        },
        config = function()
            require('config.telekasten')
        end,
    }
}
