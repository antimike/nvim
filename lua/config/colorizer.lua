-- Example illustrating various config options with sensible defaults
-- Use the `default_options` as the second parameter, which uses
-- `foreground` for every mode.
require('colorizer').setup(
  {
    '*', -- Highlight all files, but customize some others.
    '!vim', -- Exclude vim from highlighting.
    css = { rgb_fn = true; }, -- Enable parsing rgb(...) functions in css.
    html = { names = false; }, -- Disable parsing "names" like Blue or Gray
  },
  { mode = 'foreground' }   -- Default
)

-- This was included in CodeArt config...not sure why it's necessary
-- vim.cmd('ColorizerAttachToBuffer')
