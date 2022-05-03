local null_ls = require("null-ls")
local builtins = null_ls.builtins

null_ls.setup({
 sources = {
  builtins.formatting.black,
  builtins.formatting.shfmt,
  -- builtins.formatting.shellharden,
  builtins.formatting.rustfmt,
  -- builtins.formatting.robocop,
  -- builtins.formatting.rome,
  -- builtins.formatting.sqlfluff.with({
  --         extra_args = { "--dialect", "postgres" } -- change to your dialect
  -- }),
  builtins.formatting.jq,
  builtins.formatting.lua_format,
  builtins.diagnostics.eslint,
  builtins.completion.spell,
 },
})
