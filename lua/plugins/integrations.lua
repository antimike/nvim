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
                opt = true,
                cmd = "Octo",
		requires = {
			"plenary",
			"telescope",
			"devicons",
		},
		config = function()
			require("config.octo")
		end,
	},

	-- Competitive programming
	{
		"xeluxee/competitest.nvim",
		as = "competitest",
                cmd = {
                        "CompetiTestAdd",
                        "CompetiTestRun",
                        "CompetiTestEdit",
                        "CompetiTestRunNC",
                        "CompetiTestRunNE",
                        "CompetiTestDelete",
                        "CompetiTestReceive",
                        "CompetiTestConvert",
                },
		requires = "nui",
		config = function()
			require("config.competitest")
		end,
	},

	-- Code runner
	{
		"michaelb/sniprun",
		as = "sniprun",
                cmd = {
                        "SnipRun",
                        "SnipClose",
                        "SnipReset",
                        "SnipTerminate",
                        "SnipInfo",
                        "SnipReplMemoryClean"
                },
		run = "bash ./install.sh",
		config = function()
			require("config.sniprun")
		end,
	},
	-- Interactive code scratchpad
	{
		"metakirby5/codi.vim",
                cmd = {
                        "Codi",
                        "CodiNew",
                        "CodiUpdate",
                        "CodiSelect"
                },
		as = "scratchpad",
	},

	-- Literate code support
	{
		"jbyuki/ntangle.nvim",
                cmd = {
                        "TangleAll",
                        "TangleBuildCache"
                },
		as = "ntangle",
	},

	-- Dash (script runner)
	{
		"jbyuki/dash.nvim",
                cmd = {
                        "DashRun",
                        "DashDebug",
                        "DashConnect"
                },
		as = "dash",
	},

	{
		"HiPhish/repl.nvim",
		as = "repl",
                cmd = "Repl",
		config = function()
			require("config.repl")
		end,
	},

	{
		"bfredl/nvim-ipy",
		as = "ipy",
                command = {
                        "IPython",
                        "IPython2"
                },
		config = function()
			require("config.ipy")
		end,
	},

	{
		"is0n/fm-nvim",
		as = "file-managers",
                cmd = {
                        "Ranger"
                },
		config = function()
			require("config.file-managers")
		end,
	},

	{
		"numToStr/FTerm.nvim",
		as = "FTerm",
                module = "FTerm",
		config = function()
			require("config.fterm")
		end,
	},

	{
		"bfredl/nvim-luadev",
                cmd = "Luadev",
		as = "luadev",
	},

	{
		"skywind3000/asynctasks.vim",
		as = "asynctasks",
                cmd = {
                        "AsyncTask",
                        "AsyncTaskList",
                        "AsyncTaskLast",
                        "AsyncTaskEdit",
                        "AsyncTaskMacro",
                        "AsyncTaskProfile"
                },
		requires = "asyncrun",
		config = function()
			vim.g.asyncrun_open = 6
			vim.g.asynctasks_term_pos = "floaterm_reuse"
		end,
	},

	{
		"sudormrfbin/cheatsheet.nvim",
                cmd = {
                        "Cheatsheet",
                        "CheatsheetEdit"
                },
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
                cmd = "Info",
                ft = {
                        "info",
                        "texinfo"
                }
	},

	{
		"glacambre/firenvim",
		run = function()
			vim.fn["firenvim#install"](0)
		end,
	},
}
