-- @Summary Returns bool indicating if line is whitespace
-- @Description Taken from https://github.com/AckslD/nvim-neoclip.lua
-- @Param  line Line to check
local function is_whitespace(line)
	return vim.fn.match(line, [[^\s*$]]) ~= -1
end

-- @Summary Checks if a predicate is true for all list members
-- @Description Taken from https://github.com/AckslD/nvim-neoclip.lua
-- @Param  tbl List to check
-- @Param  check Predicate
local function all(tbl, check)
	for _, entry in ipairs(tbl) do
		if not check(entry) then
			return false
		end
	end
	return true
end

require("neoclip").setup({
	history = 1000,
	enable_persistent_history = true,
	continious_sync = false,
	db_path = vim.fn.stdpath("data") .. "/databases/neoclip.sqlite3",
        -- Prevents pure-whitespace yanks from polluting the yank list
        -- Taken from https://github.com/AckslD/nvim-neoclip.lua
	filter = function(data)
                return not all(data.event.regcontents, is_whitespace)
        end,
	preview = true,
	default_register = {
		'"',
		"+",
		"*",
	},
	default_register_macros = "q",
	enable_macro_history = true,
	content_spec_column = false,
	on_paste = {
		set_reg = false,
	},
	on_replay = {
		set_reg = false,
	},
	keys = {
		telescope = {
			i = {
				select = "<cr>",
				paste = "<c-p>",
				paste_behind = "<c-k>",
				replay = "<c-q>", -- replay a macro
				delete = "<c-d>", -- delete an entry
				custom = {},
			},
			n = {
				select = "<cr>",
				paste = "p",
				paste_behind = "P",
				replay = "q",
				delete = "d",
				custom = {},
			},
		},
		fzf = {
			select = "default",
			paste = "ctrl-p",
			paste_behind = "ctrl-k",
			custom = {},
		},
	},
})
