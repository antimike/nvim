local plugins = {{'wbthomason/packer.nvim', opt = true}}
local plugin_groups = {
  "shared",
  "colors",
  "dap",
  "find",
  "workspace",
  "text",
  "git",
  "completion",
  "lang",
  "integrations",
  "effects",
  "focus",
  "notes",
}
for _, g in ipairs(plugin_groups) do
  vim.list_extend(plugins, require("plugins." .. g))
end

return require('packer').startup({
    -- require('lsp_signature').setup()
  plugins,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float {
            border = 'single',
            -- shadow = 'true',
            -- winblend = 20,
        }
      end
    },
    profile = {
        enable = true,
        threshold = 1,
    },
    -- transitive_opt = false,
    -- opt_default = true,
    -- transitive_disable = false,
  }
})
