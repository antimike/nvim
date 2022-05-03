local null_ls = require("null-ls")
local builtins = null_ls.builtins

null_ls.setup({
	sources = {
		builtins.formatting.stylua,
		builtins.formatting.black,
		builtins.diagnostics.eslint,
		builtins.completion.spell,
	},
})
