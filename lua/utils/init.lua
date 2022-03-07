local pkg = {}

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

local function eulerian_coroutine(obj)
        -- NOTE: Could also insert obj into stack before repeat-until block and pop instead of push at the beginning of the block
        -- Is this any more / less efficient?
	local stack, path = {}, {}
	local key, curr, descend = nil, obj, true
        repeat
                if curr == nil then     -- Edge case: curr == nil  ==> we've exhausted the current level
                        -- NOTE: Will obviously cause problems if obj == nil.  This is a good thing
                        -- print_debug_msg("Exhausted " .. tostring(curr) .. "; popping from stack...")
                        curr, key = table.remove(stack), table.remove(path)
                end
                -- Insert the node being searched and determine whether we can go deeper
                -- print_debug_msg("Searching " .. tostring(curr) .. " for children...")
                table.insert(stack, curr)
                descend, key, curr = pcall(next, curr, key)
		if descend then
                        if key ~= nil then
                                -- print_debug_msg("Found child with key " .. tostring(key) .. "!  Descending...")
                                table.insert(path, key)
                                -- If we're descending then we know we haven't seen this node before, since this is a DFS
                                key = nil
                        else
                                table.remove(stack)
                                curr, key = table.remove(stack), table.remove(path)
                        end
                else
                        -- Yield the full path to the leaf we just found
                        -- The last item on the stack will be non-table-like and the value of the leaf itself, so we pop it here
                        -- print_debug_msg("Attempted to descend into leaf with value " .. tostring(stack[#stack]) .. "!  Yielding leaf...")
                        key = table.remove(path)
                        coroutine.yield(path, key, table.remove(stack))
                        curr = table.remove(stack)
                        -- Backtrack
                        -- NOTE: Inefficient bc the last item will get popped and restacked; is there a better way?
                        -- NOTE: This will result in an error iff the original `obj` is non-table-like (good), so we deliberately omit the pcall
                end
        until curr == nil and #stack == 0
end

pkg.EulerianTraversal = function(obj) return coroutine.wrap(eulerian_coroutine), obj end

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
