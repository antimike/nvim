-- local use = require('packer').use
-- local user_plugins = require('../user_settings')

Plugins = {
  {'wbthomason/packer.nvim', opt = true}
}
local plugin_files = {
  "effects",
  -- "find",
  -- "colors",
  -- "text",
  -- "workspace",
  -- "focus",
  -- "completion",
  -- "lang",
  -- "../user_settings"
}
for _, f in ipairs(plugin_files) do
  local ps = require(f)
  if type(ps) == "table" then
    vim.list_extend(Plugins, ps)
  else
    print("Unexpected return type " .. type(ps) .. " from file " .. f)
  end
end

return require('packer').startup({
    -- Import settings of plugins or start plugins.
    -- require('lsp_signature').setup()
    -- require("which-key").setup()
  Plugins,
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    }
  }
})
