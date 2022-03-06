local wk = require("which-key")

require("revj").setup({
	brackets = { first = "([{<", last = ")]}>" }, -- brackets to consider surrounding arguments
	new_line_before_last_bracket = true, -- add new line between last argument and last bracket (only if no last seperator)
	add_seperator_for_last_parameter = true, -- if a seperator should be added if not present after last parameter
	enable_default_keymaps = false, -- enables default keymaps without having to set them below
	keymaps = {
		operator = "<Leader>J", -- for operator (+motion)
		line = "<Leader>ja", -- for formatting current line
		visual = "<Leader>J", -- for formatting visual selection
	},
	parameter_mapping = "a", -- specifies what text object selects an arguments (ie a, and i, by default)
	-- if you're using `vim-textobj-parameter` you can also set this to `vim.g.vim_textobj_parameter_mapping`
})

wk.register({
	ja = { "Split args (line)" },
}, { prefix = "<leader>", mode = "n" })

wk.register({
	J = { "Split args" },
}, { prefix = "<leader>", mode = "o" })

wk.register({
	J = { "Split args" },
}, { prefix = "<leader>", mode = "v" })
