return {
	-- Fuzzy finder and it requirments.
	{
		"nvim-telescope/telescope.nvim",
		as = "telescope",
		after = {
			"telescope_find_directories",
			"telescope-symbols",
			"telescope-fzf-native",
			"telescope-media-files",
			"telescope-project",
			"telescope-ui-select",
			"telescope-file-browser",
			"telescope-frecency",
			"telescope-arecibo",
			"command-palette",
			"smart-history",
			"telescope-cheat",
			-- "cheatsheet.nvim",
			"telescope-z",
			"telescope-github",
			-- "telescope-dap",
			"telescope-bibtex",
			"telescope-packer",
			-- "session-lens",
		},
		opt = false,
		requires = {
			"cljoly/telescope-repo.nvim",
		},
		config = function()
			require("config.telescope")
		end,
	},
	{
		"rmagatti/session-lens",
		as = "session-lens",
		requires = {
			"auto-session",
			"telescope",
		},
		after = "telescope",
		config = function()
			require("telescope").load_extension("session-lens")
			require("config.telescope-sessions")
		end,
	},
	{
		"crispgm/telescope-heading.nvim",
		as = "telescope-heading",
		requires = "telescope",
		after = "telescope",
		config = function()
			require("telescope").load_extension("heading")
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		as = "neoclip",
		requires = {
			"telescope",
			{ "sqlite", module = "sqlite" },
		},
		config = function()
			require("config.neoclip")
		end,
	},
	{
		"nvim-telescope/telescope-bibtex.nvim",
		as = "telescope-bibtex",
	},
	{
		"nvim-telescope/telescope-packer.nvim",
		as = "telescope-packer",
	},
	{
		"AckslD/nvim-gfold.lua",
		config = function()
			require("config.gfold")
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
	{
		"nvim-telescope/telescope-smart-history.nvim",
		as = "smart-history",
		requires = "sqlite",
	},
	{
		"nvim-telescope/telescope-cheat.nvim",
		as = "telescope-cheat",
		requires = "sqlite",
	},
	{
		"nvim-telescope/telescope-github.nvim",
		as = "telescope-github",
		requires = "plenary",
	},
	{
		"nvim-telescope/telescope-z.nvim",
		as = "telescope-z",
		requires = {
			"plenary",
			"popup",
		},
	},
	{
		"nvim-telescope/telescope-project.nvim",
		as = "telescope-project",
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		as = "telescope-fzf-native",
		run = "make",
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
		as = "telescope-media-files",
		requires = {
			"plenary",
			"popup",
		},
	},
	-- NOTE: May conflict with dressing.nvim and popui
	{
		"nvim-telescope/telescope-ui-select.nvim",
		as = "telescope-ui-select",
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		as = "telescope-file-browser",
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		as = "telescope-frecency",
		requires = {
			"sqlite",
			"devicons",
		},
	},
	-- Define and search for custom commands
	{
		"LinArcX/telescope-command-palette.nvim",
		as = "command-palette",
	},
	-- Support web searches from neovim
	{
		"nvim-telescope/telescope-arecibo.nvim",
		as = "telescope-arecibo",
		requires = {
			-- "telescope",
			"treesitter",
		},
		rocks = { "openssl", "lua-http-parser" },
	},
	-- Symbol picker
	-- TODO: Add shruggie symbol and others in custom data file
	{
		"nvim-telescope/telescope-symbols.nvim",
		as = "telescope-symbols",
	},
	-- Directory finder
	{
		"artart222/telescope_find_directories",
		as = "telescope_find_directories",
		after = "telescope-fzf-native",
	},
}
