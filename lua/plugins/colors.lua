-- Color schemes.
return {
	{ "ellisonleao/gruvbox.nvim" },
	{ "shaunsingh/nord.nvim" },
	{
		"navarasu/onedark.nvim",
		config = function()
			require("config.onedark")
		end,
	},
	{ "wuelnerdotexe/vim-enfocado" },
	"jonstoler/werewolf.vim",
	"sjl/badwolf",
	"Lokaltog/vim-distinguished",
	"ParamagicDev/vim-medic_chalk",
	"tpope/vim-vividchalk",
	"reedes/vim-colors-pencil",
	{
		"metalelf0/jellybeans-nvim",
		requires = "lush",
	},
	-- TreeSitter colorschemes
	{
		"lalitmee/cobalt2.nvim",
		as = "cobalt2",
		requires = {
			"colorbuddy",
			"treesitter",
		},
	},
	{
		"shaeinst/roshnivim-cs",
		as = "roshnivim-cs",
		requires = "treesitter",
	},
	{
		"sainnhe/sonokai",
		as = "sonokai",
		requires = "treesitter",
	},
	{
		"sainnhe/edge",
		as = "edge-colorscheme",
		requires = "treesitter",
	},
	{
		"sainnhe/everforest",
		as = "everforest",
		requires = "treesitter",
	},
	{
		"rafamadriz/neon",
		as = "neon",
		requires = "treesitter",
		config = function()
			require("config.neon")
		end,
	},
	{
		"folke/tokyonight.nvim",
		as = "tokyonight",
		requires = "treesitter",
	},
	{
		"theniceboy/nvim-deus",
		as = "deus",
		requires = "treesitter",
	},
	{
		"rockerBOO/boo-colorscheme-nvim",
		as = "boo-colorscheme",
		requires = "treesitter",
	},
	-- {
	-- 	"glepnir/zephyr-nvim",
	-- 	as = "zephyr",
	-- 	requires = "treesitter",
	-- },
	{
		"mhartington/oceanic-next",
		as = "oceanic-next",
		requires = "treesitter",
	},
	{
		"kyazdani42/blue-moon",
		as = "blue-moon",
		requires = "treesitter",
	},
	{
		"ChristianChiarulli/nvcode-color-schemes.vim",
		as = "nvcode-colorschemes",
		requires = "treesitter",
	},
	{
		"bluz71/vim-moonfly-colors",
		as = "moonfly",
		requires = "treesitter",
	},
	{
		"bluz71/vim-nightfly-guicolors",
		as = "nightfly",
		requires = "treesitter",
	},
	{
		"ray-x/aurora",
		as = "aurora",
		requires = "treesitter",
	},
	{
		"savq/melange",
		as = "melange",
		requires = "treesitter",
	},
	{
		"andersevenrud/nordic.nvim",
		config = function()
			require("config.nordic")
		end,
	},
	{
		"shaunsingh/moonlight.nvim",
		as = "moonlight",
		requires = "treesitter",
	},
}
