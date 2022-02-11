local conf = require('kommentary.config')

conf.use_extended_mappings()

-- Provided to illustrate config options
-- See kommentary.nvim docs for more info
conf.configure_language("rust", {
  single_line_comment_string = "//",
  multi_line_comment_strings = {"/*", "*/"},
})

conf.configure_language(
  {"typescriptreact", "markdown", "tex"},
  {
    single_line_comment_string = "auto",
    multi_line_comment_strings = "auto",
    hook_function = function()
      require("ts_context_commentstring.internal").update_commentstring()
    end
  })
