return {
	{
		"mfussenegger/nvim-dap",
		as = "nvim-dap",
		event = "BufRead",
	},
	{
		"Pocco81/DAPInstall.nvim",
		as = "DAPInstall",
		after = "nvim-dap",
	},
	{
		"rcarriga/nvim-dap-ui",
		as = "nvim-dap-ui",
		after = "DAPInstall",
		config = function()
			require("config.dap")
		end,
	},
	{
		"nvim-telescope/telescope-dap.nvim",
		as = "telescope-dap",
		requires = "nvim-dap",
		after = "nvim-dap",
		config = function()
			require("telescope").load_extension("dap")
		end,
	},
}
