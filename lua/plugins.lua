local use = require('packer').use
-- local user_plugins = require('../user_settings')

local plugins = {'wbthomason/packer.nvim'}
local function get_plugins(...)
  local paths = table.pack(...)
  for path in ipairs(paths) do
    local found, tbl = pcall(require, path)
    if found then
      for p in ipairs(tbl) do
        table.insert(plugins, p)
      end
    end
  end
end

get_plugins(
  "colors"
)

return require('packer').startup({function()
  use { 'wbthomason/packer.nvim' }


  for _, plugin in ipairs(plugins) do
    if type(plugin) == "string" then
      use { plugin }
    elseif type(plugin) == "table" then
      use(plugin)
    end
  end

  -- Import settings of plugins or start plugins.
  -- require('lsp_signature').setup()
  -- require("which-key").setup()

end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
