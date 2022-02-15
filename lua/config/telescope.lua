local present, telescope = pcall(require, "telescope")
if not present then
  return
end

if vim.fn.has('win32') == 0 then
  telescope.setup {
    extensions = {
      media_files = {
        filetypes = {"png", "webp", "jpg", "jpeg"},
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
        -- db_root = "home/hactar/path/to/db_root",
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
    },
  }
  telescope.load_extension('media_files')
  telescope.load_extension('fzf')
  telescope.load_extension("ui-select")
  telescope.load_extension("frecency")
  telescope.load_extension("arecibo")
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
