local plugins = {{'wbthomason/packer.nvim', opt = true}}
vim.list_extend(plugins, require("plugins.workspace"))

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
