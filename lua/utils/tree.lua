local pkg = {}

local function enumerate_leaves(tree, iter, produce, pre, post)
        local function do_nothing(_) end
        pre, post = pre or do_nothing, post or do_nothing
	local recurse = pcall(function(x)
		for key, val in iter(x) do
                        pre(key, val)
			enumerate_leaves(val, iter, produce)
                        post(key, val)
		end
	end, tree)
        if recurse == false then
                pre(tree)
                produce(tree)
                post(tree)
        end
end

local function eulerian_coroutine_recursive(obj, iter, produce, path)
	local recurse = pcall(function(x)
		for key, val in iter(x) do
			table.insert(path, key)
			eulerian_coroutine_recursive(val, iter, produce, path)
			table.remove(path)
		end
	end, obj)
        if recurse == false then
                produce(path, obj)
        end
end

local function eulerian_coroutine(obj, path)
	-- NOTE: Could also insert obj into stack before repeat-until block and pop instead of push at the beginning of the block
	-- Is this any more / less efficient?
	local stack = {}
	local key, curr, descend = nil, obj, true
	repeat
		if curr == nil then -- Edge case: curr == nil  ==> we've exhausted the current level
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

-- @Summary Euler traversal of a tree represented as a nested Lua table.
-- @Description Performs a DFS on obj, yielding a table of keys in the path to the current leaf when it is impossible to descend further, along with the value associated with the leaf.
-- @Param  obj  Root of tree (Lua table)
-- @Return Iterator triple which generates all complete paths through the tree
function pkg.EulerianTraversal(obj)
	return coroutine.wrap(function(tree)
		return eulerian_coroutine(tree, {})
	end), obj
end

function pkg.Recurse(obj)
	return coroutine.wrap(function()
		return eulerian_coroutine_recursive(obj, pairs, coroutine.yield, {})
	end)
end

return pkg
