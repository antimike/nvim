local pkg = {
    heap = {},
    tree = {},
    queue = {}
}

local function gen_trees(h)
    local N, idx = h.N, 1
    while N ~= 0 do
        if h[idx] then
            coroutine.yield(idx-1, h[idx])
        end
        N = N >> 1
        idx = idx + 1
    end
end

function pkg.heap.trees(h)
    return coroutine.wrap(function () gen_trees(h) end)
end

return pkg
