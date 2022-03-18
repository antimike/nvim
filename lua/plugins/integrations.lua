--- Plugins that integrate with external utilities (REPLs, tmux, etc.)
return {
	-- Terminal.
	{
		"akinsho/nvim-toggleterm.lua",
		as = "toggleterm",
		cmd = "ToggleTerm",
		setup = function()
			require("config.toggleterm")
		end,
	},

	{
		"pwntester/octo.nvim",
		requires = {
			"plenary",
			"telescope",
			"devicons",
		},
		config = function()
			require("config.octo")
		end,
	},

	-- Create shareable permalinks with line ranges
	{
		"ruifm/gitlinker.nvim",
		as = "gitlinker",
		requires = "plenary",
		config = function()
			require("config.gitlinker").setup()
		end,
	},

	-- Collaborative editing
	{
		"jbyuki/instant.nvim",
		config = function()
			vim.cmd('let g:instant_username = "antimike"')
		end,
	},

	-- Competitive programming
	{
		"xeluxee/competitest.nvim",
		as = "competitest",
		requires = "nui",
		config = function()
			require("config.competitest")
		end,
	},

	-- {
	--   'p00f/cphelper',
	--   as = 'cphelper',
	--   requires = 'plenary',
	-- },

	-- Code runner
	{
		"michaelb/sniprun",
		as = "sniprun",
		run = "bash ./install.sh",
		config = function()
			require("config.sniprun")
		end,
	},
	-- Interactive code scratchpad
	{
		"metakirby5/codi.vim",
		as = "scratchpad",
	},

	-- Literate code support
	{
		"jbyuki/ntangle.nvim",
		as = "ntangle",
	},

	-- Dash (script runner)
	{
		"jbyuki/dash.nvim",
		as = "dash",
	},
	-- {
	-- 	"Olical/conjure",
	-- 	as = "conjure",
	-- },
	{
		"HiPhish/repl.nvim",
		as = "repl",
		config = function()
			require("config.repl")
		end,
	},
	{
		"bfredl/nvim-ipy",
		as = "ipy",
		config = function()
			require("config.ipy")
		end,
	},
	{
		"is0n/fm-nvim",
		as = "file-managers",
		config = function()
			require("config.file-managers")
		end,
	},
	{
		"https://github.com/hkupty/iron.nvim",
		as = "iron",
		config = function()
			require("config.iron")
		end,
	},
	{
		"numToStr/FTerm.nvim",
		as = "FTerm",
		config = function()
			require("config.fterm")
		end,
	},
	{
		"bfredl/nvim-luadev",
		as = "luadev",
	},
	{
		"skywind3000/asynctasks.vim",
		as = "asynctasks",
		requires = "asyncrun",
                config = function()
                        vim.g.asyncrun_open = 6
                        vim.g.asynctasks_term_pos = "floaterm_reuse"
                end,
	},
	{
		"sudormrfbin/cheatsheet.nvim",
		requires = {
			"telescope",
			"popup",
			"plenary",
		},
                after = "telescope",
		config = function()
			require("config.cheatsheets")
		end,
	},
	{
		"https://github.com/HiPhish/info.vim",
		as = "info.vim",
	},
}
