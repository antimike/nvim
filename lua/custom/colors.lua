local pkg = {}
local impromptu = require("impromptu")

-- @Summary Set config options for Neon colorscheme
-- @Description Options can be selected with selectors provided by impromptu
function pkg.NeonConfig()
	local prefix = "neon_"
	local opts = {
		style = {
			"Overall style",
			default = "Default (soft-dark)",
			dark = "Dark (high-contrast dark)",
			doom = "Doom",
			light = "Light",
		},
		italic = {
			comment = { "Italicize comments", true, false },
			keyword = { "Italicize keywords", false, true },
			boolean = { "Italicize booleans", false, true },
			["function"] = { "Italicize function names", false, true },
			variable = { "Italicize variable names", false, true },
		},
		bold = { "Use bold for error and warning messages", false, true },
		transparent = { "Remove background highlights", false, true },
	}
	impromptu.ask({
		question = "Select Neon theme:",
		options = {
			Default = {
				description = "Soft-dark theme",
			},
			Dark = {
				description = "High-contrast dark theme",
			},
			Doom = {
				description = "Doom-like theme",
			},
			Light = {
				description = "Light theme",
			},
		},
		handler = function(_, opt)
			vim.g.neon_style = opt
		end,
	})
end

-- @Summary Remove background highlights
-- @Description Taken from https://github.com/mhartington/oceanic-next
function pkg.MakeTransparent()
	vim.cmd([[
        hi Normal guibg=NONE ctermbg=NONE
        hi LineNr guibg=NONE ctermbg=NONE
        hi SignColumn guibg=NONE ctermbg=NONE
        hi EndOfBuffer guibg=NONE ctermbg=NONE
        ]])
end

local function choose_config(option_tree)
	local handler = function(context, opt)
		vim.g[table.concat(context, "_")] = opt
	end
	impromptu.ask({
		question = "",
	})
end

function pkg.MoonflyConfig()
	local prefix = "moonfly"
	local opts = {
		CursorColor = { "Apply color to cursor", 0, 1 },
		Italics = { "Italicize comments", 1, 0 },
		NormalFloat = { "Apply Moonfly BG/FG colors to floating windows", 0, 1 },
		TerminalColors = { "Use Moonfly palette in :terminal windows", 1, 0 },
		Transparent = { "Use a transparent background", 0, 1 },
		Undercurls = { "Use undercurls for errors", 1, 0 },
		UnderlineMatchParen = { "Underline matching parentheses", 0, 1 },
		VertSplits = { "Show vertical split columns", 1, 0 },
	}
end

function pkg.NightflyConfig()
	local prefix = "nightfly"
	local opts = {
		CursorColor = { "Apply color to cursor", 0, 1 },
		Italics = { "Italicize comments", 1, 0 },
		NormalFloat = { "Apply Moonfly BG/FG colors to floating windows", 0, 1 },
		TerminalColors = { "Use Moonfly palette in :terminal windows", 1, 0 },
		Transparent = { "Use a transparent background", 0, 1 },
		Undercurls = { "Use undercurls for errors", 1, 0 },
		UnderlineMatchParen = { "Underline matching parentheses", 0, 1 },
		VertSplits = { "Show vertical split columns", 1, 0 },
	}
end

function pkg.GruvboxConfig()
	local prefix = "gruvbox"
	local opts = {
		bold = { "Enable bold text", 1, 0 },
		italic = { "Enable italic text", 1, 0 },
		transparent_bg = { "Transparent background", 0, 1 },
		underline = { "Enable underlined text", 1, 0 },
		undercurl = { "Enable undercurled text", 1, 0 },
		termcolors = { "Use 256-color palette", 256, 16 },
		contrast_dark = { "Set dark mode contrast", "soft", "medium", "hard" },
		contrast_light = { "Set dark mode contrast", "soft", "medium", "hard" },
		hls_cursor = { "Change cursor background while search highlighted", "orange", "..." },
		number_column = { "Change number column background color", nil, "..." },
		sign_column = { "Change sign column background color", "bg1", "..." },
		color_column = { "Change color column background", "bg1", "..." },
		vert_split = { "Change vertical split background color", "bg0", "..." },
		italicize = {
			"Set options for italicized text",
			strings = { "Italicize strings", 0, 1 },
			comments = { "Italicize comments", 1, 0 },
		},
		invert = {
			"Color inversions",
			selection = { "Invert selected text", 1, 0 },
			signs = { "Invert GitGutter and Syntastic signs", 0, 1 },
			indent_guides = { "Invert indent guides", 0, 1 },
			tabline = { "Invert tabline", 0, 1 },
		},
		improved = {
			"Extrahighlights",
			strings = { "Extrahighlighted strings", 0, 1 },
			warnings = { "Extrahighlighted warnings", 0, 1 },
		},
		guisp_fallback = { "Color underlines and strikethroughs", nil, "fg", "bg" },
	}
end

function pkg.GithubConfig()
	local opts = {
		background = { "dark", "light" },
	}
	local handler = function(_, opt)
		vim.cmd([[set background=]] .. opt)
	end
end

function pkg.MoonlightConfig()
	local prefix = "moonlight_"
	local opts = {
		italic = {
			comments = { "Italicize comments", false, true },
			keywords = { "Italicize keywords", false, true },
			functions = { "Italicize function names", false, true },
			variables = { "Italicize variable names", false, true },
		},
		contrast = { "Style sidebars and popups differently", true, false },
		borders = { "Make borders between vertical splits visible", false, true },
		disable_background = { "Use terminal background", false, true },
	}
	impromptu.ask({
		question = "Select Moonlight option to set:",
		options = {},
	})
end

function EnfocadoConfig()
	local prefix = "enfocado_"
	local opts = {
		style = { "nature", "neon" },
	}
end

function DraculaConfig()
	local prefix = "dracula"
	local opts = {
		transparent_bg = { "Transparent background", true, false },
		italic_comment = { "Italicize comments", true, false },
		show_end_of_buffer = { "Show '~' at end of buffer", true, false },
	}
end

function pkg.AquariumConfig()
	local prefix = "aqua"
	local opts = {
		bold = { "Enable bold text", 1, 0 },
		transparency = { "Enable transparency", 1, 0 },
		style = { "Style", "dark", "light" },
	}
end

function pkg.SubstrataConfig()
        local prefix = "substrata"
        local opts = {
                italic = {
                        "Italicize text",
                        comments = {"Comments", true, false},
                        keywords = {"Keywords", false, true},
                        booleans = {"Booleans", false, true},
                        functions = {"Functions", false, true},
                        variables = {"Variables", false, true},
                },
                transparent = {"Enable transparency", false, true},
                variant = {"Style", nil, "brighter"}
        }
end

function pkg.ApprenticeConfig()
        local prefix = "apprentice"
        local opts = {
                contrast = {
                        "Set contrast",
                        dark = {"Level", "hard", "medium", "soft"},
                        light = {"Level", "hard", "medium", "soft"},
                }
        }
end

function pkg.TokyDarkConfig()
        local prefix = "tokyodark"
        local opts = {
                transparent_background = {"Enable transparency", false, true},
                enable_italic_comment = {"Italicize comments", true, false},
                enable_italics = {"Enable italics", true, false},
                color_gamma = {"Color gamma", "1.0", "..."},
        }
end

function pkg.NightfoxConfig()
        -- Call require("nightfox").setup {...}
	local opts = {
		fox = "nightfox", -- Which fox style should be applied
		transparent = false, -- Disable setting the background color
		alt_nc = false, -- Non current window bg to alt color see `hl-NormalNC`
		terminal_colors = true, -- Configure the colors used when opening :terminal
		styles = {
			comments = "NONE", -- Style that is applied to comments: see `highlight-args` for options
			functions = "NONE", -- Style that is applied to functions: see `highlight-args` for options
			keywords = "NONE", -- Style that is applied to keywords: see `highlight-args` for options
			strings = "NONE", -- Style that is applied to strings: see `highlight-args` for options
			variables = "NONE", -- Style that is applied to variables: see `highlight-args` for options
		},
		inverse = {
			match_paren = false, -- Enable/Disable inverse highlighting for match parens
			visual = false, -- Enable/Disable inverse highlighting for visual selection
			search = false, -- Enable/Disable inverse highlights for search highlights
		},
		colors = {}, -- Override default colors
		hlgroups = {}, -- Override highlight groups
	}
end

-- @Summary Set Lualine theme
-- @Description Choose from selection of supported colorschemes / themes
function pkg.ChooseLualineTheme()
	impromptu.ask({
		question = "Select Lualine theme:",
		options = {
			"moonlight",
			"enfocado",
			"moonfly",
			"nightfly",
			"dracula-nvim",
			"zenbones",
			"nightfox",
		},
		handler = function(_, opt)
			require("lualine").setup({
				options = {
					theme = opt,
				},
			})
		end,
	})
end

-- @Summary Sets Treesitter highlights
-- @Description Uses defaults suggested on https://github.com/ChristianChiarulli/nvcode-color-schemes.vim
function pkg.SetTreesitterHighlights()
	vim.cmd([[
" Misc
highlight TSError guifg=#F44747
highlight TSPunctDelimiter guifg=#ABB2BF
highlight TSPunctBracket guifg=#ABB2BF
highlight TSPunctSpecial guifg=#ABB2BF

" Constants
highlight TSConstant guifg=#DCDCAA
highlight TSConstBuiltin guifg=#569CD6
" Not sure about this guy
highlight TSConstMacro guifg=#4EC9B0
highlight TSString guifg=#CE9178
highlight TSStringRegex guifg=#CE9178
highlight TSStringEscape guifg=#D7BA7D
highlight TSCharacter guifg=#CE9178
highlight TSNumber guifg=#B5CEA8
highlight TSBoolean guifg=#569CD6
highlight TSFloat guifg=#B5CEA8
highlight TSAnnotation guifg=#DCDCAA
highlight TSAttribute guifg=#FF00FF
highlight TSNamespace guifg=#FF00FF


" Functions
" highlight TSFuncBuiltin guifg=#4EC9B0
highlight TSFuncBuiltin guifg=#DCDCAA
highlight TSFunction guifg=#DCDCAA
highlight TSFuncMacro guifg=#DCDCAA
highlight TSParameter guifg=#9CDCFE
highlight TSParameterReference guifg=#9CDCFE
highlight TSMethod guifg=#DCDCAA
highlight TSField guifg=#9CDCFE
highlight TSProperty guifg=#9CDCFE
highlight TSConstructor guifg=#4EC9B0

" Keywords
highlight TSConditional guifg=#C586C0
highlight TSRepeat guifg=#C586C0
highlight TSLabel guifg=#FF00FF
" Does not work for yield and return they should be diff then class and def
highlight TSKeyword guifg=#569CD6
highlight TSKeywordFunction guifg=#FF00FF
highlight TSKeywordOperator guifg=#569CD6
highlight TSOperator guifg=#ABB2BF
highlight TSException guifg=#C586C0
highlight TSType guifg=#4EC9B0
highlight TSTypeBuiltin guifg=#FF00FF
highlight TSStructure guifg=#FF00FF
highlight TSInclude guifg=#C586C0

" Variable
highlight TSVariable guifg=#9CDCFE
highlight TSVariableBuiltin guifg=#9CDCFE

" Text
highlight TSText guifg=#FF00FF
highlight TSStrong guifg=#FF00FF
highlight TSEmphasis guifg=#FF00FF
highlight TSUnderline guifg=#FF00FF
highlight TSTitle guifg=#FF00FF
highlight TSLiteral guifg=#FF00FF
highlight TSURI guifg=#FF00FF

" Tags
highlight TSTag guifg=#569CD6
highlight TSTagDelimiter guifg=#5C6370
]])
end

return pkg
