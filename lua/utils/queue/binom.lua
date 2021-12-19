local iter = require("utils.queue.iter")
local tree = require("utils.queue.binom_tree")
local pkg = {}

local mt = {
    __index = pkg,
    __add = pkg.merge,
    __concat = pkg.merge,
    __le = function (h1, h2)
        if not (h1 and h2) then
            return h2
        elseif not (h1.max and h2.max) then
            return h2.max
        else
            return h1.max <= h2.max
        end
    end,
    __ipairs = iter.heap.trees,
    __tostring = function (h)
        for t in h:trees() do
            t:print()
        end
    end
}

function pkg.new(leq)
    local ret = {
        factory = tree.factory(leq),
        max = nil,
        N = 0,
    }
    setmetatable(ret, mt)
    return ret
end

function pkg.add_tree(h, t)
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
    for t in h2:trees() do
        h1:add_tree(t)
    end
end

function pkg.insert(h, elem)
    h:add_tree(h.factory(elem))
end

return pkg
