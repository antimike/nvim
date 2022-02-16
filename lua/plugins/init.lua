local plugins = {{'wbthomason/packer.nvim', opt = true}}
local plugin_groups = {
  "shared",
  "workspace",
  "colors",
  "find",
  "text",
  "git",
  "completion",
  "lang",
  "integrations",
  "effects",
  "focus",
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
        return require('packer.util').float({ border = 'single' })
      end
    },
    -- transitive_opt = false,
    -- opt_default = true,
    -- transitive_disable = false,
  }
})
