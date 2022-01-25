local iter = require("utils.iter")
local pkg = {}

--- Partial function application.
-- @param fn Function to partially apply
-- @param ... Args to apply fn to.  Any nil values in the passed list will be
-- considered "gaps" to be filled when calling the resulting function.
-- @return Function which concatenates its args with ... and passes to fn.
function pkg.curry(fn, ...)
    local args = table.pack(...)
    return function (...)
        local passed = table.pack(...)
        for i = 1, args.n do
            if args[i] ~= nil then
                table.insert(passed, i, args[i])
            end
        end
        return fn(table.unpack(passed))
    end
end

-- TODO: Expand on this idea
function pkg.tensor(fn)
    return function (tuple)
        return pkg.contract(fn, tuple)
    end
end

--- Functional version of get operator.
-- Analagous to rawget, but doesn't bypass metatables
-- @param obj Table to access
-- @param key Key to get
-- @return Value of obj[key]
function pkg.get(obj, key)
    return obj[key]
end

--- Lua implementation of standard reduce function.
-- @param acc Accumulator function to fold over iterable
-- @param seed Initial value to pass to acc
-- @param fn Generator function (first of iterator triplet)
-- @param inv_state Invariant state (second of iterator triplet)
-- @param init Initial control variable (third of iterator triplet)
-- @return Value of acc folded over iterable
function pkg.reduce(acc, seed, fn, inv_state, init)
    local ret = seed
    for vals in iter.pack(fn, inv_state, init) do
        ret = acc(ret, table.unpack(vals))
    end
    return ret
end

--- Map a function over an iterator triplet.
-- @param fn Function to map
-- @param ... Iterator triplet (function, state, control variable)
-- @return Iterator function returning mapped values
function pkg.map(fn, ...)
    local it = iter.pack(...)
    return coroutine.wrap(
        function ()
            for val in it do
                coroutine.yield(fn(vals and table.unpack(vals)))
            end
        end
    )
end

--- Compose functions.
-- @param ... Functions to compose
-- @return Composition of passed functions
function pkg.comp(...)
    args = {...}
    return pkg.reduce(
        function (f, g) return function (...) return f(g(...)) end end,
        pkg.id,
        iter.select(2, ipairs(args))
    )
end

--- Identity function of arbitrary arity.
-- Useful as (e.g.) the "seed" value of a reducer acting on a list of functions.
-- @param ... Params to return
-- @return Passed parameters
function pkg.id(...)
    return ...
end

--- Trivial function (i.e., always-nil).
-- @param ... Parameters
-- @return nil
function pkg.trivial(...)
    return nil
end

--- Apply cycle 1->2, 2->3, ..., n->1 to passed args.
-- If n arguments are passed, apply an n-cycle and return the resulting permutation of the arguments.
-- @param ... Parameters to permute
-- @return Permuted parameters
function pkg.cycle(...)
    local args = table.pack(...)
    last, args[args.n], args.n = args[args.n], nil, args.n - 1
    return last, table.unpack(args)
end

--- Apply a function n times.
-- @param fn Function to apply
-- @param n Number of times to iterate fn
-- @return Functional power fn^n
function pkg.apply_n(fn, n)
    return function (...)
        local ret = table.pack(...)
        for i = 1, n do
            ret = table.pack(fn(table.unpack(ret)))
        end
        return table.unpack(ret)
    end
end

--- Add values.
-- @param tot First value
-- @param val Second value
-- @return Sum
function pkg.add(tot, val)
    if not val then
        coroutine.yield(tot)
    end
    while true do
        tot = tot + val
        coroutine.yield(tot)
    end
end

--- "Fallback" composition of functions.
-- @param ... Functions to try and / or fallback values
-- @return "Fallback composition" of passed functions, i.e., the equivalent of
-- reduce(function (f, g) return function (...) return f(...) or g(...) end end, ...)
function pkg.switch(...)
    local opts = table.pack(...)
    return function (...)
        local ret, idx = nil, 1
        while ret == nil and idx <= opts.n do
            ret = opts[idx]
            if type(ret) == "function" then
                ret = ret(...)
            elseif type(ret) == "table" then
                ret = pkg.table(ret)
            end
            idx = idx + 1
        end
        return ret
    end
end

--- Construct getter for passed table.
-- @param tab Table to construct getter for
-- @return Getter for passed table
function priv.table(tab)
    return function(...)
        -- Only passes the last arg
        -- This is to allow treating the wrapped function as a metatable-style
        -- __index function or as a 1-ary key-value mapping
        return tab[select(-1, ...)]
    end
end

return pkg
