local pkg = {
	tree = require("utils.tree"),
}

-- @Summary Document keymaps without rebinding them using which-key
-- @Description Uses which-key to "describe" existing keymaps, e.g. those configured automatically by a plugin
-- @Param  keymaps      Dictionary of keymaps to document in the form [name] = keydict, where keydict can be in one of two forms:
--      1. { [keys] = [name of functionality] }, e.g. { '.' = 'textsubjects-smart' }, or
--      2. { [name of functionality] = [keys] }, e.g. { 'textsubjects-smart' = '.' }.
-- @Param  descriptions Dictionary of keymap descriptions in the form [name] = descdict, where descdict has the form { [name of functionality] = [description], <more of these>, _modes = { <subset of "n", "v", "o"> } }.  If descdict._modes is not provided, { "n" } will be assumed.
function pkg.document_keymaps(keymaps, descriptions)
	local wk = require("which-key")
	local wk_maps = {}
	local modes, descs, desc, keys
	for name, map in pairs(keymaps) do
		descs = descriptions[name]
		if descs ~= nil and type(map) == "table" then
			for lhs, rhs in pairs(map) do
				modes = descs._modes or { "n" }
				-- Keys should only be assigned once, in the map table
				-- Thus, we assume that a string which appears in both tables is *not* a keybind but a name / function
				if descs[lhs] ~= nil then
					keys, desc = rhs, descs[lhs]
				else
					keys, desc = lhs, descs[rhs]
				end
				if keys ~= nil and desc ~= nil then
					for _, mode in ipairs(modes) do
						wk_maps[mode] = wk_maps[mode] or {}
						wk_maps[mode][keys] = { desc }
					end
				end
			end
		end
	end
	for mode, wk_map in pairs(wk_maps) do
		wk.register(wk_map, { mode = mode })
	end
end

local function print_debug_msg(msg)
	print("    DEBUG: " .. msg)
end

pkg.blacklist = {
	filetypes = {
		description = "Filetype blacklist",
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
	buftypes = {
		description = "Buftype blacklist",
		"nofile",
		"nowrite",
		"quickfix",
		"terminal",
		"prompt",
	},
}

return pkg
