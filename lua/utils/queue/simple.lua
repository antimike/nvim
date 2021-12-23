local pkg = {}
local priv = {}

function priv.tostring(q)
    local ret = {}
    for _, elem in ipairs(q) do
        table.insert(ret, q.pri[elem] .. ": " .. tostring(elem))
    end
    return table.concat(ret, "\n")
end

function priv.sort(q)
    table.sort(q.elems, function (a, b) return q.pri[a] < q.pri[b] end)
end

function priv.get(q, idx)
    return q.elems[idx]
end

function priv.set(q, pri, elem)
    pri = pri or q.pri[q.elems[#q]] + 1
    q.pri[elem] = pri
    table.insert(q.elems, elem)
    priv.sort(q)
end

function priv.pop(q)
    if #q > 0 then
        local ret = table.remove(q.elems, 1)
        q.pri[ret] = nil
        return ret
    end
end

priv.root_mt = {
    __index = pkg,
}

function pkg.new()
    local ret = { elems = {}, pri = {}, }
    local mt = {
        __index = ret.elems,
        __newindex = priv.set,
        __tostring = priv.tostring,
        __len = function (q) return #q.elems end,
    }
    setmetatable(ret, mt)
    setmetatable(ret.elems, priv.root_mt)
    return ret
end

function pkg.next(q)
    return priv.pop(q)
end

function pkg.peek(q)
    return q.elems[1]
end

pkg.pop = pkg.next

return pkg
