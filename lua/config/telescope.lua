local present, telescope = pcall(require, "telescope")
if not present then
  return
end

local previewers = require("telescope.previewers")
local Job = require("plenary.job")

-- TODO: Study this
-- (Taken from CodeArt)
local new_maker = function(filepath, bufnr, opts)
  filepath = vim.fn.expand(filepath)
  Job:new({
    command = "file",
    args = { "--mime-type", "-b", filepath },
    on_exit = function(j)
      local mime_type = vim.split(j:result()[1], "/")[1]
      if mime_type == "text" then
        previewers.buffer_previewer_maker(filepath, bufnr, opts)
      else
        -- maybe we want to write something to the buffer here
        vim.schedule(function()
          vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, { "BINARY" })
        end)
      end
    end
  }):sync()
end

local finder = "fd"
if vim.fn.filereadable("/bin/fdfind") == 1 or vim.fn.filereadable("/usr/bin/fdfind") == 1 then
  finder = "fdfind"
end

telescope.setup {
  defaults = {
    buffer_previewer_maker = new_maker,
    vimgrep_arguments = {
      "rg",
      "--color=never",
      "--no-heading",
      "--with-filename",
      "--line-number",
      "--column",
      "--smart-case",
      "--hidden",
      "--glob=!.git/",
    },
    prompt_prefix = "   ",
    selection_caret = " ",
  },
  pickers = {
    find_files = {
      find_command = { finder, "--type=file", "--hidden", "--follow", "--exclude=.git" }
    },
  },
  extensions = {
    media_files = {
      filetypes = {"png", "webp", "jpg", "jpeg", "mp4","webm", "pdf"},
      find_cmd = "rg"
    },
    command_palette = {
      {"File",
        { "entire selection (C-a)", ':call feedkeys("GVgg")' },
        { "save current file (C-s)", ':w' },
        { "save all files (C-A-s)", ':wa' },
        { "quit (C-q)", ':qa' },
        { "file browser (C-i)", ":lua require'telescope'.extensions.file_browser.file_browser()", 1 },
        { "search word (A-w)", ":lua require('telescope.builtin').live_grep()", 1 },
        { "git files (A-f)", ":lua require('telescope.builtin').git_files()", 1 },
        { "files (C-f)",     ":lua require('telescope.builtin').find_files()", 1 },
      },
      {"Help",
        { "tips", ":help tips" },
        { "cheatsheet", ":help index" },
        { "tutorial", ":help tutor" },
        { "summary", ":help summary" },
        { "quick reference", ":help quickref" },
        { "search help(F1)", ":lua require('telescope.builtin').help_tags()", 1 },
      },
      {"Vim",
        { "reload vimrc", ":source $MYVIMRC" },
        { 'check health', ":checkhealth" },
        { "jumps (Alt-j)", ":lua require('telescope.builtin').jumplist()" },
        { "commands", ":lua require('telescope.builtin').commands()" },
        { "command history", ":lua require('telescope.builtin').command_history()" },
        { "registers (A-e)", ":lua require('telescope.builtin').registers()" },
        { "colorshceme", ":lua require('telescope.builtin').colorscheme()", 1 },
        { "vim options", ":lua require('telescope.builtin').vim_options()" },
        { "keymaps", ":lua require('telescope.builtin').keymaps()" },
        { "buffers", ":Telescope buffers" },
        { "search history (C-h)", ":lua require('telescope.builtin').search_history()" },
        { "paste mode", ':set paste!' },
        { 'cursor line', ':set cursorline!' },
        { 'cursor column', ':set cursorcolumn!' },
        { "spell checker", ':set spell!' },
        { "relative number", ':set relativenumber!' },
        { "search highlighting (F12)", ':set hlsearch!' },
      }
    },
    fzf = {
      fuzzy = true,
      override_generic_sorter = true,
      override_file_sorter = true,
      case_mode = "smart_case",
    },
    ["ui-select"] = {
      require("telescope.themes").get_dropdown {
        -- even more opts
      }
    },
    frecency = {
      db_root = "home/hactar/.config/nvim/data",
      show_scores = false,
      show_unindexed = true,
      ignore_patterns = {"*.git/*", "*/tmp/*"},
      disable_devicons = false,
      workspaces = {
        ["conf"]    = "/home/hactar/.config",
        ["data"]    = "/home/hactar/.local/share",
        ["source"] = "/home/hactar/Source",
        ["wiki"]    = "/home/hactar/wiki"
      }
    },
    arecibo = {
      ["selected_engine"]   = 'google',
      ["url_open_command"]  = 'xdg-open',
      ["show_http_headers"] = false,
      ["show_domain_icons"] = false,
    },
    project = {
      base_dirs = {
        '~/Source',
        -- {'~/dev/src2'},
        -- {'~/dev/src3', max_depth = 4},
        -- {path = '~/dev/src4'},
        -- {path = '~/dev/src5', max_depth = 2},
      },
      hidden_files = true -- default: false
    },
  }
}
telescope.load_extension('media_files')
telescope.load_extension('find_directories')
telescope.load_extension('fzf')
telescope.load_extension("ui-select")
-- TODO: Debug frecency config
-- telescope.load_extension("frecency")
telescope.load_extension("arecibo")
telescope.load_extension("project")
telescope.load_extension('command_palette')

-- Suggested by https://alpha2phi.medium.com/vim-neovim-managing-multiple-projects-63180fc87188
-- map('n', '<leader>fp', ':Telescope project<CR>')
-- map('n', '<Leader>fx', "require('custom.telescope').switch_projects()<CR>")
