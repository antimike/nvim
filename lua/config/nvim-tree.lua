local present, nvimtree = pcall(require, "nvim-tree")
if not present then
	return
end

-- Set alias for vim.g.
local g = vim.g
g.nvim_tree_indent_markers = 1 -- This option shows indent markers when folders are open.
g.nvim_tree_ignore = { ".git", "node_modules", ".cache", "__pycache__" } -- Ignore these types in listing.

nvimtree.setup({ -- BEGIN_DEFAULT_OPTS
	auto_close = false,
	auto_reload_on_write = true,
	disable_netrw = true,
	hide_root_folder = false,
	hijack_cursor = false,
	hijack_netrw = true,
	hijack_unnamed_buffer_when_opening = false,
	ignore_buffer_on_setup = false,
	open_on_setup = false,
	open_on_tab = false,
	sort_by = "name",
	update_cwd = true,
	view = {
                height = "100%",
		width = "20%",
		side = "left",
		preserve_window_proportions = true,
		mappings = {
			custom_only = false,
			list = {
				-- user mappings go here
			},
		},
		number = false,
		relativenumber = false,
		signcolumn = "yes",
	},
	hijack_directories = {
		enable = true,
		auto_open = true,
	},
	update_focused_file = {
		enable = false,
		update_cwd = true,
		ignore_list = {},
	},
	ignore_ft_on_setup = {"dashboard"},
	system_open = {
		cmd = nil,
		args = {},
	},
	diagnostics = {
		enable = false,
		show_on_dirs = false,
		icons = {
			hint = "",
			info = "",
			warning = "",
			error = "",
		},
	},
	filters = {
		dotfiles = true,
		custom = {},
		exclude = {},
	},
	git = {
		enable = true,
		ignore = true,
		timeout = 400,
	},
	actions = {
		change_dir = {
			enable = true,
			global = false,
		},
		open_file = {
			quit_on_open = false,
			resize_window = false,
			window_picker = {
				enable = true,
				chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
				exclude = {
					filetype = { "dashboard", "notify", "packer", "qf", "diff", "fugitive", "fugitiveblame" },
					buftype = { "nofile", "terminal", "help" },
				},
			},
		},
	},
	trash = {
		cmd = "trash",
		require_confirm = true,
	},
	log = {
		enable = false,
		truncate = false,
		types = {
			all = false,
			config = false,
			git = false,
		},
	},
}) -- END_DEFAULT_OPTS

-- Hide statusline in nvim-tree buffer/tabs.
vim.cmd(
	'au BufEnter,BufWinEnter,WinEnter,CmdwinEnter * if bufname("%") == "NvimTree" | set laststatus=0 | else | set laststatus=2 | endif'
)
