return {
	-- Allows fancy UI hooks
	-- Requires nvim 0.6 for full effect
	-- NOTE: May conflict with popui and telescope-ui-select.nvim
	{
		"stevearc/dressing.nvim",
		as = "dressing",
		config = function()
			require("config.dressing")
		end,
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
	{
		"xiyaowong/nvim-transparent",
		as = "transparent",
		config = function()
			require("config.transparent")
		end,
	},
	{
		"wfxr/minimap.vim",
		as = "minimap",
		config = function()
			require("config.minimap")
		end,
	},
	-- Quickfix popup
	{
		"kevinhwang91/nvim-bqf",
                as = "bqf",
                ft = "qf",
		requires = "treesitter",
		after = "treesitter",
                config = function()
                        require("config.bqf")
                end,
	},
}
