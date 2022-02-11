local utils = require('utils')

-- Map leader to space
vim.g.mapleader = ' '

-- Temp: replace with plugins
utils.map('n', '<C-l>', '<cmd>noh<CR>') -- Clear highlights
utils.map('i', 'jl', '<Esc>')           -- jl to escape

-- Telescope keybindings
utils.map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
utils.map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
utils.map('n', '<leader>fb', '<cmd>Telescope buffers<CR>')
utils.map('n', '<leader>fh', '<cmd>Telescope help_tags<CR>')
utils.map('n', '<leader>fl', '<cmd>Telescope git_files<CR>')

-- DAP keybindings

require('telescope').load_extension('dap')
--require('dbg.python')

local keymap = {
    n = {
        ["<leader>dc"] = {'dap', 'continue'},
        ["<leader>dsv"] = {'dap', 'step_over'},
        ["<leader>dsi"] = {'dap', 'step_into'},
        ["<leader>dso"] = {'dap', 'step_out'},
        ["<leader>dtb"] = {'dap', 'toggle_breakpoint'},
        ["<leader>dsbr"] = {'dap', 'set_breakpoint_conditional'},
        ["<leader>dsbm"] = {'dap', 'set_breakpoint_logged'},
        ["<leader>dro"] = {'dap', 'repl_open'},
        ["<leader>drl"] = {'dap', 'repl_run_last'},
        ["<leader>ff"] = {'search', 'files'},
        ["<leader>fg"] = {'search', 'grep'},
        ["<leader>fb"] = {'search', 'buffers'},
        ["<leader>fh"] = {'search', 'help_tags'},
        ["<leader>fl"] = {'search', 'git_files'},
        ["<leader><C-l>"] = '<cmd>noh<CR>',
        jl = '<Esc>',
    },
}

-- telescope-dap
utils.map('n', '<leader>dcc', '<cmd>lua require"telescope".extensions.dap.commands{}<CR>')
utils.map('n', '<leader>dco', '<cmd>lua require"telescope".extensions.dap.configurations{}<CR>')
utils.map('n', '<leader>dlb', '<cmd>lua require"telescope".extensions.dap.list_breakpoints{}<CR>')
utils.map('n', '<leader>dv', '<cmd>lua require"telescope".extensions.dap.variables{}<CR>')
utils.map('n', '<leader>df', '<cmd>lua require"telescope".extensions.dap.frames{}<CR>')

local dap = {
    continue = nil,
    step_over = nil,
    step_into = nil,
    step_out = nil,
    toggle_breakpoint = nil,
    set_breakpoint = {
        conditional = nil,
        logged = nil
    },
    repl = {
        open = nil,
        run_last = nil
    },
    search = {
        commands = nil,
        configurations = nil,
        list_breakpoints = nil,
        variables = nil,
        frames = nil
    }
}
local search = {
    files = nil,
    grep = nil,
    buffers = nil,
    help_tags = nil,
    git_files = nil,
}
utils.map('n', '<leader>dc', '<cmd>lua require"dap".continue()<CR>') 
utils.map('n', '<leader>dsv', '<cmd>lua require"dap".step_over()<CR>') 
utils.map('n', '<leader>dsi', '<cmd>lua require"dap".step_into()<CR>') 
utils.map('n', '<leader>dso', '<cmd>lua require"dap".step_out()<CR>') 
utils.map('n', '<leader>dtb', '<cmd>lua require"dap".toggle_breakpoint()<CR>') 
utils.map('n', '<leader>dsbr', '<cmd>lua require"dap".set_breakpoint(vim.fn.input("Breakpoint condition: "))<CR>') 
utils.map('n', '<leader>dsbm', '<cmd>lua require"dap".set_breakpoint(nil, nil, vim.fn.input("Log point message: "))<CR>') 
utils.map('n', '<leader>dro', '<cmd>lua require"dap".repl.open()<CR>') 
utils.map('n', '<leader>drl', '<cmd>lua require"dap".repl.run_last()<CR>') 

