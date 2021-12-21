local sort = require("util.sort")
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

-- TODO: Refactor to use upvalues instead of coroutines to maintain state?
function gen.heap.trees(h)
    local N, idx = h.N, 1
    while N ~= 0 do
        coroutine.yield(idx-1, h[idx])
        N = N >> 1
        idx = idx + 1
    end
end

function pkg.heap.trees(h)
    return coroutine.wrap(function () gen.heap.trees(h) end)
end

function pkg.reverse_ipairs(tbl)
    local function wrapped(t, idx)
        idx = idx - 1
        if idx > 0 then
            return idx, t[idx]
        end
    end
    return wrapped, tbl, #tbl+1
end

return pkg
