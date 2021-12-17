local binom = {
    tree = {},
    heap = {},
    priv = {}
}

function binom.priv.sort_pair(a, b, default, leq)
    a = a or default
    b = b or default
    leq = leq or function (x,y) return x<=y end
    if not a then
        return a, b
    elseif not b then
        return b, a
    elseif leq(a, b) then
        return a, b
    else
        return b, a
    end
end

local binom_tree_mt = {
    __le = function (a,b)
        if a and b then
            return a.leq(a[0], b[0])
        else
            return not a
        end
    end,
    __index = binom.tree,
    __add = binom.tree.merge,
    __concat = binom.tree.merge,
    __tostring = binom.tree.print
}

function binom.tree.factory(leq)
    leq = leq or function (x,y) return x <= y end
    local function new(val, ...)
        local args = {...}
        args.leq = leq
        args[0] = val
        setmetatable(args, binom_tree_mt)
        return args
    end
    return new
end

function binom.tree.merge(t1, t2)
    -- TODO: Add assert to enforce #t1 == #t2?
    if t1 and t2 then
        local x, y = binom.priv.sort_pair(t1, t2)
        table.insert(y, x)
        return y
    else
        return t1 or t2
    end
end

-- Prints an ASCII representation of a binomial tree
function binom.tree.print(t, prefix)
    prefix = prefix or ""
    io.stdout:write(prefix, t[0], "\n")
    local first = "|"
    for i=#t, 1, -1 do
        if i == 1 then first = " " end
        io.stdout:write(prefix, first, "\\", "\n")
        binom.tree.print(t[i], prefix .. first .. " ")
    end
end

local binom_heap_mt = {
    __index = binom.heap,
    __add = binom.heap.merge,
    __concat = binom.heap.merge,
    __le = function (h1, h2)
        if not (h1 and h2) then
            return h2
        elseif not (h1.max and h2.max) then
            return h2.max
        else
            return h1.max <= h2.max
        end
    end,
    __tostring = function (h)
        for t in h:trees() do
            t:print()
        end
    end
}

function binom.heap.new(leq)
    local ret = {
        factory = binom.tree.factory(leq),
        max = nil,
        N = 0,
    }
    setmetatable(ret, binom_heap_mt)
    return ret
end

function binom.heap.add_tree(h, t)
    local idx = -2      -- Has to be -2 to avoid overwriting h[0] in edge case t == nil
    h.N = h.N + (1 << #t)
    while t and #t > idx do
        idx = #t
        t = binom.tree.merge(h[idx+1], t)
        h[idx+1] = nil
    end
    h[idx+1] = t
    if h.max <= t then
        h.max = t
    end
end

function binom.priv.trees_gen(h)
    local N, idx = h.N, 1
    while N ~= 0 do
        if h[idx] then
            coroutine.yield(h[idx])
        end
        N = N >> 1
        idx = idx + 1
    end
end

function binom.heap.trees(h)
    return coroutine.wrap(function () binom.priv.trees_gen(h) end)
end

function binom.heap.merge(h1, h2)
    for t in h2:trees() do
        h1:add_tree(t)
    end
end

function binom.heap.insert(h, elem)
    h:add_tree(h.factory(elem))
end

return binom
