local use = require('packer').use
-- local user_plugins = require('../user_settings')

return require('packer').startup({function()
  local plugin_files = {
    "effects",
    "find",
    "colors",
    "text",
    "workspace",
    "focus",
    "completion",
    "lang",
    "../user_settings"
  }
  use {'wbthomason/packer.nvim'}
--   for _, plugin in ipairs(plugins) do
--     if type(plugin) == "string" then
--       use { plugin }
--     elseif type(plugin) == "table" then
--       use(plugin)
--     end
--   end
  for _, file in ipairs(plugin_files) do
    local tbl = require(file)
    if type(tbl) ~= "table" then
      print("Unexpected return type " .. type(tbl) .. " from file " .. file)
    end
    for _, p in ipairs(tbl) do
      -- I have no idea why this is necessary, but it is
      if type(p) == "table" then
        -- use{table.unpack(p)}
        use(p)
      elseif type(p) == "string" then
        use{p}
      end
    end
  end
  -- Import settings of plugins or start plugins.
  require('lsp_signature').setup()
  require("which-key").setup()
end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
