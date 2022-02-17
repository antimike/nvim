local conf = require('kommentary.config')

conf.use_extended_mappings()

local langs = conf.config -- all default supported langs
for lang, _ in pairs(langs) do
  conf.configure_language(lang, {
    single_line_comment_string = 'auto',
    multi_line_comment_strings = 'auto',
    use_consistent_indentation = true,
    ignore_whitespace = true,
    hook_function = function()
      require('ts_context_commentstring.internal').update_commentstring()
    end,
  })
end
