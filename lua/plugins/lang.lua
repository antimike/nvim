return {
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		as = "ts-textobjects",
		requires = "treesitter",
		after = "treesitter",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		as = "ts-context-commentstring",
		requires = "treesitter",
		after = "treesitter",
	},
	{
		"mizlan/iswap.nvim",
		as = "iswap",
		requires = "treesitter",
		after = "treesitter",
		config = function()
			require("config.iswap")
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-refactor",
		as = "ts-refactor",
		requires = "treesitter",
		after = "treesitter",
	},
	-- To help compose custom TS queries
	{
		"nvim-treesitter/playground",
		as = "playground",
		requires = "treesitter",
		after = "treesitter",
	},
	{
		"romgrk/nvim-treesitter-context",
		as = "treesitter-context",
		after = "treesitter",
		config = function()
			require("config.treesitter-context")
		end,
	},
	-- LSP, LSP installer and tab completion.
	{
		"neovim/nvim-lspconfig",
		as = "lspconfig",
	},
	{
		"williamboman/nvim-lsp-installer",
		as = "lsp-installer",
		requires = {
			"lspconfig",
			"cmp-nvim-lsp",
		},
		after = {
			"cmp-nvim-lsp",
			"lspconfig",
		},
		config = function()
			require("config.lsp")
		end,
	},
	-- LSP signature.
	{
		"ray-x/lsp_signature.nvim",
		as = "lsp_signature",
	},

	-- VsCode like pictograms for lsp.
	{
		"onsails/lspkind-nvim",
		as = "lspkind",
	},

	-- View and search LSP symbols, tags in Neovim.
	{
		"liuchengxu/vista.vim",
		as = "vista",
		cmd = "Vista",
		config = function()
			require("config.vista")
		end,
	},

	-- This is for html and it can autorename too!
	{
		"windwp/nvim-ts-autotag",
		ft = { "html" },
		as = "ts-autotag",
		after = "treesitter",
	},
	{
		"b3nj5m1n/kommentary",
		as = "kommentary",
		config = function()
			require("config.kommentary")
		end,
	},

	{
		"s1n7ax/nvim-comment-frame",
		as = "comment-frame",
		requires = "treesitter",
		after = "treesitter",
		config = function()
			require("config.comment-frame")
		end,
	},

	-- Helps manage external tools like code formatters, linters, etc.
	{
		"jose-elias-alvarez/null-ls.nvim",
		as = "null-ls",
                requires = "plenary",
		config = function()
			require("config.null-ls")
		end,
	},

	-- Generate annotations and documentation
	{
		"danymat/neogen",
		config = function()
			require("config.neogen")
		end,
		requires = "treesitter",
		after = "treesitter",
		-- Uncomment next line if you want to follow only stable versions
		tag = "*",
	},

	-- Alternative comment and docs generator
	{
		"glepnir/prodoc.nvim",
		as = "prodoc",
		cmd = {
			"ProDoc",
			"ProComment",
		},
	},
	-- Helps manage package.json
	-- TODO: Figure out how to lazy-load this
	-- {
	-- 	"vuki656/package-info.nvim",
	-- 	requires = "nui",
	-- 	config = function()
	-- 		require("package-info").setup()
	-- 	end,
	-- },

	-- Rust dependency management
	{
		"Saecki/crates.nvim",
		as = "crates",
		event = { "BufRead Cargo.toml" },
		config = function()
			require("crates").setup()
		end,
	},

	-- Other Rust tools
	{
		"simrat39/rust-tools.nvim",
		as = "rust-tools",
		ft = { "rust" },
		config = function()
			require("rust-tools").setup({})
		end,
	},
	-- {
	-- 	"ray-x/navigator.lua",
	-- 	requires = {
	-- 		"guihua",
	-- 		"lspconfig",
	-- 		"lsp_signature",
	-- 		"lsp-installer",
	-- 	},
	-- 	after = {
	-- 		"guihua",
	-- 		"lspconfig",
	-- 		"lsp_signature",
	-- 		"lsp-installer",
	-- 	},
	-- 	as = "navigator",
	-- 	config = function()
	-- 		require("config.navigator")
	-- 	end,
	-- },
	{
		"simrat39/symbols-outline.nvim",
		as = "symbols-outline",
		cmd = {
			"SymbolsOutline",
			"SymbolsOutlineOpen",
			"SymbolsOutlineClose",
		},
		config = function()
			require("config.symbols-outline")
		end,
	},
	{
		"AckslD/nvim-revJ.lua",
		as = "revJ",
		requires = {
			"ts-textobjects",
		},
		config = function()
			require("config.revJ")
		end,
	},
	-- Diagnostics + references + telescope + quickfix
	{
		"folke/trouble.nvim",
		as = "trouble",
		requires = {
			"devicons",
			"telescope",
		},
		config = function()
			require("config.trouble")
		end,
	},
	-- Language-specific "splitting" of one-liners to multiline block forms
	-- TODO: Port to Lua / use Treesitter?
	{
		"AndrewRadev/splitjoin.vim",
		as = "splitjoin",
		config = function()
			require("config.splitjoin")
		end,
	},
	-- NOTE: Another option is https://github.com/bfrg/vim-jq
	-- TODO: Look into implementing TS / LSP support for jq
	{
		"vito-c/jq.vim",
		as = "jq",
	},
}
