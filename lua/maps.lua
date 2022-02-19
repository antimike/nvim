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
map("n", "<Leader>D", ":Dashboard<CR>")
map("n", "<Leader>fn", ":DashboardNewFile<CR>")
map("n", "<Leader>bm", ":DashboardJumpMarks<CR>")
map("n", "<C-s>l", ":SessionLoad<CR>")
map("n", "<C-s>s", ":SessionSave<CR>")

-- Telescope.
map("n", "<Leader>fw", ":Telescope live_grep<CR>")
map("n", "<Leader>gt", ":Telescope git_status<CR>")
map("n", "<Leader>cm", ":Telescope git_commits<CR>")
map("n", "<Leader>ff", ":Telescope find_files<CR>")
map("n", "<Leader>fp", ":lua require('telescope').extensions.media_files.media_files()<CR>")
map("n", "<Leader>fb", ":Telescope buffers<CR>")
map("n", "<Leader>fh", ":Telescope help_tags<CR>")
map("n", "<Leader>fo", ":Telescope oldfiles<CR>")
map("n", "<Leader>th", ":Telescope colorscheme<CR>")

-- Lsp
map('n', '<space>,', ':lua vim.lsp.diagnostic.goto_prev()<CR>')
map('n', '<space>;', ':lua vim.lsp.diagnostic.goto_next()<CR>')
map('n', '<space>a', ':lua vim.lsp.buf.code_action()<CR>')
map('n', '<leader>gd', ':lua vim.lsp.buf.definition()<CR>')
map('n', '<space>f', ':lua vim.lsp.buf.formatting()<CR>')
map('n', '<space>h', ':lua vim.lsp.buf.hover()<CR>')
map('n', '<space>m', ':lua vim.lsp.buf.rename()<CR>')
map('n', '<space>r', ':lua vim.lsp.buf.references()<CR>')
map('n', '<space>s', ':lua vim.lsp.buf.document_symbol()<CR>')

-- ToggleTerm
map('n', '<C-t>', ':ToggleTerm<CR>')
map('t', '<C-t>', ':ToggleTerm<CR>')
map('n', 'v:count1 <C-t>', ':v:count1' .. '"ToggleTerm"<CR>')
map('v', 'v:count1 <C-t>', ':v:count1' .. '"ToggleTerm"<CR>')
function _G.set_terminal_keymaps()
  map('t', '<esc>', '<C-\\><C-n>')
  map('t', 'jk', '<C-\\><C-n>')
  map('t', '<A-h>', '<c-\\><c-n><c-w>h')
  map('t', '<A-j>', '<c-\\><c-n><c-w>j')
  map('t', '<A-k>', '<c-\\><c-n><c-w>k')
  map('t', '<A-l>', '<c-\\><c-n><c-w>l')

  map('t', '<S-h>', '<c-\\><C-n>:call ResizeLeft(3)<CR>')
  map('t', '<S-j>', '<c-\\><C-n>:call ResizeDown(1)<CR>')
  map('t', '<S-k>', '<c-\\><C-n>:call ResizeUp(1)<CR>')
  map('t', '<S-l>', '<c-\\><C-n>:call ResizeRight(3)<CR>')
end
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Remove unnecessary white spaces.
map('n', '<leader>cw', ':StripWhitespace<CR>')

-- TrueZen focus mode.
map('n', '<leader>Fs', ':TZFocus<CR>')

-- Toggle fold.
map('n', '<leader>ft', 'za')

-- comment
-- map("n", "ct", ":CommentToggle<CR>")
-- map("v", "ct", ":'<,'>CommentToggle<CR>")
vim.g.kommentary_create_default_mappings = false
map('n', '<leader>ct', '<Plug>kommentary_line_default', {})
map('v', '<leader>ct', '<Plug>kommentary_visual_default', {})

-- Don't copy the replaced text after pasting.
map("v", "p", "\"_dP")

-- Jl for going to normal mode while you are in insert mode.
map("i", "jl", "<ESC>")

-- With this you can use > < multiple time for changing indent when you visual selected text.
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Ranger
-- map('t', '<M-i>', '<C-\\><C-n>:RnvimrResize<CR>', {silent = true})
map('n', '<M-o>', ':RnvimrToggle<CR>', {silent = true})
-- map('t', '<M-o>', '<C-\\><C-n>:RnvimrToggle<CR>', {silent = true})

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
    c = { ":PackerClean<CR>", "Compile plugins" },
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
    w = { ":Telescope live_grep<CR>", "Word" },
    f = { ":Telescope find_files<CR>", "File" },
    o = { ":Telescope oldfiles<CR>", "Old File" },
    d = { ":Telescope find_directories<CR>", "Directory" },
    b = { ":Telescope buffers<CR>", "Buffer" },
    h = { ":Telescope help_tags<CR>", "Help File" },
    B = { ":DashboardJumpMarks<CR>", "Find BookMark" },
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
    h = { ":Telescope colorscheme<CR>", "Find Colorscheme" },
    p = { ":Telescope colorscheme enable_preview=true<CR>", "Find Colorscheme with previwer " },
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
    a = { ":lua vim.lsp.buf.code_action()<CR>", "Code Action" },
    d = { ":Telescope diagnostics<CR>", "Diagnostics" },
    i = { ":LspInfo<CR>", "Info" },
    I = { ":LspInstallInfo<CR>", "Installer Info" },
    r = { ":lua vim.lsp.buf.rename()<CR>", "Rename" },
    h = { ":lua vim.lsp.buf.hover()<CR>", "Display Information Of Symbol" },
    s = { ":lua vim.lsp.buf.signature_help()<CR>", "Signature Help" },
    g = {
      name = "GOTO",
      D = { ":lua vim.lsp.buf.declaration()<CR>", "Go To Declaration" },
      i = { ":lua vim.lsp.buf.implementation()<CR>", "Go To Implementation" },
      d = { "::lua vim.lsp.buf.definition()<CR>", "Go to Definition" },
      j = { ":lua vim.lsp.diagnostic.goto_prev()<CR>", "Go To Previous Diagnostics" },
      k = { ":lua vim.lsp.diagnostic.goto_next()<CR>", "Go To Next Diagnostics" },
      t = { ":lua vim.lsp.buf.type_definition()<CR>", "Go To Type Definition" },
    },
    w = {
      name = "Workspace",
      l = { ":lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", "List Workspace Folder" },
      a = { ":lua vim.lsp.buf.add_workspace_folder()<CR>", "Add Workspace Folder" },
      r = { ":lua vim.lsp.buf.remove_workspace_folder()<CR>", "Remove Workspace Folder" },
    },
    l = {
      name = "List Reference/Diagnostic",
      d = { ":lua vim.lsp.diagnostic.set_loclist()<CR>", "List Diagnostic" },
      r = { ":lua vim.lsp.buf.references()<CR>", "Show References" },
    },
  }
}, { prefix = "<leader>" })


-- Dap
wk.register({
  d = {
    name = "Debugging",
    c = { ":lua require(\"dap\").continue()<CR>", "Continue" },
    t = { ":lua require(\"dap\").terminate()<CR>", "Terminate" },
    l = { ":lua require(\"dap\").run_last()<CR>", "Run Last Debugging Config" },
    d = { ":lua require(\"dap\").repl.open()<CR>", "Open Debug Console" },
    b = {
      name = "Breakpoint",
      t = { ":lua require(\"dap\").toggle_breakpoint()<CR>", "Toggle" },
      c = { ":lua require(\"dap\").set_breakpoint(vim.fn.input(\"Breakpoint condition: \"))<CR>", "Set conditional" },
      l = { ":lua require(\"dap\").set_breakpoint(nil, nil, vim.fn.input(\"Log point message: \"))<CR>", "With Log Point Message" },
    },
    s = {
      name = "Step",
      o = { ":lua require(\"dap\").step_over()<CR>", "Step Over" },
      O = { ":lua require(\"dap\").step_into()<CR>", "Step Into" },
      i = { ":lua require(\"dap\").step_out()<CR>", "Step Out" },
      b = { ":lua require(\"dap\").step_back()<CR>", "Step Back" },
      c = { ":lua require(\"dap\").run_to_cursor()<CR>", "Run To Cursor" },
    },
    u = { ":lua require(\"dapui\").toggle()<CR>", "Toggle UI" },
  }
}, { prefix = "<leader>" })
