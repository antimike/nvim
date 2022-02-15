return require('packer').startup({
    -- require('lsp_signature').setup()
  {
    {'wbthomason/packer.nvim', opt = true},
    {
      "folke/which-key.nvim",
      config = function()
        require("plugins.whichkey").setup()
      end,
    }
  },
  config = {
    display = {
      open_fn = function()
        return require('packer.util').float({ border = 'single' })
      end
    },
    transitive_opt = false,
    -- opt_default = true,
    transitive_disable = false,
  }
})
