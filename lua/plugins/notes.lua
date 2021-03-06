return {
	{
		"oberblastmeister/neuron.nvim",
		as = "neuron",
		requires = {
			"popup",
			"plenary",
			"telescope",
		},
		after = "telescope",
		config = function()
			require("config.neuron")
		end,
	},
	{
		"jbyuki/nabla.nvim",
		as = "nabla",
	},
	-- {
	-- 	"nvim-orgmode/orgmode",
	-- 	as = "orgmode",
	-- 	-- NOTE: Lazy loading is not recommended by author
	-- 	ft = { "org" },
	-- 	requires = "treesitter",
	-- 	config = function()
	-- 		require("config.orgmode")
	-- 	end,
	-- },
	{
		"jubnzv/mdeval.nvim",
		as = "mdeval",
		ft = {
			"org",
			"md",
			"markdown",
			"vimwiki",
			"rmd",
		},
		config = function()
			require("config.mdeval")
		end,
	},
	{
		"akinsho/org-bullets.nvim",
		as = "org-bullets",
		ft = "org",
		config = function()
			require("org-bullets").setup({
				symbols = { "◉", "○", "✸", "✿" },
				-- or a function that receives the defaults and returns a list
				-- -- symbols = function(default_list)
				-- --   table.insert(default_list, "♥")
				-- --   return default_list
				-- -- end
			})
		end,
	},
	-- ASCII Diagrams
	{
		"jbyuki/venn.nvim",
		as = "venn",
	},
	{
		"renerocksai/calendar-vim",
		as = "calendar",
	},
	{
		"renerocksai/telekasten.nvim",
		as = "telekasten",
		requires = {
			"telescope",
			"calendar",
		},
		after = {
			"telescope",
			"calendar",
		},
		config = function()
			require("config.telekasten")
		end,
	},
	-- {
	-- 	"jakewvincent/mkdnflow.nvim",
	-- 	as = "mkdnflow",
	-- 	config = function()
	-- 		require("config.mkdnflow")
	-- 	end,
	-- },
	{
		"mzlogin/vim-markdown-toc",
		as = "markdown-toc",
	},
	{
		"godlygeek/tabular",
		as = "tabular",
	},
	{
		"preservim/vim-markdown",
		as = "vim-markdown",
		requires = "tabular",
		after = "tabular",
		config = function()
			require("config.vim-markdown")
		end,
	},
	{
		"vim-pandoc/vim-pandoc",
		as = "vim-pandoc",
                config = function()
                        vim.cmd([[let g:pandoc#keyboard#use_default_mappings=0]])
                end,
	},
	{
		"vim-pandoc/vim-pandoc-syntax",
		as = "vim-pandoc-syntax",
		requires = "vim-pandoc",
		after = "vim-pandoc",
	},
	{
		"iamcco/markdown-preview.nvim",
		as = "markdown-preview",
		run = "yarn install",
		config = function()
			require("config.markdown-preview")
		end,
	},
}
