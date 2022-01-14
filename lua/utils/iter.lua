local sort = require("utils.sort")
local pkg = {
    heap = {},
    tree = {}
}
local gen = {
    heap = {},
    tree = {}
}

--- Iterate over range (start, stop, step).
-- If only one arg is provided, it is interpreted as the value of `stop`.
-- If `step` is not provided, it is inferred to be +/-1 depending on the relative ordering of `start` and `stop`.
-- @param start Beginning of range
-- @param stop End of range
-- @param step Value to increment control parameter
function pkg.range(start, stop, step)
    if not (start and stop and step) then
        local min, max, reverse = sort.sort_pair(start, stop, 0)
        if start and stop and reverse then
            -- Range provided in reversed order
            step = -1
        elseif (start and stop) or reverse then
            -- Either range is provided in min, max order or only one positive range arg is provided
            start, stop, step = min, max, 1
        else
            -- One negative range arg provided
            start, stop, step = max, min, -1
        end
    end

    -- Use upvalues to maintain state instead of table
    local curr = start - step
    local function ret()
        curr = curr + step
        if (curr - start)*(curr - stop) <= 0 then
            return curr
        end
    end
    return ret
end

function pkg.pipe(fn, iter, state, init)
    local function wrapped(s, c)
        local val = iter(s, c)
        if val then
            return fn(val)
        end
    end
    return wrapped, state, init
end

function pkg.tablerange(tab, start, stop, step)
    return pkg.pipe(function (k) return k, tab[k] end, pkg.range(start, stop, step))
end

--- Transforms an iterator to return (at most) two values.
-- Uses table packing and unpacking to transformm the passed iterator into one which always returns a control variable and a (possibly empty) table of other return values
-- Ugly and (possibly) inefficient; is there a way to improve this or bypass it entirely?
-- @param iter Iterator function to canonicalize
-- @return Transformed ("canonicalized") iterator function
local function canonicalize(iter)
    return function (...)
        local ret = table.pack(iter(...))
        return ret[1], table.pack(table.unpack(ret, 2))
    end
end

--- Packs an iterator's return values into tables.
-- Transforms the passed iterator triplet (fn, state, init) into a nullary closure which maintains iterator state via upvalues and returns a single table containing all return values of the original iterator.
-- After the iterator is exhausted (i.e., returns nil, ...), it is "reset" so that it can be called again without error.
-- @param fn Generator function (first of iterator triplet)
-- @param state Invariant state (second of iterator triplet)
-- @param init Initial value of control variable (third of iterator triplet)
-- @return Nullary iterator function (i.e., state == ctrl == null)
function pkg.pack(fn, state, init)
    local vals = {init}
    return function ()
        vals = {fn(state, vals[1])}
        if vals[1] then
            return vals
        else
            vals = {init}
        end
    end
end

--- Applies standard Lua select function to iterator outputs.
-- Interposes a call to select() with the supplied index before the values returned by the passed iterator triplet are returned to the caller.
-- @param idx Index to pass to select
-- @param fn Generator function (first of iterator triplet)
-- @param ... Remainder of iterator triplet (state and control variable)
-- @return New iterator triplet with the same state and control variables as the original but with generator composed with select
function pkg.select(idx, fn, inv_state, init)
    local curr = init
    local function restricted(state)
        local ret = table.pack(fn(state, curr))
        curr = ret[1]
        if curr then
            -- Use field ret[n] provided by table.pack
            -- This ensures that nil return values don't cut off subsequent values
            return table.unpack(ret, idx, ret.n)
        else
            -- "Reset" iterator for future use
            curr = init
        end
    end
    return restricted, inv_state
end

--- Call a function for each value returned by iterator.
-- @param func Function to apply
-- @param iter Iterator function to map over
-- @param state Invariant state to pass to `iter`
-- @param init Initial control variable to pass to `iter`
function pkg.foreach(func, iter, state, init)
    for ctrl, tab in canonicalize(iter), state, init do
        func(ctrl, table.unpack(tab))
    end
end

function gen.zip_ipairs(lists, idx)
    idx = idx + 1
    local ret, vals, val = false, {}, nil
    for _,l in ipairs(lists) do
        val = l[idx]
        ret = ret or val
        table.insert(vals, val)
    end
    if ret then
        return idx, table.unpack(vals)
    end
end

--- Zips passed lists, generating ordered tuples (idx, l1[idx], ...).
-- @arg ... Lists to zip
-- @return Ordered tuples (idx, ..., lj[idx], ...) for each value of idx such that at least one of lj[idx] is non-null
function pkg.zip_ipairs(...)
    local args = {...}
    return gen.zip_ipairs, args, 0
end

function gen.heap.trees(h, all)
    local curr, shift = #h, 0
    local function gen_nonempty()
        if curr ~= 0 then
            while curr % 2 == 0 do
                curr = curr >> 1
                shift = shift + 1
            end
            curr = curr >> 1
            shift = shift + 1
            return shift-1, h[shift]
        end
    end
    local function gen_all()
        if curr ~= 0 then
            shift = shift + 1
            curr = curr >> 1
            return shift-1, h[shift]
        end
    end
    if all then
        return gen_all
    else
        return gen_nonempty
    end
end

function pkg.heap.trees_all(h)
    return gen.heap.trees(h, true)
end

function pkg.heap.trees_nonempty(h)
    return gen.heap.trees(h, false)
end

function gen.reverse_ipairs(tbl, idx)
    idx = idx - 1
    if idx > 0 then
        return idx, tbl[idx]
    end
end

function pkg.reverse_ipairs(tbl)
    return gen.reverse_ipairs, tbl, #tbl+1
end

-- @param data_ctor Function to enqueue nodes to examine
-- @param predicate Condition to search for
function recurse(iter, data_ctor, predicate)
	-- First coroutine: recursive iterable to search produces child values
    -- Second coroutine: "validator" / "dispatcher"
    -- Third coroutine: Abstract datastructure handles dispatched nodes and produces next
    local function examine_node(node)
        while node and not predicate(node) do
            node = coroutine.yield(node.children)
        end
        return node
    end
    local function dispatch(...)
        local nodes = table.pack(...)
        while true do
            local queue = data_ctor(table.unpack(nodes))
            nodes = table.pack(coroutine.yield(queue:pop()))
        end
    end
end

return pkg
