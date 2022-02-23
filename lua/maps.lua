local wk = require("which-key")
local defaults = {
  nowait = false,
  silent = true,
  unique = true,
  script = false,
  expr = false,
  noremap = true,
}

local map = function(mode, lhs, rhs, opts)
  opts = vim.tbl_extend("force", defaults, opts or {})
  vim.api.nvim_set_keymap(mode, lhs, rhs, opts)
end

-- Map leader key to backslash.
vim.g.mapleader = [[\]]

-- Split navigations.
map('n', '<A-j>', '<C-w><C-j>')
map('n', '<A-k>', '<C-w><C-k>')
map('n', '<A-l>', '<C-w><C-l>')
map('n', '<A-h>', '<C-w><C-h>')

-- Buffer switching.
map('n', '<A-[>', ':BufferLineCyclePrev<CR>')
map('n', '<A-]>', ':BufferLineCycleNext<CR>')

-- Buffer closing.
map('n', '<leader>bc', ':BufferLinePickClose<CR>')

-- Buffer moving.
map('n', '<leader>bl', ':BufferLineMoveNext<CR>')
map('n', '<leader>bh', '::BufferLineMovePrev<CR>')

-- Buffer resizing.
map('n', '<C-A-h>', ':call ResizeLeft(3)<CR><Esc>')
map('n', '<C-A-l>', ':call ResizeRight(3)<CR><Esc>')
map('n', '<C-A-k>', ':call ResizeUp(1)<CR><Esc>')
map('n', '<C-A-j>', ':call ResizeDown(1)<CR><Esc>')

-- Dashboard
wk.register({
    D = {":Dashboard<CR>", "Dashboard"},
}, {prefix = '<leader>'})

-- Session Management
wk.register({
    ["<C-s>"] = {
        name = "Session",
        s = {":SessionLoad<CR>", "Load Session"},
        S = {":SessionSave<CR>", "Save Session"},
    }
}, {prefix = '<leader>'})

-- ToggleTerm
map('n', '<C-t>', ':ToggleTerm<CR>')
map('t', '<C-t>', ':ToggleTerm<CR>')
map('n', 'v:count1 <C-t>', ':v:count1' .. '"ToggleTerm"<CR>')
map('v', 'v:count1 <C-t>', ':v:count1' .. '"ToggleTerm"<CR>')
function _G.set_terminal_keymaps()
  -- map('t', '<esc>', '<C-\\><C-n>')
  -- map('t', 'jl', '<C-\\><C-n>')
  map('t', '<A-h>', '<c-\\><c-n><c-w>h')
  map('t', '<A-j>', '<c-\\><c-n><c-w>j')
  map('t', '<A-k>', '<c-\\><c-n><c-w>k')
  map('t', '<A-l>', '<c-\\><c-n><c-w>l')

  map('t', '<S-h>', '<c-\\><C-n>:call ResizeLeft(3)<CR>')
  map('t', '<S-j>', '<c-\\><C-n>:call ResizeDown(1)<CR>')
  map('t', '<S-k>', '<c-\\><C-n>:call ResizeUp(1)<CR>')
  map('t', '<S-l>', '<c-\\><C-n>:call ResizeRight(3)<CR>')
end
-- vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Code runners and REPLs
wk.register({
  r = {
    name = "Code Runners",
    r = {"<Plug>ReplSend", "Send text motion to REPL"},
    s = {"<Plug>SnipRunOperator", "Send text motion to SnipRun"},
    i = {"<Plug>SnipInfo", "Display language-specific info"},
    sl = {"<Plug>SnipRun", "Send current line to SnipRun"},
    d = {":DashRun<CR>", "Run script with Dash"},
    rl = {"<Plug>ReplSendLine", "Send current line to REPL"},
    p = {
        name = "iPython",
        c = {"<Plug>IPy-RunCell", "Run current cell"},
        r = {"<Plug>IPy-RunOp", "Run movement or text object"},
        rl = {"<Plug>IPy-Run", "Run current line"},
        a = {"<Plug>IPy-RunAll", "Execute all lines in buffer"},
        C = {"<Plug>IPy-Complete", "Kernel code completion"},
        i = {"<Plug>IPy-WordObjInfo", "Inspect variable under cursor"},
        t = {"<Plug>IPy-Interrupt", "Send SIGINT to kernel"},
        T = {"<Plug>IPy-Terminate", "Terminate kernel"},
    },
  }
}, {prefix = '<leader>', mode = 'n', silent = true})

wk.register({
    r = {
        name = "Code Runners",
        r = {"<Plug>ReplSend", "Send selection to REPL"},
        s = {"<Plug>SnipRun", "Send selection to SnipRun"},
    }
}, {prefix = '<leader>', mode = 'v', silent = true})

-- Comments
wk.register({
    c = {
        name = "Comment",
        i = {"Increase comment level"},
        d = {"Decrease comment level"},
        t = {"Kommentary line default"},
        f = {function() require('nvim-comment-frame').add_comment() end, "Single-Line Comment Frame"},
        F = {function() require('nvim-comment-frame').add_multiline_comment() end, "Multiline Comment Frame"},
        p = {":ProComment<CR>", "Add comment with ProComment"},
    }
}, {prefix = '<leader>', mode = 'n', silent = true})

wk.register({
    c = {
        name = "Comment",
        i = {"Increase comment level"},
        d = {"Decrease comment level"},
        t = {"Kommentary line default"},
    }
}, {prefix = '<leader>', mode = 'v', silent = true})

-- Remove unnecessary white spaces.
wk.register({
    w = {':StripWhitespace<CR>', "Strip Whitespace"},
}, {prefix = '<leader>', mode = 'n', silent = true})

-- Toggle fold.
wk.register({
    z = {'za', "Toggle Fold"},
}, {prefix = '<leader>'})

-- Don't copy the replaced text after pasting.
map("v", "p", "\"_dP")

-- Jl for going to normal mode while you are in insert / visual mode.
map("i", "jl", "<ESC>")
map("v", "jl", "<ESC>")

-- With this you can use > < multiple time for changing indent when you visual selected text.
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Ranger
-- map('t', '<M-i>', '<C-\\><C-n>:RnvimrResize<CR>', {silent = true})
-- map('n', '<M-o>', ':RnvimrToggle<CR>', {silent = true})
-- map('t', '<M-o>', '<C-\\><C-n>:RnvimrToggle<CR>', {silent = true})

-- File Managers
wk.register({
    o = {":Ranger<CR>", "Ranger (File Manager)"},
}, {prefix = '<leader>'})

-- Cheatsheets
wk.register({
    C = {":Cheatsheet<CR>", "Cheatsheets"},
}, {prefix = '<leader>'})

-- Buffer
wk.register({
  b = {
    name = "Buffer",
    c = { ":BufferLinePickClose<CR>", "Close Buffer" },
    e = { ":noh<CR>", "Erase Search Highlights" },
    l = { ":BufferLineMoveNext<CR>", "Move Buffer Right" },
    h = { ":BufferLineMovePrev<CR>", "Move buffer Left" },
    n = { ":DashboardNewFile<CR>", "New Buffer"},
    r = { ":Neoformat<CR>", "Format Buffer" },
    m = { ":TZFocus<CR>", "Maximize Current Buffer" },
  }
}, { prefix = "<leader>" })


-- Packer
wk.register({
  p = {
    name = "Packer",
    i = { ":PackerInstall<CR>", "Install plugins" },
    u = { ":PackerUpdate<CR>", "Update plugins" },
    r = { ":PackerClean<CR>", "Uninstall unused plugins" },
    s = { ":PackerSync<CR>", "Sync plugins" },
    c = { ":PackerCompile<CR>", "Compile plugins" },
  }
}, { prefix = "<leader>" })


-- NvimTree
wk.register({
  n = {
    name = "NvimTree",
    t = { ":NvimTreeToggle<CR>", "Toggle NvimTree" },
    f = { ":NvimTreeFocus<CR>", "Focus on NvimTree" },
  }
}, { prefix = "<leader>" })


-- Fuzzy finder.
wk.register({
  f = {
    name = "Find",
    w = { ":Telescope live_grep<CR>", "Words" },
    f = { ":Telescope find_files<CR>", "Files" },
    o = { ":Telescope oldfiles<CR>", "Old Files" },
    d = { ":Telescope find_directories<CR>", "Directory" },
    b = { ":Telescope buffers<CR>", "Buffers" },
    h = { ":Telescope help_tags<CR>", "Help Files" },
    B = { ":DashboardJumpMarks<CR>", "Find BookMark" },
    p = { function() require('telescope').extensions.media_files.media_files() end, "Media files" },
    n = { "Telescope notify<CR>", "Notifications" },
  }
}, { prefix = "<leader>" })

-- Git keybinds.
wk.register({
  g = {
    name = "Git",
    s = { ":Telescope git_status<CR>", "Status + Git Diff" },
    c = { ":Telescope git_commits<CR>", "Commit History" },
    C = { ":Telescope git_bcommits<CR>", "Buffer Commit History" },
    b = { ":Telescope git_branches<CR>", "Branches History" },
    k = { ":Gitsigns prev_hunk<CR>", "Next Hunk" },
    j = { ":Gitsigns next_hunk<CR>", "Prev Hunk" },
    p = { ":Gitsigns preview_hunk<CR>", "Preview Hunk" },
    r = { ":Gitsigns reset_hunk<CR>", "Reset Hunk" },
    R = { ":Gitsigns reset_buffer<CR>", "Reset Buffer" },
    d = { ":Gitsigns diffthis<CR>", "Git Diff" },
    l = { ":Gitsigns blame_line<CR>", "Blame For Current Line"},
    S = { ":Gitsigns stage_hunk<CR>", "Stage Hunk"},
    u = { ":Gitsigns undo_stage_hunk<CR>", "Undo Stage Hunk"},
    g = { ":VGit buffer_gutter_blame_preview<CR>", "Buffer Gutter Blame Preview" },
    H = { ":VGit project_hunks_preview<CR>", "Project Hunks Preview" },
    D = { ":VGit project_diff_preview<CR>", "Project Diff Preview" },
    i = { ":Neogit<CR>", "Interactive Git Client (Neogit)" },
    m = { ":GitMessenger<CR>", "Summary of Git Data for Current Line" },  -- Default mapping configured by plugin (git-messenger)
    t = { ":Tig<CR>", "Git Explorer (Tig)" }
    },
}, { prefix = "<leader>" })


-- ColorScheme keybindings.
wk.register({
  t = {
    name = "Theme",
    c = { ":Telescope colorscheme<CR>", "Set Colorscheme" },
  }
}, { prefix = "<leader>" })

-- Focus
wk.register({
  F = {
    name = "Focus",
    s = { ":TZFocus<CR>", "TrueZen Focus Mode" },
    t = { ":FocusToggle<CR>", "Toggle Split Auto-Resizing" },
    n = { ":FocusSplitNicely<CR>", "Split Window based on Golden Ratio"},
    m = { ":FocusMaximise<CR>", "Maximize Window" },
    e = { ":FocusEqualise<CR>", "Equalize Splits" },
  }
}, { prefix = "<leader>" })

-- Lsp
wk.register({
  l = {
    name = "LSP",
    a = { function() vim.lsp.buf.code_action() end, "Code Action" },
    d = { ":Telescope diagnostics<CR>", "Diagnostics" },
    i = { ":LspInfo<CR>", "Info" },
    I = { ":LspInstallInfo<CR>", "Installer Info" },
    r = { function() vim.lsp.buf.rename() end, "Rename" },
    h = { function() vim.lsp.buf.hover() end, "Display Information Of Symbol" },
    f = {
        name = "Format",
        b = {function() vim.lsp.buf.formatting() end, "Format Buffer"},
    },
    A = {
        name = "Annotate (NeoGen)",
        f = {function() require("neogen").generate {type = "func"} end, "Annotate Function"},
        c = {function() require("neogen").generate {type = "class"} end, "Annotate Function"},
        t = {function() require("neogen").generate {type = "type"} end, "Annotate Function"},
        F = {function() require("neogen").generate {type = "file"} end, "Annotate Function"},
    },
    D = {
        name = "Document",
        s = {function() vim.lsp.buf.document_symbol() end, "Document Symbol"},
        p = {":ProDoc<CR>", "Add Docs with ProDoc"},
    },
    s = { function() vim.lsp.buf.signature_help() end, "Signature Help" },
    g = {
      name = "GOTO",
      D = { function() vim.lsp.buf.declaration() end, "Go To Declaration" },
      i = { function() vim.lsp.buf.implementation() end, "Go To Implementation" },
      d = { function() vim.lsp.buf.definition() end, "Go to Definition" },
      j = { function() vim.lsp.diagnostic.goto_prev() end, "Go To Previous Diagnostics" },
      k = { function() vim.lsp.diagnostic.goto_next() end, "Go To Next Diagnostics" },
      t = { function() vim.lsp.buf.type_definition() end, "Go To Type Definition" },
    },
    w = {
      name = "Workspace",
      l = { function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, "List Workspace Folder" },
      a = { function() vim.lsp.buf.add_workspace_folder() end, "Add Workspace Folder" },
      r = { function() vim.lsp.buf.remove_workspace_folder() end, "Remove Workspace Folder" },
    },
    l = {
      name = "List Reference/Diagnostic",
      d = { function() vim.lsp.diagnostic.set_loclist() end, "List Diagnostic" },
      r = { function() vim.lsp.buf.references() end, "Show References" },
    },
  }
}, { prefix = "<leader>" })

-- Dap
wk.register({
  d = {
    name = "Debugging",
    c = { function() require('dap').continue() end, "Continue" },
    t = { function() require('dap').terminate() end, "Terminate" },
    l = { function() require('dap').run_last() end, "Run Last Debugging Config" },
    d = { function() require('dap').repl.open() end, "Open Debug Console" },
    b = {
      name = "Breakpoint",
      t = { function() require('dap').toggle_breakpoint() end, "Toggle" },
      c = { function() require('dap').set_breakpoint(vim.fn.input("Breakpoint condition: ")) end, "Set conditional" },
      l = { function() require("dap").set_breakpoint(nil, nil, vim.fn.input("Log point message: ")) end, "With Log Point Message" },
    },
    s = {
      name = "Step",
      o = { function() require("dap").step_over() end, "Step Over" },
      O = { function() require("dap").step_into() end, "Step Into" },
      i = { function() require("dap").step_out() end, "Step Out" },
      b = { function() require("dap").step_back() end, "Step Back" },
      c = { function() require("dap").run_to_cursor() end, "Run To Cursor" },
    },
    u = { function() require("dapui").toggle() end, "Toggle UI" },
  }
}, { prefix = "<leader>" })
