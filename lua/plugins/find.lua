return {
	-- Fuzzy finder and it requirments.
	{
		"nvim-telescope/telescope.nvim",
		as = "telescope",
		opt = false,
		requires = {
			"cljoly/telescope-repo.nvim",
		},
		config = function()
			require("config.telescope")
		end,
	},
	-- {
	-- 	"rmagatti/session-lens",
	-- 	as = "session-lens",
	-- 	requires = {
	-- 		"auto-session",
	-- 		"telescope",
	-- 	},
	-- 	after = "telescope",
	-- 	config = function()
	-- 		require("telescope").load_extension("session-lens")
	-- 		require("config.telescope-sessions")
	-- 	end,
	-- },
	{
		"crispgm/telescope-heading.nvim",
		as = "telescope-heading",
		requires = "telescope",
		-- after = "telescope",
		config = function()
			require("telescope").load_extension("heading")
		end,
	},
	{
		"AckslD/nvim-neoclip.lua",
		as = "neoclip",
		after = { "telescope" },
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
		after = { "telescope" },
		requires = "telescope",
		config = function()
			require("telescope").load_extension("bibtex")
		end,
	},
	{
		"nvim-telescope/telescope-packer.nvim",
		as = "telescope-packer",
		after = { "telescope" },
		requires = "telescope",
		config = function()
			require("telescope").load_extension("packer")
		end,
	},
	{
		"AckslD/nvim-gfold.lua",
		after = { "telescope" },
		requires = "telescope",
		config = function()
			require("config.gfold")
		end,
	},
	{
		"nvim-telescope/telescope-smart-history.nvim",
		as = "smart-history",
		after = { "telescope" },
		requires = { "telescope", "sqlite" },
		config = function()
			require("telescope").load_extension("smart_history")
		end,
	},
	{
		"nvim-telescope/telescope-cheat.nvim",
		as = "telescope-cheat",
		after = { "telescope" },
		requires = { "telescope", "sqlite" },
		config = function()
			require("telescope").load_extension("cheat")
		end,
	},
	{
		"nvim-telescope/telescope-github.nvim",
		as = "telescope-github",
		after = { "telescope" },
		requires = { "telescope", "plenary" },
		config = function()
			require("telescope").load_extension("gh")
		end,
	},
	{
		"nvim-telescope/telescope-z.nvim",
		as = "telescope-z",
		after = { "telescope" },
		requires = {
			"plenary",
			"popup",
			"telescope",
		},
		config = function()
			require("telescope").load_extension("z")
		end,
	},
	{
		"nvim-telescope/telescope-project.nvim",
		as = "telescope-project",
		after = { "telescope" },
		requires = "telescope",
		config = function()
			require("telescope").load_extension("project")
		end,
	},
	{
		"nvim-telescope/telescope-fzf-native.nvim",
		as = "telescope-fzf-native",
		after = { "telescope" },
		requires = "telescope",
		run = "make",
		config = function()
			require("telescope").load_extension("fzf")
		end,
	},
	{
		"nvim-telescope/telescope-media-files.nvim",
		as = "telescope-media-files",
		after = { "telescope" },
		requires = {
			"plenary",
			"popup",
			"telescope",
		},
		config = function()
			require("telescope").load_extension("media_files")
		end,
	},
	-- NOTE: May conflict with dressing.nvim and popui
	{
		"nvim-telescope/telescope-ui-select.nvim",
		as = "telescope-ui-select",
		after = { "telescope" },
		requires = "telescope",
		config = function()
			require("telescope").load_extension("ui-select")
		end,
	},
	{
		"nvim-telescope/telescope-file-browser.nvim",
		as = "telescope-file-browser",
		after = { "telescope" },
		requires = "telescope",
		config = function()
			require("telescope").load_extension("file_browser")
		end,
	},
	{
		"nvim-telescope/telescope-frecency.nvim",
		as = "telescope-frecency",
		requires = {
			"telescope",
			"sqlite",
			"devicons",
		},
		after = { "telescope" },
		-- config = function() require("telescope").load_extension("frecency") end,
	},
	-- Define and search for custom commands
	{
		"LinArcX/telescope-command-palette.nvim",
		as = "command-palette",
		after = { "telescope" },
		requires = "telescope",
		config = function()
			require("telescope").load_extension("command_palette")
		end,
	},
	-- Support web searches from neovim
	{
		"nvim-telescope/telescope-arecibo.nvim",
		as = "telescope-arecibo",
		requires = {
			"telescope",
			"treesitter",
		},
		rocks = { "openssl", "lua-http-parser" },
		config = function()
			require("telescope").load_extension("arecibo")
		end,
		after = { "telescope" },
	},
	-- Symbol picker
	-- TODO: Add shruggie symbol and others in custom data file
	{
		"nvim-telescope/telescope-symbols.nvim",
		as = "telescope-symbols",
		after = { "telescope" },
		requires = "telescope",
	},
	-- Directory finder
	{
		"artart222/telescope_find_directories",
		as = "telescope_find_directories",
		after = { "telescope", "telescope-fzf-native" },
		requires = "telescope",
		config = function()
			require("telescope").load_extension("find_directories")
		end,
	},
}
