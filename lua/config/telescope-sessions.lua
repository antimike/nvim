require("session-lens").setup()
local cfg = {
	path_display = { "shorten" },
	-- Use this to customize dropdown
	-- Arg format is the same as for require("telescope.themes").get_dropdown
	theme_conf = {},
	previewer = true,
	-- Any args to telescope.builtin.find_files can also be passed, e.g.
	prompt_title = "Sessions",
}
