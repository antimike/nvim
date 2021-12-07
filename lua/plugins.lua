local use = require('packer').use
local utils = require('utils')

return require('packer').startup({function()
  use { 'wbthomason/packer.nvim' }

  local plugins = require('config')
  for _, plugin in pairs(plugins) do
    if type(plugin) == "string" then
      use { plugin }
    else
      use { table.unpack(plugin) }
    end
  end

  -- Import settings of plugins or start plugins.
--  require('lsp_signature').setup()
--  require("which-key").setup()

end,
config = {
  display = {
    open_fn = function()
      return require('packer.util').float({ border = 'single' })
    end
  }
}})
