local pkg = {}
local impromptu = require("impromptu")

-- @Summary Set config options for Neon colorscheme
-- @Description Options can be selected with selectors provided by impromptu
function pkg.NeonConfig()
	impromptu.ask {
		question = "Select Neon theme:",
		options = {
			"default",
			"dark",
			"doom",
			"light",
		},
		handler = function(_, opt)
			vim.g.neon_style = opt
		end,
	}
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
        impromptu.ask {
                question = ""
        }
end

function pkg.MoonlightConfig()
        impromptu.ask {
                question = "Select Moonlight option to set:",
                options = {

        }
}
end

-- @Summary Set Lualine theme
-- @Description Choose from selection of supported colorschemes / themes
function pkg.ChooseLualineTheme()
	impromptu.ask({
		question = "Select Lualine theme:",
		options = {
			"moonlight",
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