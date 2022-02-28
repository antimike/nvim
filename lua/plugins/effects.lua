return {
	-- Allows fancy UI hooks
	-- Requires nvim 0.6 for full effect
	-- NOTE: May conflict with popui and telescope-ui-select.nvim
	{
                "stevearc/dressing.nvim",
                as = "dressing",
                config = function()
                        require("config.dressing")
                end
        },

	-- Markdown Preview
	{ "ellisonleao/glow.nvim" },

	-- Register peeking
	"gennaro-tedesco/nvim-peekup",

	-- Auto-resizes splits
	{
		"beauwilliams/focus.nvim",
		config = function()
			require("config.focus")
		end,
	},

	-- Popui: custom popups
	-- NOTE: May conflict with dressing.nvim and telescope-ui-select.nvim
	{
		"RishabhRD/popfix",
	},

	{
		"hood/popui.nvim",
		config = function()
			vim.ui.select = require("popui.ui-overrider")
		end,
	},
}
