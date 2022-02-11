local pkg = {}

--- Search files from project root using Telescope
function pkg.switch_project()
  require("telescope.builtin").find_files ({
    prompt_title = "< Switch Project >",
    cwd = "$HOME/Source",
  })
end

--- Calculate commentstring based on cursor position
-- See nvim-ts-context-commentstring docs for more info
function pkg.set_comments_cursor()
  require('ts_context_commentstring.internal').calculate_commentstring {
    location = require('ts_context_commentstring.utils').get_cursor_location(),
  }
end

--- Set commentstring to "multiline"
-- See nvim-ts-context-commentstring docs for more info
function pkg.set_multiline_comments()
  require('ts_context_commentstring.internal').update_commentstring({
    key = '__multiline',
  })
end

return pkg
