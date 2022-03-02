local pkg = {}

pkg.blacklist = {
	filetypes = {
		"Filetype blacklist",
		{
			"help",
			"terminal",
			"dashboard",
			"packer",
			"vista",
			"TelescopePrompt",
			"lsp-installer",
			"lspinfo",
			"vista_kind",
			"NvimTree",
			"calendar",
			"peek",
			"fzf",
			"fugitive",
		},
	},
	buftypes = {
		"Buftype blacklist",
		{
			"nofile",
			"nowrite",
			"quickfix",
			"terminal",
			"prompt",
		},
	},
}

return pkg
