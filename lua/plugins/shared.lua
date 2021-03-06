--- Plugins used by many other plugins

return {
	-- TODO: lazy load plenary, popup and telescope-media-files
	{
		"nvim-lua/plenary.nvim",
		as = "plenary",
	},

	{
		"nvim-lua/popup.nvim",
		as = "popup",
		requires = "plenary",
		cmd = "Telescope",
	},

	-- Icons.
	{
		"kyazdani42/nvim-web-devicons",
		as = "devicons",
		event = "BufEnter",
	},

	-- SQLite: required for frecency (Telescope plugin)
	{
		"tami5/sqlite.lua",
		as = "sqlite",
	},

	-- TreeSitter.
	-- TODO: Figure out lazy loading (is it worth it?)
	{
		"nvim-treesitter/nvim-treesitter",
		as = "treesitter",
		run = ":TSUpdate",
		event = "BufRead",
		-- cmd = {
		--   'TSInstall',
		--   'TSInstallSync',
		--   'TSBufEnable',
		--   'TSBufToggle',
		--   'TSEnableAll',
		--   'TSInstallFromGrammer',
		--   'TSToggleAll',
		--   'TSUpdate',
		--   'TSUpdateSync'
		-- },
		config = function()
			require("config.treesitter")
		end,
	},

	-- For better diffs
	{
		"sindrets/diffview.nvim",
		as = "diffview",
		requires = {
			"nvim-lua/plenary.nvim",
		},
		config = function()
			require("config.diffview")
		end,
	},

	-- Component library
	{
		"MunifTanjim/nui.nvim",
		as = "nui",
	},

	-- Required for Tig plugin
	{
		"rbgrouleff/bclose.vim",
		as = "bclose",
	},
	{
		"roxma/nvim-yarp",
		as = "yarp",
	},

	-- Optional dependency for wilder.nvim
	{
		"nixprime/cpsm",
		as = "cpsm",
                run = "./install.sh",
	},

	-- Optional dependency for wilder.nvim
	{
		"romgrk/fzy-lua-native",
		as = "fzy-lua-native",
	},

	-- vim-slime
	{
		"jpalardy/vim-slime",
		as = "slime",
		opt = true,
	},
	-- Repeatable <Plug> mappings
	{
		"tpope/vim-repeat",
		as = "vim-repeat",
	},
	{
		"tjdevries/colorbuddy.nvim",
		as = "colorbuddy",
	},
	-- Colorscheme creation and editing tool
	{
		"rktjmp/lush.nvim",
		as = "lush",
		opt = false,
	},
	-- GUI library
	-- Required by navigator
	{
		"ray-x/guihua.lua",
		as = "guihua",
		run = "cd lua/fzy && make",
	},
	-- Easily create selector popups and prompts
	{
		"hkupty/impromptu.nvim",
		as = "impromptu",
	},
	-- For async jobs
	-- Required for asynctasks
	{
		"skywind3000/asyncrun.vim",
		as = "asyncrun",
	},
	-- {
	-- 	"rmagatti/auto-session",
	-- 	as = "auto-session",
 --                config = function()
 --                        require("config.auto-session")
 --                end,
	-- },
}
