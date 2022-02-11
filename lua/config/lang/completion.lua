local utils = require('utils')
utils.set("shortmess", "+=", "c")
utils.opt('o', 'completeopt', 'menuone,noinsert,noselect')
utils.opt('g', 'completion_confirm_key')
utils.opt('g', 'completion_matching_strategy_list', {'exact', 'substring', 'fuzzy'})
utils.opt('g', 'diagnostic_enable_virtual_text', 1)
utils.opt('g', 'completion_enable_snippet', 'UltiSnips')
utils.opt('g', 'completion_enable_auto_popup', 1)

-- <Tab> to navigate the completion menu
utils.map('i', '<S-Tab>', 'pumvisible() ? "\\<C-p>" : "\\<Tab>"', {expr = true})
utils.map('i', '<Tab>', 'pumvisible() ? "\\<C-n>" : "\\<Tab>"', {expr = true})

local opts = {
    o = {
        completeopt = table.concat({
            'menuone',
            'noinsert',
            'noselect'
        }),
    },
    g = {
        completion = {
            enable = {
                virtual_text = 1,
                snippet = "UltiSnips",
                auto_popup = 1,
            },
            -- `Leaf` function ensures table will be parsed atomically (i.e.,
            -- not as keys to be appended)
            matching_strategy_list = Leaf({
                "exact",
                "substring",
                "fuzzy",
            }),
            confirm_key = "",
        },
    },
}

local bind = {
    completion = {
        'i',
        navigate = {
            back = {
                '<S-Tab>',
                'pumvisible() ? "\\<C-p>" : "\\<Tab>"',
            },
            forward = {
                '<Tab>',
                'pumvisible() ? "\\<C-n>" : "\\<Tab>"',
            },
        }
    }
}
