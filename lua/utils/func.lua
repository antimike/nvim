local iter = require("utils.iter")
local pkg = {}

function pkg.curry(fn, ...)
    local args = {...}
    return function (...)
        local passed = {...}
        for i = 1, #args do
            if args[i] then
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

function pkg.map(fn, ...)
    local args = {...}
    return coroutine.wrap(
        function ()
            for val in iter.canonicalize(table.unpack(args)) do
                coroutine.yield(fn(val))
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
--     return function (...)
--         local ret = {...}
--         for i = #args, 1, -1 do
--             ret = table.pack(args[i](table.unpack(ret)))
--         end
--         return table.unpack(ret)
--     end
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
