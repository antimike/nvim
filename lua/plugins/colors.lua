-- Color schemes.
return {
	-- "jonstoler/werewolf.vim",
	"sjl/badwolf",
	-- "Lokaltog/vim-distinguished",
	-- "ParamagicDev/vim-medic_chalk",
	-- "tpope/vim-vividchalk",
	-- "reedes/vim-colors-pencil",
	-- TreeSitter colorschemes
	{
		"ChristianChiarulli/nvcode-color-schemes.vim",
		as = "nvcode-colorschemes",
		requires = "treesitter",
	},
	{
		"metalelf0/jellybeans-nvim",
		requires = "lush",
                after = "lush",
	},
	{ "ellisonleao/gruvbox.nvim" },
	{ "shaunsingh/nord.nvim", after = "nvcode-colorschemes" },
	{
		"navarasu/onedark.nvim",
		config = function()
			require("config.onedark")
		end,
	},
	{ "wuelnerdotexe/vim-enfocado" },
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
	{
		"lourenci/github-colors",
		as = "github-colors",
		requires = "treesitter",
	},
	{
		"mcchrish/zenbones.nvim",
		as = "zenbones",
		requires = {
			"treesitter",
			"lush",
		},
                after = "lush",
	},
	{
		"frenzyexists/aquarium-vim",
		as = "aquarium",
		requires = "treesitter",
	},
	{
		"EdenEast/nightfox.nvim",
		as = "nightfox",
		requires = "treesitter",
	},
	{
		"kvrohit/substrata.nvim",
		as = "substrata",
		requires = "treesitter",
	},
	{
		"adisen99/apprentice.nvim",
		as = "apprentice",
		requires = {
			"lush",
			"treesitter",
		},
                after = "lush",
		config = function()
			require("config.apprentice")
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		as = "kanagawa",
		requires = "treesitter",
		config = function()
			require("config.kanagawa")
		end,
	},
	{
		"tiagovla/tokyodark.nvim",
		as = "tokyodark",
	},
}
