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
        local passed = {...}
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

--- Functional version of get operator
-- Analagous to rawget, but doesn't bypass metatables
-- @param obj Table to access
-- @param key Key to get
function pkg.get(obj, key)
    return obj[key]
end

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

function pkg.comp(...)
    args = {...}
    return pkg.reduce(
        function (f, g) return function (...) return f(g(...)) end end,
        pkg.id,
        iter.select(2, ipairs(args))
    )
end

function pkg.id(...)
    return ...
end

function pkg.trivial(...)
    return nil
end

function pkg.cycle(...)
    local args = {...}
    table.insert(args, 1, table.remove(args))
    return table.unpack(args)
end

function pkg.add(tot, val)
    if not val then
        coroutine.yield(tot)
    end
    while true do
        tot = tot + val
        coroutine.yield(tot)
    end
end

return pkg
