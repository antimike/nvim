local present, lualine = pcall(require, "lualine")
if not present then
	return
end

local gps = require("nvim-gps")
-- local session = require("custom.auto-session")

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
			-- { "gfold" },
			{ "branch" },
			{
				"diff",
				symbols = { added = "  ", modified = "柳", removed = " " }, -- changes diff symbols
			},
			{ "diagnostics" },
		},
		lualine_c = {
			"filename",
			-- { session.SessionName, cond = function() return true end },
			-- {
			-- 	require("auto-session-library").current_session_name or "",
			-- 	cond = function()
			-- 		return pcall(require, "auto-session-library")
			-- 	end,
			-- },
		},
		lualine_x = { "encoding", "fileformat", "filetype" },
		lualine_y = { "progress" },
		lualine_z = {
			"location",
			{ gps.get_location, cond = gps.is_available },
		},
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
