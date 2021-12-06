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
      }
    },
  }
  telescope.load_extension('media_files')
  telescope.load_extension('fzf')
else
  telescope.setup {
    defaults = {
    -- Default configuration for telescope goes here:
    -- config_key = value,
      mappings = {
        i = {
          -- map actions.which_key to <C-h> (default: <C-/>)
          -- actions.which_key shows the mappings for your picker,
          -- e.g. git_{create, delete, ...}_branch for the git_branches picker
          ["<C-h>"] = "which_key"
        }
      }
    },
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
end
