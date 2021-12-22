local iter = require("utils.queue.iter")
local tree = require("utils.queue.binom_tree")
local pkg = {}
local priv = {}

function pkg.new(leq)
    local ret = {
        factory = tree.factory(leq),
        max = nil,
        N = 0,
    }
    setmetatable(ret, priv.mt)
    return ret
end

function priv.add_tree(h, t)
    local idx = -2      -- Has to be -2 to avoid overwriting h[0] in edge case t == nil
    h.N = h.N + (1 << #t)
    while t and #t > idx do
        idx = #t
        t = tree.merge(h[idx+1], t)
        h[idx+1] = nil
    end
    h[idx+1] = t
    if h.max <= t then
        h.max = t
    end
end

function pkg.merge(h1, h2)
    for _, t in ipairs(h2) do
        priv.add_tree(h1, t)
    end
end

function pkg.insert(h, elem)
    priv.add_tree(h, h.factory(elem))
end

function pkg.next(h)
    local max_subtree = h.max
    h[#max_subtree+1] = nil
    h.max = nil
    h.N = h.N - (1 << #max_subtree)
    for _, t in ipairs(max_subtree) do
        priv.add_tree(h, t)
    end
    return max_subtree[0]
end

function pkg.peek(h)
    return h.max[0]
end

function priv.leq(h1, h2)
    if not (h1 and h2) then
        return h2
    elseif not (h1.max and h2.max) then
        return h2.max
    else
        return h1.max <= h2.max
    end
end

function priv.tostring(h)
    local ret = ""
    for ord, t in iter.heap.trees_all(h) do
        ret = ret .. "\nOrder " .. ord .. ":"
        if t then
            ret = ret .. "\n" .. t:format("  ")
        else
            ret = ret .. " Empty"
        end
    end
    return ret
end

priv.mt = {
    __index = pkg,
    __add = pkg.merge,
    __concat = pkg.merge,
    __le = priv.leq,
    __ipairs = iter.heap.trees_nonempty,
    __tostring = priv.tostring,
    __len = function(h) return h.N end
}

pkg.trees = iter.heap.trees_nonempty
pkg.pop = pkg.next
pkg.push = pkg.insert

return pkg
