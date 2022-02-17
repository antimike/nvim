return {
  {
    "mfussenegger/nvim-dap",
    event = "BufRead",
  },
  {
    "Pocco81/DAPInstall.nvim",
    after = "nvim-dap"
  },
  {
    "rcarriga/nvim-dap-ui",
    after = "DAPInstall.nvim",
    config = function ()
      require("config.dap")
    end
  },
}
