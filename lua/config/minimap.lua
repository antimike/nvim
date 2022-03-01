local opts = {
	width = { "Minimap width (characters)", 10 },
	auto = {
		"Autostart options",
		start = { "Enable autostart", 0, 1 },
		start_win_enter = { "Start on WinEnter events", 1, 0 },
	},
	base_highlight = { "Base color group", "Normal" },
	block = {
		"Disable Minimap",
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
	},
        close = {
                "Close Minimap",
                filetypes = {
                        "Filetypes",
                {
                                "startify",
                                "dashboard",

                        }
                }
        }
}
