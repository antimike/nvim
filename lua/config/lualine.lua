local present, lualine = pcall(require, "lualine")
if not present then
	return
end

-- From CodeArt
local lualine_styles = {
	{
		{ left = " ", right = " " },
		{ left = "│", right = "│" },
	},
	{
		{ left = " ", right = "" },
		{ left = " ", right = " " },
	},
	{
		{ left = "", right = "" },
		{ left = " ", right = " " },
	},
	{
		{ left = "", right = "" },
		{ left = "", right = "" },
	},
	{
		{ left = "", right = "" },
		{ left = " ", right = " " },
	},
}
local gps_present, gps = pcall(require, "nvim-gps")

lualine.setup({
	options = {
		icons_enabled = true,
		theme = "auto",
		disabled_filetypes = {
			"toggleterm",
			"NvimTree",
			"vista",
			"vista_kind",
			"dapui_scopes",
			"dapui_breakpoints",
			"dapui_stacks",
			"dapui_watches",
			"dap-repl",
		},
		always_divide_middle = true,
		component_separators = lualine_styles[4][2],
		section_separators = lualine_styles[4][1],
	},
	extensions = { "fugitive" },
	sections = {
		lualine_a = { "mode" },
		lualine_b = {
			{ "gfold" },
			{ "branch" },
			{
				"diff",
				symbols = { added = "  ", modified = "柳", removed = " " }, -- changes diff symbols
			},
			{ "diagnostics" },
		},
		lualine_c = {
			{ "filename" },
			{
				gps.get_location,
				cond = gps_present and gps.is_available,
			},
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = { "location" },
	},
	inactive_sections = {
		lualine_a = {},
		lualine_b = {},
		lualine_c = { "filename" },
		lualine_x = { "location" },
		lualine_y = {},
		lualine_z = {},
	},
	tabline = {},
})
