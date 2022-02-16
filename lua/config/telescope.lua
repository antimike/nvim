local present, telescope = pcall(require, "telescope")
if not present then
  return
end

if vim.fn.has('win32') == 0 then
  telescope.setup {
    extensions = {
      media_files = {
        filetypes = {"png", "webp", "jpg", "jpeg", "mp4","webm", "pdf"},
        find_cmd = "rg"
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
  telescope.load_extension('fzf')
  telescope.load_extension("ui-select")
  -- TODO: Debug frecency config
  -- telescope.load_extension("frecency")
  telescope.load_extension("arecibo")
  telescope.load_extension("project")
else
  telescope.setup {
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      }
    },
  }
  telescope.load_extension('fzf')
  telescope.load_extension('repo')
end

-- Suggested by https://alpha2phi.medium.com/vim-neovim-managing-multiple-projects-63180fc87188
-- map('n', '<leader>fp', ':Telescope project<CR>')
-- map('n', '<Leader>fx', "require('custom.telescope').switch_projects()<CR>")
