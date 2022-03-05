local present, nvim_treesitter = pcall(require, "nvim-treesitter.configs")
if not present then
	return
end
local parser_conf = require("nvim-treesitter.parsers").get_parser_configs()
local utils = require("utils")

-- Ensure all keymaps are registered with which-key
local keymaps = {
	smart_rename = {
		smart_rename = "gr",
	},
	navigation = {
		goto_definition = "gd",
		list_definitions = "gD",
		list_definitions_toc = "gO",
		goto_next_usage = "<A-*>",
		goto_previous_usage = "<A-#>",
	},
        textsubjects = {
                ["<space>"] = "textsubjects-smart",
                ["A"] = "textsubjects-container-outer",
                ["I"] = "textsubjects-container-inner",
        },
}

local descriptions = {
	smart_rename = {
		smart_rename = "Rename",
		_modes = { "n" },
	},
	navigation = {
		goto_definition = "GOTO definition",
		list_definitions = "List definitions",
		list_definitions_toc = "Show definitions TOC",
		goto_next_usage = "GOTO next usage",
		goto_previous_usage = "GOTO previous usage",
		_modes = { "n" },
	},
        textsubjects = {
                ["textsubjects-smart"] = "Comments, calls, defns, loops, args",
                ["textsubjects-container-outer"] = "Classes, structs, funcs, methods (outer)",
                ["textsubjects-container-inner"] = "Classes, structs, funcs, methods (inner)",
                _modes = { "v", "o" }
        }
}

utils.document_keymaps(keymaps, descriptions)

nvim_treesitter.setup({
	refactor = {
		highlight_definitions = {
			enable = true,
			-- Set to false if you have an `updatetime` of ~100.
			clear_on_cursor_move = true,
			highlight_current_scope = {
				enable = true,
			},
		},
		smart_rename = {
			enable = true,
			keymaps = keymaps.smart_rename,
		},
		navigation = {
			enable = true,
			keymaps = keymaps.navigation,
		},
	},
	highlight = {
		enable = true,
		disable = { "org" },
		-- NOTE: nvim-orgmode author recommends val of {'org'} here
		additional_vim_regex_highlighting = true,
	},
	matchup = {
		enable = true,
		-- diable = {},     -- Languages to disable matching
		disable_virtual_text = { "python" },
		-- include_match_words = {}
	},
	indent = {
		enable = true,
	},
	autotag = {
		enable = true,
	},
	playground = {
		enable = true,
		disable = {},
		updatetime = 25,
		persist_queries = false,
	},
	textsubjects = {
		enable = true,
		keymaps = {
			["."] = "textsubjects-smart",
			[";"] = "textsubjects-container-outer",
		},
	},
	context_commentstring = {
		enable = true,
		-- For integration with kommentary.nvim
		enable_autocmd = false,
		config = {
			-- Included for illustrative purposes
			-- See nvim-ts-context-commentstring docs for more info
			css = "// %s",
			javascript = {
				__default = "// %s",
				jsx_element = "{/* %s */}",
				jsx_fragment = "{/* %s */}",
				jsx_attribute = "// %s",
				comment = "// %s",
			},
			typescript = {
				__default = "// %s",
				__multiline = "/* %s */",
			},
		},
	},
	textobjects = {
		select = {
			enable = true,
			-- Autojump to textobj (like targets.vim)
			lookahead = true,
			keymaps = {
				-- cf. textobjects.scm
				["af"] = "@function.outer",
				["if"] = "@function.inner",
				["ac"] = "@class.outer",
				["ic"] = "@class.inner",
				["ia"] = "@parameter.inner",
				["aa"] = "@parameter.outer",
			},
		},
		move = {
			enable = true,
			set_jumps = true,
			goto_next_start = {
				["]m"] = "@function.outer",
				["]]"] = "@class.outer",
				["ga"] = "@parameter.outer",
			},
			goto_next_end = {
				["]M"] = "@function.outer",
				["]["] = "@class.outer",
				["gA"] = "@parameter.outer",
			},
			goto_previous_start = {
				["[m"] = "@function.outer",
				["[["] = "@class.outer",
				["gpa"] = "@parameter.outer",
			},
			goto_previous_end = {
				["[M"] = "@function.outer",
				["[]"] = "@class.outer",
				["gpA"] = "@parameter.outer",
			},
		},
		swap = {
			enable = true,
			swap_next = { ["<Leader>xp"] = "@parameter.inner" },
			swap_previous = { ["<Leader>xP"] = "@parameter.inner" },
		},
		lsp_interop = {
			enable = true,
			border = "none",
			peek_definition_code = {
				["<Leader>lpf"] = "@function.outer",
				["<Leader>lpc"] = "@class.outer",
			},
		},
	},
})

parser_conf.markdown = {
	filetype_to_parsername = "octo",
	install_info = {
		url = "https://github.com/ikatyang/tree-sitter-markdown",
		files = { "src/parser.c", "src/scanner.cc" },
	},
	filetype = "markdown",
}

vim.cmd([[
  autocmd BufEnter * set foldmethod=expr
  autocmd BufEnter * set foldexpr=nvim_treesitter#foldexpr()
  " set foldlevel=99
]])
